import 'dart:convert';
import 'package:campaigntrackerflutter/data/models/board_game.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:http/http.dart' as http;
import 'package:campaigntrackerflutter/data/database_service.dart';
import 'package:campaigntrackerflutter/data/models/campaign.dart';

class BoardgameService {

  final DatabaseService _databaseService = DatabaseService();

  Future<List<BoardGame>> list() async {
    if (kIsWeb) {
      var response = await http.get(Uri.parse('http://127.0.0.1:8000/boardgames/?is_expansion=false'));
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => BoardGame.fromMap(item)).toList();
    }
    return await _databaseService.listBoardGames(true);
  }

  Future<List<BoardGame>> retrieveExpansions(parentId) async {
    if (kIsWeb) {
      var response = await http.get(Uri.parse('http://127.0.0.1:8000/boardgames/?is_expansion=true&parent=${parentId}'));
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => BoardGame.fromMap(item)).toList();
    }
    return await DatabaseService().listBoardGamesExpansions(parentId);
  }

  Future<BoardGame> retrieveBoardGame(int boardGameId) async {
      var response = await http.get(Uri.parse('http://127.0.0.1:8000/boardgames/${boardGameId}'));
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BoardGame.fromMap(jsonData);
  }

  Future<List<BoardGame>> retrieveComponents(List<int> boardGamesId) async {
    if (kIsWeb) {
      var response = await http.get(Uri.parse('http://127.0.0.1:8000/boardgames/components?id_in=${boardGamesId.join(",")}'));
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => BoardGame.fromMap(item)).toList();
    }
    return await _databaseService.retrieveBoardGamesComponents(boardGamesId);
  }
}