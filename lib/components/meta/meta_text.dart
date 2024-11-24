<<<<<<< Updated upstream
import 'package:campaigntrackerflutter/data/models/campaign.dart';
import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MetaText extends StatefulWidget {
  final Map<String, dynamic> layout;
  const MetaText({Key? key, required this.layout})
      : super(key: key);

  @override
  _MetaTextState createState() =>
      _MetaTextState();
}

class _MetaTextState extends State<MetaText> {
  @override
  Widget build(BuildContext context) {
    switch (widget.layout["inputType"]) {
      case "multiline":
        return TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
        );
      case "number":
        return TextField(
          keyboardType: TextInputType.number
        );
      default:
        return TextField();
    }
=======
import 'package:campaigntrackerflutter/components/meta/meta_handler.dart';
import 'package:campaigntrackerflutter/components/meta/utils/path_handler.dart';
import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:campaigntrackerflutter/models/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MetaText extends StatelessWidget {
  final Map<String, dynamic> layout;
  final String pathId;

  const MetaText({super.key, required this.layout, required this.pathId});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, build) {
      if (layout.containsKey("ref")) {
        String reference = layout["ref"].toString();
        if (reference.contains("index")) {
          int extractedIndex = PathHandler.extractLastIndex(pathId);
          String updatedReference = reference.replaceFirst("index", extractedIndex.toString());
          Map<String, dynamic> gameState = ref
              .watch(campaignSavedStatusProvider)
              .savedState;
          dynamic extractedValue = StateExtractor.retrieveReference(gameState, updatedReference.split("."));
          return Text(
            extractedValue.toString(),
            style: TextStyle(fontSize: layout["size"] ?? 20),
          );
        }
      }
      return Text(
        layout["label"],
        style: TextStyle(fontSize: layout["size"] ?? 20),
      );
    });
>>>>>>> Stashed changes
  }
}
