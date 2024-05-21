import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MetaIncreaseDecrease extends ConsumerStatefulWidget {
  final String stateKey;
  final MainAxisAlignment mainAxisAlignment;
  const MetaIncreaseDecrease({super.key, required this.stateKey, this.mainAxisAlignment = MainAxisAlignment.center});

  @override
  _MetaIncreaseDecreaseState createState() =>
      _MetaIncreaseDecreaseState();
}

class _MetaIncreaseDecreaseState extends ConsumerState<MetaIncreaseDecrease> {
  void updateCounter(int value) {
    ref.read(campaignSavedStatusProvider.notifier).update((state) {
      CampaignSavedStatus clonedState = state.clone();
      clonedState.savedState[widget.stateKey] = value.toString();
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
              int parsedInt = int.parse(ref
                    .watch(campaignSavedStatusProvider)
                    .savedState[widget.stateKey]);
              if (parsedInt > 0) {
                updateCounter(parsedInt - 1);
              }
            }),
        Text(
          '${ref.watch(campaignSavedStatusProvider).savedState[widget.stateKey]}',
          style: const TextStyle(fontSize: 20),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            updateCounter(int.parse(ref.watch(campaignSavedStatusProvider).savedState[widget.stateKey]) + 1);
          },
        ),
      ],
    );
  }
}
