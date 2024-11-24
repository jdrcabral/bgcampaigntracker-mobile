import 'package:flutter_riverpod/flutter_riverpod.dart';

final campaignSavedStatusProvider = StateProvider<CampaignSavedStatus>((ref) => CampaignSavedStatus());

class CampaignSavedStatus {
  Map<String, dynamic> savedState = {};
  Map<String, dynamic> dataLayout = {};

  loadCampaignState(Map<String, dynamic> savedState) {
    this.savedState = savedState;
  }

  loadDataLayout(Map<String, dynamic> dataLayout) {
    this.dataLayout = dataLayout;
  }

  CampaignSavedStatus({ Map<String, dynamic>? savedState, Map<String, dynamic>? dataLayout }) {
    this.savedState = savedState ?? {};
    this.dataLayout = dataLayout ?? {};
  }

  CampaignSavedStatus clone() {
    return CampaignSavedStatus(savedState: {...savedState}, dataLayout: {...dataLayout});
  }
}

class StateExtractor {
  static dynamic retrieveReference(dynamic state, List<String> reference) {
    if (reference.isEmpty) {
      return state;
    }
    String currentReference = reference.removeAt(0);
    int? parsedNumber = int.tryParse(currentReference);
    if (parsedNumber != null) {
      return StateExtractor.retrieveReference(state[parsedNumber], reference);
    }
    if (state.containsKey(currentReference)) {
      return StateExtractor.retrieveReference(state[currentReference], reference);
    }
    return state;
  }
}

class BuildData {
  static Map<String, dynamic> buildData(Map<String, dynamic> dataLayout, dynamic item) {
    Map<String, dynamic> data = {};
    for (var element in dataLayout.entries) {
      String key = element.key;
      dynamic value = element.value;
      if (value is Map) {
        String type = value["type"];
        dynamic defaultValue = value["default"];
        switch (type) {
          case "ref":
            if (item is Map) {
              data.putIfAbsent(key, () => item[key]);
            } else {
              data.putIfAbsent(key, () => item);
            }
            break;
          case "text":
            data.putIfAbsent(key, () => value.containsKey("default") ? defaultValue : "" );
            break;
          case "boolean":
            data.putIfAbsent(key, () => value.containsKey("default") ? defaultValue : false );
            break;
          case "list":
            data.putIfAbsent(key, () => value.containsKey("default") ? defaultValue : [] );
            break;
          default:
            break;
        }
      }
    }
    return {};
  }
}