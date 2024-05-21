import 'package:campaigntrackerflutter/components/meta/meta_handler.dart';
import 'package:campaigntrackerflutter/models/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MetaList extends StatelessWidget {
  final Map<String, dynamic> layout;
  const MetaList(
      {super.key,
        required this.layout,});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, build) {
      return Expanded(child: ListView.builder(
          itemCount: ref
          .watch(componentsProvider)
          .components["characters"]
          ?.length ??
          0,
      itemBuilder: (context, index) {
            return Text(ref.watch(componentsProvider).components["characters"][index]);
    }));
  });
}
  }
