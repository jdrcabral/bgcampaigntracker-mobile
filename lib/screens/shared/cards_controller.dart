import 'package:campaigntrackerflutter/components/card_navigator.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CardsController extends StatefulWidget {
  final String title;
  const CardsController({Key? key, required this.title}) : super(key: key);

  @override
  _CardsControllerState createState() => _CardsControllerState();
}

const List<String> list = <String>[
  'One',
  'Two',
  'Three',
  'Four',
  'Five',
  'Six',
  'Seven',
  'Eight',
  'Nine',
  'Ten',
  'Eleven',
  'Twelve',
  'Thirten',
  'Fourten',
  'Fiveten',
  'Sixten',
  'Seventen',
  'Eighten',
];

const List<String> items = [
  "003 Key",
  "Acid Rounds",
  "Aqua Ring Key",
  "Armour Key",
  "Assault Shotgun",
  "Battery",
];

class _CardsControllerState extends State<CardsController>
    with SingleTickerProviderStateMixin {
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
          itemCount: items.length,
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
                        items[index],
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
                    enableIMEPersonalizedLearning: ,
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
              //disabledItemFn: (String s) => s.startsWith('I'),
            ),
            items: list,
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Card Selector",
                hintText: "select card",
              ),
            ),
            onChanged: print,
            selectedItem: "",
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Add'),
              onPressed: () {
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
