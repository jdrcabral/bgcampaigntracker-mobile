import 'package:campaigntrackerflutter/data/models/campaign.dart';
import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MetaHandler extends StatefulWidget {
  final Map<String, dynamic> layout;
  const MetaHandler({Key? key, required this.layout})
      : super(key: key);

  @override
  _MetaHandlerState createState() =>
      _MetaHandlerState();
}

class _MetaHandlerState extends State<MetaHandler> {
  @override
  Widget build(BuildContext context) {
    switch(widget.layout["type"]) {
        case "tab":
          return MetaTab(tabLayout = layout);
        case "card":
          return MetaCard();
        case "checkbox":
          return MetaCheckbox();
        case "increaseDecrease":
          return MetaIncreaseDecrease();
        case "text":
          return Text(
            widget.layout["label"],
            style: TextStyle(fontSize: widget.layout["size"] ?? 20),
          );
        case "input":
          return MetaTextInput(layout = layout)
        default:
            return Container();
    }
  }
}
