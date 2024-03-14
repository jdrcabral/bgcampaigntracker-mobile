import 'package:sqflite/sqflite.dart';
import 'package:campaigntrackerflutter/data/models/board_game.dart';

const String tableCampaign = "campaigns";

class Campaign {
  int id;
  String name;
  BoardGame boardGame;
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
      'boardGame': boardGame.toMap(),
      'savedState': savedState,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  Campaign.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        boardGame = BoardGame.fromMap(map['boardGame']),
        savedState = map['savedState'],
        createdAt = DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
        updatedAt = DateTime.fromMillisecondsSinceEpoch(map['updatedAt']);
}

class CampaignProvider {
  Database database;

  CampaignProvider({required this.database});

  Future<Campaign> insert(Campaign campaign) async {
    campaign.id = await database.insert(tableCampaign, campaign.toMap());
    return campaign;
  }
}
