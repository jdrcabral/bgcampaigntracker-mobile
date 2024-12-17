import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:campaigntrackerflutter/utils/reference_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MetaCheckbox extends ConsumerStatefulWidget {
  final Map<String, dynamic> layout;
  final String pathId;

  const MetaCheckbox({super.key, required this.layout, required this.pathId});

  @override
  _MetaCheckboxState createState() => _MetaCheckboxState();
}

class _MetaCheckboxState extends ConsumerState<MetaCheckbox>
    with SingleTickerProviderStateMixin {

  void updateCheckBox(bool? value) {
    if (value == null) return;
    String replacedRef = ReferenceLoader.replaceRefIndex(widget.layout["ref"], widget.pathId);
    ref.read(campaignSavedStatusProvider.notifier).update((state) {
      CampaignSavedStatus clonedState = state.clone();
      clonedState.updateNestedValue(replacedRef, value);
      return clonedState;
    });
  }

  @override
  Widget build(BuildContext context) {
      String replacedRef = ReferenceLoader.replaceRefIndex(widget.layout["ref"], widget.pathId);
      dynamic state = ref
                    .watch(campaignSavedStatusProvider).savedState;
      dynamic retrievedReference = ReferenceLoader.retrieveReference(state, replacedRef.split('.'));
      return Checkbox(value: retrievedReference, onChanged: updateCheckBox);
  }
}