import 'package:flutter/material.dart';

class MetaCard extends StatelessWidget {
  final String title;
  const MetaCard(
      {Key? key,
      required this.title,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          debugPrint('Card tapped.');
          // Navigator.pushNamed(context, '/campaigns');
        },
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          ListTile(
            leading: Icon(Icons.gamepad),
            title: Text(title),
            subtitle: Text('Updated at:'),
          ),
        ]),
      ),
    );
  }
}
