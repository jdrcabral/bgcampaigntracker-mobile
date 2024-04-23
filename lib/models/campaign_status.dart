import 'package:flutter/foundation.dart';

class CampaignStatus extends ChangeNotifier {
  CampaignStatus(Map<String, dynamic> savedState) : _savedState = savedState;

  Map<String, dynamic> _savedState = {};
  Map<String, dynamic> get savedState => _savedState;
  void updateSavedState(String key, dynamic value) {
    Map<String, dynamic> updatedMap = _updateValue(_savedState, key, value);
    _savedState = updatedMap;
    notifyListeners();
  }

  dynamic retrieveValue(Map<String, dynamic> map, String key) {
    if (map.containsKey(key)) {
      return map[key];
    } else if (key.contains(".")) {
      List<String> keyPath = key.split(".");
      return retrieveValue(map[keyPath[0]], keyPath.sublist(1).join("."));
    } else {
      return null;
      // throw ("Key not found");
    }
  }

  Map<String, dynamic> _updateValue(
      Map<String, dynamic> map, String key, dynamic value) {
    if (map.containsKey(key)) {
      map[key] = value;
      return map;
    } else if (key.contains(".")) {
      List<String> keyPath = key.split(".");
      return _updateValue(map[keyPath[0]], keyPath.sublist(1).join("."), value);
    } else {
      map.putIfAbsent(key, value);
      return map;
      // throw ("Key not found");
    }
  }

  int _threatLevel = 0;
  int get threatLevel => _threatLevel;
  set threatLevel(int value) {
    _threatLevel = value;
    notifyListeners();
  }
}
