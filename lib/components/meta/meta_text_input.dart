import 'package:flutter/material.dart';

class MetaTextInput extends StatefulWidget {
  final Map<String, dynamic> layout;
  const MetaTextInput({super.key, required this.layout});

  @override
  _MetaTextInputState createState() =>
      _MetaTextInputState();
}

class _MetaTextInputState extends State<MetaTextInput> {
  @override
  Widget build(BuildContext context) {
    switch (widget.layout["inputType"]) {
      case "multiline":
        return const TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
        );
      case "number":
        return const TextField(
          keyboardType: TextInputType.number
        );
      default:
        return const TextField();
    }
  }
}
