import 'package:flutter/foundation.dart';

class Item {
  String name;
  int quantity;

  Item(this.name, this.quantity);
}

class ResidentEvilCampaignNotifier extends ChangeNotifier {
  ResidentEvilCampaignNotifier(Map<String, dynamic> savedState) {
    _threatLevel = savedState.containsKey("threatLevel")
        ? savedState["threatLevel"] as int
        : 0;
    _notes =
        savedState.containsKey("notes") ? savedState["notes"].toString() : "";
    _itemBox = savedState.containsKey("itemBox")
        ? savedState["itemBox"]
            .map((item) => Item(item["name"], item["quantity"]))
        : [];
    _itemA = savedState.containsKey("itemA")
        ? savedState["itemA"]
            .map((item) => Item(item["name"], item["quantity"]))
        : [];
    _removedNarrative = savedState.containsKey("removedNarrative")
        ? savedState["removedNarrative"]
        : [];
    _removedMission = savedState.containsKey("removedMission")
        ? savedState["removedMission"]
        : [];
  }

  //   scenarios = []
  // characters = []
  // reserve = []
  // addedNarrative = []
  // addedMission = []
  // tensionDeck = []
  // removedTensionDeck = []
  // encounterDeck = []

  int _threatLevel = 0;
  int get threatLevel => _threatLevel;
  set threatLevel(int value) {
    _threatLevel = value;
    notifyListeners();
  }

  String _notes = '';
  String get notes => _notes;
  set notes(String value) {
    _notes = value;
    notifyListeners();
  }

  List<Item> _itemBox = [];
  List<Item> get itemBox => _itemBox;
  void addIemBox(Item item) {
    _itemBox.add(item);
    notifyListeners();
  }

  List<Item> _itemA = [];
  List<Item> get itemA => _itemA;
  void addIemA(Item item) {
    _itemA.add(item);
    notifyListeners();
  }

  List<String> _removedNarrative = [];
  List<String> get removedNarrative => _removedNarrative;
  void addNarrative(String removedNarrative) {
    _removedNarrative.add(removedNarrative);
    notifyListeners();
  }

  List<String> _removedMission = [];
  List<String> get removedMission => _removedMission;
  void addMission(String removedMission) {
    _removedMission.add(removedMission);
    notifyListeners();
  }

  void addValue(String key, dynamic value) {
    if (key == "itemA") {
      addIemA(Item(value, 0));
    }
  }
}
