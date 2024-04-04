import 'package:sqflite/sqflite.dart';
import 'package:campaigntrackerflutter/data/models/board_game.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

const String tableCampaign = "campaigns";

class Campaign {
  int id;
  String name;
  int boardGame;
  Map<String, dynamic> savedState;
  DateTime createdAt;
  DateTime updatedAt;

  Campaign({
    required this.id,
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
    if (map['savedState'] != null) {
      parsedSavedState = jsonDecode(map['savedState']);
    }
    return Campaign(
        id: map['id'],
        name: map['name'],
        boardGame: map['board_game_id'],
        savedState: parsedSavedState,
        createdAt: DateTime.parse(map['createdAt']),
        updatedAt: DateTime.parse(map['updatedAt']));
  }
}
