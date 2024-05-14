import 'package:campaigntrackerflutter/components/meta/meta_handler.dart';
import 'package:flutter/material.dart';

class MetaHorizontalContainer extends StatelessWidget {
  final Map<String, dynamic> layout;
  const MetaHorizontalContainer(
      {super.key,
      required this.layout,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: (layout["children"] as List<dynamic>).map((e) => MetaHandler(layout: e)).toList(),
    );
  }
}
