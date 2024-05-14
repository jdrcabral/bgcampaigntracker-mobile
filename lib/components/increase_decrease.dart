import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncreaseDecreaseTextField extends ConsumerStatefulWidget {
  final String stateKey;
  final MainAxisAlignment mainAxisAlignment;
  const IncreaseDecreaseTextField({super.key, required this.stateKey, this.mainAxisAlignment = MainAxisAlignment.center});

  @override
  _IncreaseDecreaseTextFieldState createState() =>
      _IncreaseDecreaseTextFieldState();
}

class _IncreaseDecreaseTextFieldState extends ConsumerState<IncreaseDecreaseTextField> {
  void updateCounter(int value) {
    ref.read(campaignSavedStatusProvider.notifier).update((state) {
      CampaignSavedStatus clonedState = state.clone();
      clonedState.savedState[widget.stateKey] = value;
      return clonedState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            if (ref.watch(campaignSavedStatusProvider).savedState[widget.stateKey] > 0) {
              updateCounter(ref.watch(campaignSavedStatusProvider).savedState[widget.stateKey] - 1);
            }
          }),
        Text(
          '${ref.watch(campaignSavedStatusProvider).savedState[widget.stateKey]}',
          style: const TextStyle(fontSize: 20),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            updateCounter(ref.watch(campaignSavedStatusProvider).savedState[widget.stateKey] + 1);
            },
        ),
      ],
    );
  }
}
