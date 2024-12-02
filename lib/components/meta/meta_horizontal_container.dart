import 'package:campaigntrackerflutter/components/meta/meta_handler.dart';
import 'package:flutter/material.dart';

class MetaHorizontalContainer extends StatelessWidget {
  final Map<String, dynamic> layout;
  final String pathId;
  const MetaHorizontalContainer(
      {super.key,
      required this.layout,
      required this.pathId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: (layout["children"] as List<dynamic>).map((e) => MetaHandler(layout: e, pathId: pathId,)).toList(),
    );
  }
}
