import 'package:campaigntrackerflutter/application/campaign_builder/base_builder.dart';
import 'package:campaigntrackerflutter/application/campaign_builder/board_games/resident_evil.dart';
import 'package:campaigntrackerflutter/data/models/board_game.dart';

class CampaignBuilder {
  Map<String, BaseCampaingBuilder> builders = {
    'RETBG': ResidentEvilBuilder(),
  };

  Map<String, dynamic> build(String boardGameKey, List<BoardGame> boardGames) {
    if (boardGames.isEmpty) return {};
    return builders[boardGameKey]!.build(boardGames);
  }
}
