import 'package:flutter_riverpod/flutter_riverpod.dart';

final campaignSavedStatusProvider = StateProvider<CampaignSavedStatus>((ref) => CampaignSavedStatus());

class CampaignSavedStatus {
  int identifier = 0;
  Map<String, dynamic> savedState = {};
  Map<String, dynamic> components = {};

  loadCampaignState(Map<String, dynamic> savedState) {
    this.savedState = savedState;
  }

  loadComponents(Map<String, dynamic> components) {
    this.components = components;
  }

  setIdentifier(int identifier) {
    this.identifier = identifier;
  }

  CampaignSavedStatus({ int? identifier, Map<String, dynamic>? savedState, Map<String, dynamic>? components }) {
    this.identifier = identifier ?? 0;
    this.savedState = savedState ?? {};
    this.components = components ?? {};
  }

  CampaignSavedStatus clone() {
    return CampaignSavedStatus(identifier: identifier, savedState: {...savedState}, components: {...components});
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
