import 'package:campaigntrackerflutter/data/models/board_game.dart';

class BaseCampaingBuilder {
  Map<String, dynamic> savedState = {};

  Map<String, dynamic> build(List<BoardGame> boardGames) {
    savedState.clear();
    if (boardGames.isEmpty) savedState;
    handleBuild(boardGames);
    sortItems();
    return savedState;
  }

  void handleBuild(List<BoardGame> boardGames) {
    throw UnimplementedError("Method not implemented");
  }

  void mergeElements(Map<String, dynamic> components) {
    if (savedState.isEmpty) savedState = components;

    for (var element in components.entries) {
      if (!savedState.containsKey(element.key)) {
        savedState.putIfAbsent(element.key, element.value);
        continue;
      }
      if (savedState[element.key] is List) {
        savedState[element.key].add(element.value);
        continue;
      }
    }
  }

  void sortItems() {
    savedState.forEach((key, value) {
      if (value is List) {
        value.sort();
      }
    });
  }
}
