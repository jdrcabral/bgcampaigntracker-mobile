import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:campaigntrackerflutter/utils/reference_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MetaIncreaseDecrease extends ConsumerStatefulWidget {
  final Map<String, dynamic> layout;
  final String pathId;
  final MainAxisAlignment mainAxisAlignment;
  const MetaIncreaseDecrease({super.key, required this.layout, this.mainAxisAlignment = MainAxisAlignment.center, required this.pathId});

  @override
  _MetaIncreaseDecreaseState createState() =>
      _MetaIncreaseDecreaseState();
}

class _MetaIncreaseDecreaseState extends ConsumerState<MetaIncreaseDecrease> {
  void updateCounter(int value) {
    String replacedRef = ReferenceLoader.replaceRefIndex(widget.layout["ref"], widget.pathId);
    ref.read(campaignSavedStatusProvider.notifier).update((state) {
      CampaignSavedStatus clonedState = state.clone();
      clonedState.updateNestedValue(replacedRef, "$value");
      return clonedState;
    });
  }

  @override
  Widget build(BuildContext context) {
    String replacedRef = ReferenceLoader.replaceRefIndex(widget.layout["ref"], widget.pathId);
    dynamic state = ref
                  .watch(campaignSavedStatusProvider).savedState;
    dynamic retrievedReference = ReferenceLoader.retrieveReference(state, replacedRef.split('.'));
    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      children: <Widget>[
        IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              dynamic state = ref
                            .watch(campaignSavedStatusProvider).savedState;
              dynamic retrievedReference = ReferenceLoader.retrieveReference(state, replacedRef.split('.'));
              int counterValue = retrievedReference is String ? int.parse(retrievedReference) : retrievedReference;
              if (counterValue > 0) {
                updateCounter(counterValue - 1);
              }
            }),
        Text(
          '$retrievedReference',
          style: const TextStyle(fontSize: 20),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            dynamic state = ref
                          .watch(campaignSavedStatusProvider).savedState;
            dynamic retrievedReference = ReferenceLoader.retrieveReference(state, replacedRef.split('.'));
            int counterValue = retrievedReference is String ? int.parse(retrievedReference) : retrievedReference;
            updateCounter(counterValue + 1);
          },
        ),
      ],
    );
  }
}
