import 'package:campaigntrackerflutter/application/campaign_builder/campaign_builder.dart';
import 'package:campaigntrackerflutter/data/database_service.dart';
import 'package:campaigntrackerflutter/data/models/board_game.dart';
import 'package:campaigntrackerflutter/screens/campaign_detail.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class CampaignCreation extends StatefulWidget {
  const CampaignCreation({
    Key? key,
  }) : super(key: key);

  @override
  _CampaignCreationState createState() => _CampaignCreationState();
}

class _CampaignCreationState extends State<CampaignCreation> {
  final DatabaseService _databaseService = DatabaseService();
  late int? parentId;
  final TextEditingController _campaignTitle = TextEditingController();
  late List<bool> expansionSelected;
  late bool _buildExpansionSelected;
  late List<int>? expansionIds;
  late bool _isLoading = false;
  List<int> boardGameIds = [];

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    parentId = null;
    _campaignTitle.text = "";
    expansionSelected = [];
    _buildExpansionSelected = true;
  }

  Future<List<BoardGame>> _listBoardGames() async {
    return await _databaseService.listBoardGames(true);
  }

  Future<List<BoardGame>?> _listExpansions(int? parentId) async {
    if (parentId == null) return null;
    return await _databaseService.listBoardGamesExpansions(parentId);
  }

  Future<List<BoardGame>> _retrieveComponents(List<int> boardGamesId) async {
    return await _databaseService.retrieveBoardGamesComponents(boardGamesId);
  }

  Future<void> _createCampaign(Map<String, Object> campaign) async {
    return await _databaseService.createCampaing(campaign);
  }

  @override
  Widget build(BuildContext context) {
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
            if (snapshot.connectionState == ConnectionState.waiting) {
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
                      _buildExpansionSelected = true;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: "Board Game",
                  ),
                ),
                const Divider(),
                const Text("Expansions"),
                FutureBuilder(
                    future: _listExpansions(parentId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (_buildExpansionSelected) {
                          expansionSelected =
                              List.filled(snapshot.data!.length, false);
                          _buildExpansionSelected = false;
                        }
                        expansionIds = List.generate(snapshot.data!.length,
                                (index) => snapshot.data![index].id);

                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CheckboxListTile(
                              title: Text(snapshot.data![index].name),
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
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return const Text("No expansion found");
                    }),
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
                                boardGameIds.add(expansionIds![i]);
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
                              "boardGame": parentId!,
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
