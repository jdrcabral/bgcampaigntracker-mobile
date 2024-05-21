import 'package:campaigntrackerflutter/components/meta/meta_handler.dart';
import 'package:flutter/material.dart';

class MetaCard extends StatelessWidget {
  final Map<String, dynamic> layout;
  const MetaCard(
      {Key? key,
      required this.layout,})
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
        child: MetaHandler(layout: layout["child"]),
      ),
    );
  }
}
