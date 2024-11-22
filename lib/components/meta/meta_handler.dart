import 'package:campaigntrackerflutter/components/meta/meta_card.dart';
import 'package:campaigntrackerflutter/components/meta/meta_checkbox.dart';
import 'package:campaigntrackerflutter/components/meta/meta_custom_list_management.dart';
import 'package:campaigntrackerflutter/components/meta/meta_deck_management.dart';
import 'package:campaigntrackerflutter/components/meta/meta_horizontal_container.dart';
import 'package:campaigntrackerflutter/components/meta/meta_increase_decrease.dart';
import 'package:campaigntrackerflutter/components/meta/meta_list.dart';
import 'package:campaigntrackerflutter/components/meta/meta_tab.dart';
import 'package:campaigntrackerflutter/components/meta/meta_text.dart';
import 'package:campaigntrackerflutter/components/meta/meta_text_input.dart';
import 'package:campaigntrackerflutter/components/meta/meta_vertical_container.dart';
import 'package:flutter/material.dart';

class MetaHandler extends StatefulWidget {
  final Map<String, dynamic> layout;
  final Map<String, dynamic>? options;

  const MetaHandler({super.key, required this.layout, this.options });

  @override
  _MetaHandlerState createState() => _MetaHandlerState();
}

class _MetaHandlerState extends State<MetaHandler> {
  @override
  Widget build(BuildContext context) {
    switch (widget.layout["type"]) {
      case "tab":
        return MetaTab(tabLayout: widget.layout);
      case "card":
        return MetaCard(layout: widget.layout);
      case "checkbox":
        return MetaCheckbox();
      case "increaseDecrease":
        return MetaIncreaseDecrease(
          stateKey: widget.layout["ref"],
        );
      case "text":
        return Text(
          widget.layout["label"],
          style: TextStyle(fontSize: widget.layout["size"] ?? 20),
        );
      case "input":
        return MetaTextInput(layout: widget.layout);
      case "horizontalContainer":
        return MetaHorizontalContainer(layout: widget.layout);
      case "verticalContainer":
        return MetaVerticalContainer(layout: widget.layout);
      case "deckManagement":
        return MetaDeckManagement(layout: widget.layout);
      case "list":
        return MetaList(layout: widget.layout);
      case "customListManagement":
        return MetaCustomListManagement(layout: widget.layout);
      default:
        return Container();
    }
  }
}
