import 'package:campaigntrackerflutter/application/campaign_builder/base_builder.dart';
import 'package:campaigntrackerflutter/data/models/board_game.dart';

class ResidentEvilBuilder extends BaseCampaingBuilder {
  List<String> selectOptions = [
    "items",
    "missions",
    "narratives",
    "tensionCards",
    "encounters"
  ];
  @override
  void handleBuild(List<BoardGame> boardGames) {
    _generalConfiguration();
    for (var element in boardGames) {
      _buildCharacters(element);
      _buildScenarios(element);
      _buildSelectOptions(element);
    }
  }

  void _generalConfiguration() {
    savedState.putIfAbsent("threatLevel", () => 0);
    savedState.putIfAbsent("notes", () => "");
    savedState.putIfAbsent("characters", () => []);
    savedState.putIfAbsent("reserve", () => []);
    Map<String, List<dynamic>> convertedMap = {
      for (String option in selectOptions) option: [],
    };
    savedState.putIfAbsent("selectOptions", () => convertedMap);
    savedState.putIfAbsent("itemBox", () => []);
    savedState.putIfAbsent("itemA", () => []);
    savedState.putIfAbsent("tensionDeck", () => []);
    savedState.putIfAbsent("removedTensionDeck", () => []);
    savedState.putIfAbsent("encounterDeck", () => []);
    savedState.putIfAbsent("playedNarratives", () => []);
    savedState.putIfAbsent("removedNarratives", () => []);
    savedState.putIfAbsent("playedMissions", () => []);
    savedState.putIfAbsent("removedMissions", () => []);
    savedState.putIfAbsent("scenarios", () => []);
  }

  void _buildCharacters(BoardGame boardGame) {
    if (!boardGame.isExpansion) {
      List<dynamic> characters = boardGame.components!["characters"] ?? [];
      for (var element in characters) {
        (savedState["reserve"] as List<dynamic>).add({
          "name": element,
          "unlocked": true,
          "dead": false,
          "advanced": false,
          "health": 5,
        });
      }
    }
    if (!boardGame.components!.containsKey("characters")) return;
    var component = boardGame.components!["characters"];

    (component as List<dynamic>).forEach((element) {
      (savedState["reserve"] as List<dynamic>).add({
        "name": element,
        "unlocked": false,
        "dead": false,
        "advanced": false,
        "health": 5,
      });
    });
  }

  void _buildScenarios(BoardGame boardGames) {
    if (!boardGames.components!.containsKey("scenarios")) return;
    var component = boardGames.components!["scenarios"];
    savedState.update("scenarios", (value) => component,
        ifAbsent: () => [component]);
  }

  void _buildSelectOptions(BoardGame boardGames) {
    for (var key in selectOptions) {
      List<dynamic> stateOptions = savedState["selectOptions"][key];
      if (!boardGames.components!.containsKey(key)) continue;
      var gameComponent = boardGames.components![key];
      if (gameComponent is List<dynamic>) {
        for (var component in gameComponent) {
          if (component is String) {
            if (!stateOptions.cast<String>().contains(component)) {
              stateOptions.add(component);
              continue;
            }
          }
          else if (component is Map<String, dynamic>) {
            stateOptions.add(component);
          }
        }
      }
    }
  }
}
