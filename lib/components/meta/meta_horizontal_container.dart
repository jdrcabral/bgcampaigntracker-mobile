import 'package:campaigntrackerflutter/components/meta/meta_handler.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class MetaHorizontalContainer extends StatelessWidget {
  final Map<String, dynamic> layout;
  final String pathId;
  const MetaHorizontalContainer(
      {super.key,
      required this.layout, required this.pathId});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: (layout["children"] as List<dynamic>).mapIndexed((index, e) => MetaHandler(layout: e, pathId: pathId)).toList(),
    );
  }
}
