import 'package:campaigntrackerflutter/components/meta/meta_handler.dart';
import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardsController extends ConsumerStatefulWidget {
  final String title;
  final String stateKey;
  final List<dynamic> options;
  final List<dynamic> items;
  final Map<String, dynamic>? component;
  final String pathId;
  const CardsController(
      {super.key,
      required this.title,
      required this.stateKey,
      required this.options,
      required this.items,
      required this.pathId,
      this.component });

  @override
  _CardsControllerState createState() => _CardsControllerState();
}

class _CardsControllerState extends ConsumerState<CardsController>
    with SingleTickerProviderStateMixin {
  String selectedItem = "";
  List<String> _castListToString(List<dynamic> list) {
    return [
      for (var element in list)
        if (element is String) element
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: ref.watch(campaignSavedStatusProvider).savedState[widget.stateKey].length,
          itemBuilder: (context, index) {
            if (widget.component != null) {
              return MetaHandler(layout: widget.component!, pathId: "${widget.pathId}.$index",);
            }
            return Card(
              surfaceTintColor: Colors.grey[350],
              shadowColor: Colors.black,
              borderOnForeground: true,
              child: Column(children: [
                  Row(children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0),
                        child: Text(
                          ref.watch(campaignSavedStatusProvider).savedState[widget.stateKey][index],
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {
                          ref.read(campaignSavedStatusProvider.notifier).update((state) {
                            CampaignSavedStatus clonedState = state.clone();
                            if (clonedState.savedState[widget.stateKey] is List) {
                              (clonedState.savedState[widget.stateKey] as List<dynamic>).removeAt(index);
                            }
                            return clonedState;
                          });
                          // Add functionality to delete the card here
                        },
                        alignment: Alignment.topRight,
                      ),
                    ),
                  ]),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 10.0),
                    child: const TextField(
                      decoration: InputDecoration(
                        labelText: 'Notes',
                      ),
                    ),
                  ),
                ]),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          selectedItem = "";
          _dialogBuilder(context, widget.title);
        },
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context, String title) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: DropdownSearch<String>(
            popupProps: const PopupProps.menu(
              showSearchBox: true,
              showSelectedItems: true,
            ),
            items: (f, cs) => _castListToString(widget.options),
            decoratorProps: const DropDownDecoratorProps(
              decoration: InputDecoration(
                labelText: "Card Selector",
                hintText: "select card",
              ),
            ),
            onChanged: (value) {
              selectedItem = value ?? "";
            },
            selectedItem: selectedItem,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Add'),
              onPressed: () {
                ref.read(campaignSavedStatusProvider.notifier).update((state) {
                  CampaignSavedStatus clonedState = state.clone();
                  if (clonedState.savedState[widget.stateKey] is List) {
                    (clonedState.savedState[widget.stateKey] as List<dynamic>).add(selectedItem);
                  }
                  return clonedState;
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
