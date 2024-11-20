import 'package:campaigntrackerflutter/data/database_service.dart';
import 'package:campaigntrackerflutter/data/models/board_game.dart';
import 'package:campaigntrackerflutter/data/services/boardgame_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final parentIdProvider = StateProvider<int?>((ref) => null);
final boardGameController = Provider((ref) => BoardGameController());
final futureExpansionsProvider = FutureProvider<List<BoardGame>>((ref) async {
  final updatedParentId = ref.watch(parentIdProvider);
  List<BoardGame> boardGames = await ref.read(boardGameController).listExpansions(updatedParentId);
  return boardGames;
});


class BoardGameController {
  Future<List<BoardGame>> listExpansions(int? parentId) async {
    if (parentId == null) return [];
    return await BoardgameService().retrieveExpansions(parentId);
  }
}
