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
  final String pathId;

  const MetaHandler({super.key, required this.layout, this.options, required this.pathId });

  @override
  _MetaHandlerState createState() => _MetaHandlerState();
}

class _MetaHandlerState extends State<MetaHandler> {
  @override
  Widget build(BuildContext context) {
    switch (widget.layout["type"]) {
      case "tab":
        return MetaTab(tabLayout: widget.layout, pathId: "${widget.pathId}.tab",);
      case "card":
        return MetaCard(layout: widget.layout, pathId: "${widget.pathId}.card",);
      case "checkbox":
        return const MetaCheckbox();
      case "increaseDecrease":
        return MetaIncreaseDecrease(
          stateKey: widget.layout["ref"],
        );
      case "text":
        return MetaText(layout: widget.layout, pathId: "${widget.pathId}.text");
      case "input":
        return MetaTextInput(layout: widget.layout);
      case "horizontalContainer":
        return MetaHorizontalContainer(layout: widget.layout, pathId: "${widget.pathId}.horizontalContainer",);
      case "verticalContainer":
        return MetaVerticalContainer(layout: widget.layout, pathId: "${widget.pathId}.verticalContainer",);
      case "deckManagement":
        return MetaDeckManagement(layout: widget.layout, pathId: "${widget.pathId}.deckManagement",);
      case "list":
        return MetaList(layout: widget.layout);
      case "customListManagement":
        return MetaCustomListManagement(layout: widget.layout, pathId: "${widget.pathId}.customListManagement");
      default:
        return Container();
    }
  }
}
