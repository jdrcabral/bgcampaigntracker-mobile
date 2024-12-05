import 'package:flutter_riverpod/flutter_riverpod.dart';

final campaignSavedStatusProvider = StateProvider<CampaignSavedStatus>((ref) => CampaignSavedStatus());

class CampaignSavedStatus {
  Map<String, dynamic> savedState = {};

  loadCampaignState(Map<String, dynamic> savedState) {
    this.savedState = savedState;
  }

  CampaignSavedStatus({ Map<String, dynamic>? savedState }) {
    this.savedState = savedState ?? {};
  }

  CampaignSavedStatus clone() {
    return CampaignSavedStatus(savedState: {...savedState});
  }

  updateNestedValue(String path, dynamic newValue) {
    List<String> keys = path.split('.');
    dynamic current = savedState;

    for (int i = 0; i < keys.length - 1; i++) {
      if (current is List) {
        current = current[int.parse(keys[i])];
      } else {
        current = current[keys[i]];
      }
    }

    if (current is List) {
      int index = int.parse(keys.last);
      current[index] = newValue;
    } else {
      (current as Map)[keys.last] = newValue;
    }
  }
}
