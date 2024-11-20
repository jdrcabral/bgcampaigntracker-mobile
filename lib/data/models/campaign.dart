import 'dart:convert';

const String tableCampaign = "campaigns";

class Campaign {
  int? id;
  String name;
  int boardGame;
  Map<String, dynamic> savedState;
  DateTime createdAt;
  DateTime updatedAt;

  Campaign({
    this.id,
    required this.name,
    required this.boardGame,
    required this.savedState,
    required this.createdAt,
    required this.updatedAt,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'board_game_id': boardGame,
      'savedState': jsonEncode(savedState),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Campaign.fromMap(Map<String, dynamic> map) {
    Map<String, dynamic> parsedSavedState = {};
    if (map.containsKey('savedState') && map['savedState'] != null) {
      parsedSavedState = jsonDecode(map['savedState']);
    }
    if (map.containsKey('saved_state') && map['saved_state'] != null) {
      if (map["saved_state"].runtimeType == String) {
        parsedSavedState = jsonDecode(map['saved_state']);
      } else {
        parsedSavedState = map['saved_state'];
      }
    }
    String createdAt = map.containsKey('createdAt') ? map['createdAt'] : map['created_at'];
    String updatedAt = map.containsKey('updatedAt') ? map['updatedAt'] : map['updated_at'];
    return Campaign(
        id: map['id'],
        name: map['name'],
        boardGame: map.containsKey('board_game_id') ? map['board_game_id'] : map['board_game'],
        savedState: parsedSavedState,
        createdAt: DateTime.parse(createdAt),
        updatedAt: DateTime.parse(updatedAt));
  }
}
