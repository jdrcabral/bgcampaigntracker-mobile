import 'package:campaigntrackerflutter/data/models/campaign.dart';
import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MetaTextInput extends StatefulWidget {
  final Map<String, dynamic> layout;
  const MetaTextInput({Key? key, required this.layout})
      : super(key: key);

  @override
  _MetaTextInputState createState() =>
      _MetaTextInputState();
}

class _MetaTextInputState extends State<MetaTextInput> {
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
