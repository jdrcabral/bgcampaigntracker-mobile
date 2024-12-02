import 'package:flutter/material.dart';
import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:campaigntrackerflutter/utils/reference_loader.dart';
class MetaText extends ConsumerStatefulWidget {
  final Map<String, dynamic> layout;
  final String pathId;
  const MetaText({super.key, required this.layout, required this.pathId});

  @override
  _MetaTextState createState() =>
      _MetaTextState();
}

class _MetaTextState extends ConsumerState<MetaText> {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: widget.layout["size"] ?? 20);
    if (widget.layout.containsKey("ref")) {
      String replacedRef = ReferenceLoader.replaceRefIndex(widget.layout["ref"], widget.pathId);
      dynamic state = ref
                    .watch(campaignSavedStatusProvider).savedState;
      return Text(
        ReferenceLoader.retrieveReference(state, replacedRef.split('.')),
        style: textStyle,
      );
    }
    return Text(
      widget.layout["label"],
      style: textStyle,
    );
  }
}
