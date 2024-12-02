import 'package:campaigntrackerflutter/components/meta/meta_handler.dart';
import 'package:flutter/material.dart';

class MetaCard extends StatelessWidget {
  final Map<String, dynamic> layout;
  final String pathId;
  const MetaCard(
      {super.key,
      required this.layout,
      required this.pathId,});

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
        child: MetaHandler(layout: layout["child"], pathId: pathId,),
      ),
    );
  }
}
