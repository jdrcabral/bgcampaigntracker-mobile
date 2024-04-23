import 'package:sqflite/sqflite.dart';
import 'dart:convert';

const String tableBoardGame = "board_games";

class BoardGame {
  int id;
  String name;
  String key;
  bool isExpansion;
  BoardGame? parent;
  Map<String, dynamic>? components;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'key': key,
      'is_expansion': isExpansion,
      'parent_id': parent,
      'components': jsonEncode(components)
    };
  }

  BoardGame(
      {required this.id,
      required this.name,
      required this.key,
      required this.isExpansion,
      required this.components,
      this.parent});

  BoardGame.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        key = map['key'],
        isExpansion = map['is_expansion'] != 0,
        parent = map.containsKey('parent_id') ? map['parent_id'] : null,
        components = map.containsKey('components')
            ? jsonDecode(map['components'])
            : null;
}

class BoardGameProvider {
  Database database;

  BoardGameProvider({required this.database});

  Future<BoardGame> insert(BoardGame boardGame) async {
    boardGame.id = await database.insert(tableBoardGame, boardGame.toMap());
    return boardGame;
  }
}
