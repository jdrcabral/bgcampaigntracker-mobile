import 'package:sqflite/sqflite.dart';
import 'dart:convert';

const String tableBoardGame = "board_games";

class BoardGame {
  int id;
  String name;
  String key;
  bool isExpansion;
  int? parent;
  Map<String, dynamic>? components;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'key': key,
      'is_expansion': isExpansion,
      'parent': parent,
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
        parent = map.containsKey('parent') ? map['parent'] : null,
        components = map.containsKey('components')
            ? processComponents(map['components'])
            : null;
}

Map<String, dynamic> processComponents(dynamic components) {
  if (components.runtimeType == String) {
    return jsonDecode(components);
  }
  return components;
}

class BoardGameProvider {
  Database database;

  BoardGameProvider({required this.database});

  Future<BoardGame> insert(BoardGame boardGame) async {
    boardGame.id = await database.insert(tableBoardGame, boardGame.toMap());
    return boardGame;
  }
}
