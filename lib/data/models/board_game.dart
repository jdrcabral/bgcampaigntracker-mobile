import 'package:sqflite/sqflite.dart';
import 'dart:convert';

const String tableBoardGame = "board_games";

class BoardGame {
  int id;
  String name;
  bool isExpansion;
  BoardGame? parent;
  Map<String, dynamic> components;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'is_expansion': isExpansion,
      'parent_id': parent,
      'components': jsonEncode(components)
    };
  }

  BoardGame(
      {required this.id,
      required this.name,
      required this.isExpansion,
      required this.components,
      this.parent});

  BoardGame.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        isExpansion = map['is_expansion'],
        parent = map['parent_id'],
        components = jsonDecode(map['components']);
}

class BoardGameProvider {
  Database database;

  BoardGameProvider({required this.database});

  Future<BoardGame> insert(BoardGame boardGame) async {
    boardGame.id = await database.insert(tableBoardGame, boardGame.toMap());
    return boardGame;
  }
}
