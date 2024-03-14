import 'package:sqflite/sqflite.dart';

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
      'isExpansion': isExpansion,
      'parent': parent,
      'components': components
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
        isExpansion = map['isExpansion'],
        parent = map['parent'],
        components = map['components'];
}

class BoardGameProvider {
  Database database;

  BoardGameProvider({required this.database});

  Future<BoardGame> insert(BoardGame boardGame) async {
    boardGame.id = await database.insert(tableBoardGame, boardGame.toMap());
    return boardGame;
  }
}
