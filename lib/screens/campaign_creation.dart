import 'package:campaigntrackerflutter/application/campaign_builder/campaign_builder.dart';
import 'package:campaigntrackerflutter/controllers/board_game_expansion.dart';
import 'package:campaigntrackerflutter/data/database_service.dart';
import 'package:campaigntrackerflutter/data/models/board_game.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CampaignCreation extends ConsumerStatefulWidget  {
  const CampaignCreation({
    super.key,
  });

  @override
  _CampaignCreationState createState() => _CampaignCreationState();
}

class _CampaignCreationState extends ConsumerState<CampaignCreation> {
  final DatabaseService _databaseService = DatabaseService();
  late int? parentId;
  final TextEditingController _campaignTitle = TextEditingController();
  late bool _isLoading = false;
  late bool _expansionLoaded = false;
  List<int> boardGameIds = [];
  List<bool> expansionSelected = [];
  List<int> expansionIds = [];
  @override
  void initState() {
    super.initState();
    _isLoading = false;
    parentId = null;
    _campaignTitle.text = "";
    expansionSelected = [];
    expansionIds = [];
    _expansionLoaded = false;
  }

  Future<List<BoardGame>> _listBoardGames() async {
    return await _databaseService.listBoardGames(true);
  }

  Future<List<BoardGame>> _retrieveComponents(List<int> boardGamesId) async {
    return await _databaseService.retrieveBoardGamesComponents(boardGamesId);
  }

  Future<void> _createCampaign(Map<String, Object> campaign) async {
    return await _databaseService.createCampaign(campaign);
  }

  @override
  Widget build(BuildContext context) {
    final expansionsProvider = ref.watch(futureExpansionsProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Campaign Creation"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: _listBoardGames(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: "Title"),
                  controller: _campaignTitle,
                ),
                DropdownButtonFormField(
                  items: snapshot.data!.map((boardGame) {
                    return DropdownMenuItem(
                      value: boardGame.id,
                      child: Text(boardGame.name),
                    );
                  }).toList(),
                  value: parentId,
                  onChanged: (value) {
                    setState(() {
                      parentId = value;
                    });
                    ref.watch(parentIdProvider.notifier).state = value;
                  },
                  decoration: const InputDecoration(
                    labelText: "Board Game",
                  ),
                ),
                const Divider(),
                const Text("Expansions"),
                expansionsProvider.when(
                    data: (expansions) {
                      if (expansions.isNotEmpty) {
                        if (!_expansionLoaded) {
                          expansionSelected =
                              List.filled(expansions.length, false);
                          expansionIds = List.generate(expansions.length, (
                              index) => expansions[index].id);
                          _expansionLoaded = true;
                        }
                        return ListView.builder(
                          itemCount: expansions.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CheckboxListTile(
                              title: Text(expansions[index].name),
                              value: expansionSelected[index],
                              onChanged: (bool? value) {
                                if (value == null) return;
                                setState(() {
                                  expansionSelected[index] = value;
                                });
                              },
                            );
                          },
                        );
                      }
                      return const Text("No expansion found");
                    },
                    error: (e, _) => const Center(child: Text("Error"),),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    )
                ),
                ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            setState(() {
                              _isLoading = true;
                            });
                            setState(() => _isLoading = true);
                            boardGameIds.add(parentId!);
                            for (int i = 0;
                                i < expansionSelected.length;
                                i++) {
                              if (expansionSelected[i]) {
                                boardGameIds.add(expansionIds[i]);
                              }
                            }
                            List<BoardGame> boardGames =
                                await _retrieveComponents(boardGameIds);
                            BoardGame baseGame = boardGames.firstWhere(
                                (element) => element.id == parentId);
                            Map<String, dynamic> createdCampaign =
                                CampaignBuilder()
                                    .build(baseGame.key, boardGames);
                            Map<String, Object> campaign = {
                              "board_game_id": parentId!,
                              "name": _campaignTitle.text,
                              "savedState": jsonEncode(createdCampaign),
                            };
                            await _createCampaign(campaign);
                            Navigator.pop(context);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             CampaignDetail(id: id)));
                          },
                    child: _isLoading
                        ? Container(
                            width: 24,
                            height: 24,
                            padding: const EdgeInsets.all(2.0),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : const Text("Create"))
              ],
            );
          },
        ),
      ),
    );
  }
}
