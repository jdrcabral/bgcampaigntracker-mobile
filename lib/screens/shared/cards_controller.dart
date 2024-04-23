import 'package:campaigntrackerflutter/components/card_navigator.dart';
import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:campaigntrackerflutter/models/resident_evil_campaign_notifier.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardsController extends StatefulWidget {
  final String title;
  final String stateKey;
  final List<dynamic> options;
  final List<dynamic> items;
  const CardsController(
      {Key? key,
      required this.title,
      required this.stateKey,
      required this.options,
      required this.items})
      : super(key: key);

  @override
  _CardsControllerState createState() => _CardsControllerState();
}

class _CardsControllerState extends State<CardsController>
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
          itemCount: widget.items.length,
          itemBuilder: (context, index) => Card(
            surfaceTintColor: Colors.grey[350],
            shadowColor: Colors.black,
            borderOnForeground: true,
            child: Container(
              child: Column(children: [
                Row(children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 10.0),
                      child: Text(
                        widget.items[index],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
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
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
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
            items: _castListToString(widget.options),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
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
                Provider.of<ResidentEvilCampaignNotifier>(context,
                        listen: false)
                    .addValue(widget.stateKey, selectedItem);
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
