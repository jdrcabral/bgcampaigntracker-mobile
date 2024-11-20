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
  }
}
