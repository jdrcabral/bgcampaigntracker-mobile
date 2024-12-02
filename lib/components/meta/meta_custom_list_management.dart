import 'package:campaigntrackerflutter/components/card_navigator.dart';
import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:campaigntrackerflutter/models/components.dart';
import 'package:campaigntrackerflutter/screens/shared/cards_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MetaCustomListManagement extends ConsumerStatefulWidget {
  final Map<String, dynamic> layout;
  final String pathId;
  const MetaCustomListManagement({super.key, required this.layout, required this.pathId });

  @override
  _MetaCustomListManagement createState() =>
      _MetaCustomListManagement();
}


class _MetaCustomListManagement extends ConsumerState<MetaCustomListManagement> {
  @override
  Widget build(BuildContext context) {
    return CardNavigator(
        cardTitle: widget.layout["label"],
        navigateTo: CardsController(
          title: widget.layout["label"],
          stateKey: widget.layout["ref"],
          options: ref.watch(componentsProvider).components[widget.layout["source"]],
          items: ref
              .watch(campaignSavedStatusProvider)
              .savedState[widget.layout["ref"]],
          component: widget.layout["component"],
          pathId: widget.pathId,
        ));
  }
}
