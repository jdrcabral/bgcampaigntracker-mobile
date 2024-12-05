import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:campaigntrackerflutter/utils/reference_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MetaTextInput extends ConsumerStatefulWidget {
  final Map<String, dynamic> layout;
  final String pathId;
  const MetaTextInput({super.key, required this.layout, required this.pathId});

  @override
  _MetaTextInputState createState() =>
      _MetaTextInputState();
}

class _MetaTextInputState extends ConsumerState<MetaTextInput> {
  
  void _updateText(String text) {
    String replacedRef = ReferenceLoader.replaceRefIndex(widget.layout["ref"], widget.pathId);
    ref.read(campaignSavedStatusProvider.notifier).update((state) {
      CampaignSavedStatus clonedState = state.clone();
      clonedState.updateNestedValue(replacedRef, text);
      return clonedState;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController(text: '');
    String replacedRef = ReferenceLoader.replaceRefIndex(widget.layout["ref"], widget.pathId);
    dynamic state = ref
                  .watch(campaignSavedStatusProvider).savedState;
    dynamic fetchedValue = ReferenceLoader.retrieveReference(state, replacedRef.split('.'));
    if (fetchedValue.runtimeType == String) {
      textController.text = fetchedValue;
    }
    switch (widget.layout["inputType"]) {
      case "multiline":
        return TextField(
          controller: textController,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          onChanged: _updateText,
        );
      case "number":
        return TextField(
          controller: textController,
          keyboardType: TextInputType.number,
          onChanged: _updateText,
        );
      default:
        return TextField(
          controller: textController,
          onChanged: _updateText,
        );
    }
  }
}
