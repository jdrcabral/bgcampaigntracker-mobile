import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:campaigntrackerflutter/data/models/campaign.dart';
import 'package:campaigntrackerflutter/data/models/board_game.dart';

const String tableCampaign = "campaigns";

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;

  static Database? _database;

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'bg_campaign_tracker.db');
    return openDatabase(path, onCreate: _createTables, version: 1);
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
       CREATE TABLE board_games(
         id INTEGER PRIMARY KEY,
         name TEXT,
         key TEXT,
         is_expansion BOOLEAN,
         parent_id INTEGER REFERENCES board_games(id),
         components TEXT,
         UNIQUE(key)
       );
    ''');
    await db.execute('''
      CREATE TABLE campaigns(
        id INTEGER PRIMARY KEY,
        name TEXT,
        board_game_id INTEGER REFERENCES board_games(id),
        savedState TEXT,
        createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
        updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
      );
    ''');
    String jsonString =
        await rootBundle.loadString("assets/data/resident_evil/core.json");
    Map<String, Object?> re = {
      'name': 'Resident Evil',
      'key': 'RETBG',
      'is_expansion': false,
      'parent_id': null,
      'components': jsonString,
    };
    await db.insert(tableBoardGame, re,
        conflictAlgorithm: ConflictAlgorithm.replace);
    jsonString = await rootBundle
        .loadString("assets/data/resident_evil/bleak_outpost.json");
    re = {
      'name': 'Resident Evil: Bleack Outpost',
      'key': 'RETBG-BO',
      'is_expansion': true,
      'parent_id': 1,
      'components': jsonString,
    };
    await db.insert(tableBoardGame, re,
        conflictAlgorithm: ConflictAlgorithm.replace);
    jsonString = await rootBundle
        .loadString("assets/data/resident_evil/into_the_darkness.json");
    re = {
      'name': 'Resident Evil: Into the Darkness',
      'is_expansion': true,
      'key': 'RETBG-ITD',
      'parent_id': 1,
      'components': jsonString,
    };
    await db.insert(tableBoardGame, re,
        conflictAlgorithm: ConflictAlgorithm.replace);
    jsonString = await rootBundle
        .loadString("assets/data/resident_evil/directors_cut.json");
    re = {
      'name': 'Resident Evil: Director\'s Cut',
      'key': 'RETBG-DC',
      'is_expansion': true,
      'parent_id': 1,
      'components': jsonString,
    };
    await db.insert(tableBoardGame, re,
        conflictAlgorithm: ConflictAlgorithm.replace);
    Map<String, Object?> campaign = {
      'name': 'Resident Evil',
      'board_game_id': 1,
      'savedState': jsonString,
    };
    await db.insert(tableCampaign, campaign);
  }

  Future<Campaign> insertCampaign(Campaign campaign) async {
    final db = await _databaseService.database;
    campaign.id = await db.insert(tableCampaign, campaign.toMap());
    return campaign;
  }

  Future<Campaign> retrieveCampaign(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, Object?>> retrievedCampaign =
        await db.query(tableCampaign, where: 'id = ?', whereArgs: [id]);
    return Campaign.fromMap(retrievedCampaign.first);
  }

  Future<List<Campaign>> listCampaign() async {
    final db = await _databaseService.database;
    final List<Map<String, Object?>> retrievedCampaigns = await db.query(
        tableCampaign,
        columns: ['id', 'name', 'board_game_id', 'createdAt', 'updatedAt']);
    return List.generate(retrievedCampaigns.length,
        (index) => Campaign.fromMap(retrievedCampaigns[index]));
  }

  Future<BoardGame> insertBoardGame(BoardGame boardGame) async {
    final db = await _databaseService.database;
    boardGame.id = await db.insert(tableBoardGame, boardGame.toMap());
    return boardGame;
  }

  Future<List<BoardGame>> listBoardGames(bool excludeExpansion) async {
    final db = await _databaseService.database;
    final List<Map<String, Object?>> retrievedBoardGames = await db.query(
      tableBoardGame,
      columns: ['id', 'name', 'key', 'is_expansion'],
      where: excludeExpansion ? 'is_expansion = 0' : null,
    );
    return List.generate(retrievedBoardGames.length,
        (index) => BoardGame.fromMap(retrievedBoardGames[index]));
  }

  Future<List<BoardGame>> listBoardGamesExpansions(int parentId) async {
    final db = await _databaseService.database;
    final List<Map<String, Object?>> retrievedBoardGames = await db.query(
        tableBoardGame,
        columns: ['id', 'name', 'key', 'is_expansion'],
        where: 'parent_id = $parentId');
    return List.generate(retrievedBoardGames.length,
        (index) => BoardGame.fromMap(retrievedBoardGames[index]));
  }

  Future<List<BoardGame>> retrieveBoardGamesComponents(
      List<int> boardGamesId) async {
    final db = await _databaseService.database;
    final List<Map<String, Object?>> retrievedBoardGames = await db.query(
      tableBoardGame,
      columns: ['id', 'name', 'key', 'is_expansion', 'components'],
      where: 'id in (${boardGamesId.join(",")})',
    );
    return List.generate(retrievedBoardGames.length,
        (index) => BoardGame.fromMap(retrievedBoardGames[index]));
  }

  Future<void> createCampaign(Map<String, Object> data) async {
    final db = await _databaseService.database;
    await db.insert(tableCampaign, data);
  }
}
