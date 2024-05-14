import 'package:campaigntrackerflutter/components/card_navigator.dart';
import 'package:campaigntrackerflutter/components/expansion_panel.dart';
import 'package:campaigntrackerflutter/components/increase_decrease.dart';
import 'package:campaigntrackerflutter/data/models/campaign.dart';
import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:campaigntrackerflutter/screens/shared/cards_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResidentEvilCampaign extends ConsumerStatefulWidget {
  final Campaign campaign;

  const ResidentEvilCampaign({super.key, required this.campaign});

  @override
  _ResidentEvilCampaignState createState() => _ResidentEvilCampaignState();
}

class _ResidentEvilCampaignState extends ConsumerState<ResidentEvilCampaign>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref
        .read(campaignSavedStatusProvider)
        .loadCampaignState(widget.campaign.savedState);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.campaign.name),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(icon: Icon(Icons.info), text: 'Info'),
            Tab(icon: Icon(Icons.people), text: 'Characters'),
            Tab(icon: Icon(Icons.people), text: 'Cards'),
            Tab(icon: Icon(Icons.map), text: 'Map'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
              child: Container(
                padding: const EdgeInsets.all(30.0),
                child: const Column(children: [
                  Text(
                    'Threat Level',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  IncreaseDecreaseTextField(
                    stateKey: "threatLevel",
                  ),
                  Text(
                    'Notes',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ]),
              )),
          Center(
              child: Container(
                child: Flex(direction: Axis.vertical, children: [
                  Text('Active Characters',
                      style: TextStyle(color: Colors.black)),
                  Expanded(
                      flex: 1,
                      child: ListView.builder(
                          itemBuilder: (context, index) => Card(
                            child: Row(
                              children: [],
                            ),
                          ))),
                  Text('Reserve Characters', style: TextStyle(color: Colors.black)),
                  Expanded(
                    flex: 2,
                    child: ListView.builder(
                        itemCount: ref
                            .watch(campaignSavedStatusProvider)
                            .savedState["reserve"]
                            ?.length ??
                            0,
                        itemBuilder: (context, index) => Card(
                          child: Container(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 200.0,
                                      child: Text(
                                          "${ref.watch(campaignSavedStatusProvider).savedState['reserve'][index]['name']}"),
                                    ),
                                    ElevatedButton(onPressed: () {}, child: Text("Add to active"), style: Theme.of(context).elevatedButtonTheme.style,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    // Expanded(
                                    //   child: CheckboxListTile(
                                    //     dense: true,
                                    //     title: Text("Locked"),
                                    //     value: true,
                                    //     onChanged: (bool? value) {},
                                    //   ),
                                    // ),
                                    Checkbox(value: false, onChanged: (bool? value) {}),
                                    Text('Locked'),
                                    Checkbox(value: false, onChanged: (bool? value) {}),
                                    Text('Dead'),
                                    Checkbox(value: false, onChanged: (bool? value) {}),
                                    Text('Advanced'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Health"),
                                    IncreaseDecreaseTextField(
                                        stateKey: "threatLevel",
                                        mainAxisAlignment:
                                        MainAxisAlignment.start),
                                  ],
                                ),
                              ])),
                        )),
                  ),
                ]),
              )),
          Center(
              child: Column(
                children: [
                  CardNavigator(
                      cardTitle: 'Item Box',
                      navigateTo: CardsController(
                        title: 'Item Box',
                        stateKey: 'itemBox',
                        options: widget.campaign.savedState["selectOptions"]
                        ["items"],
                        items: ref
                            .watch(campaignSavedStatusProvider)
                            .savedState["itemBox"],
                      )),
                  CardNavigator(
                    cardTitle: 'Item A',
                    navigateTo: CardsController(
                      title: 'Item A',
                      stateKey: 'itemA',
                      options: widget.campaign.savedState["selectOptions"]["items"],
                      items: ref
                          .watch(campaignSavedStatusProvider)
                          .savedState["itemA"],
                    ),
                  ),
                  CardNavigator(
                      cardTitle: 'Tension Deck',
                      navigateTo: CardsController(
                        title: 'Tension Deck',
                        stateKey: 'tensionDeck',
                        options: (widget.campaign.savedState["selectOptions"]
                        ["tensionCards"] as List<dynamic>)
                            .map((item) => "(${item['value']}) ${item['name']}")
                            .toList(),
                        items: ref
                            .watch(campaignSavedStatusProvider)
                            .savedState["tensionDeck"],
                      )),
                  CardNavigator(
                      cardTitle: 'Narrative Deck',
                      navigateTo: CardsController(
                        title: 'Narrative Deck',
                        stateKey: 'playedNarratives',
                        options: widget.campaign.savedState["selectOptions"]
                        ["narratives"],
                        items: ref
                            .watch(campaignSavedStatusProvider)
                            .savedState["playedNarratives"],
                      )),
                  CardNavigator(
                      cardTitle: 'Mission Deck',
                      navigateTo: CardsController(
                        title: 'Mission Deck',
                        stateKey: 'playedMissions',
                        options: widget.campaign.savedState["selectOptions"]
                        ["missions"],
                        items: ref
                            .watch(campaignSavedStatusProvider)
                            .savedState["playedMissions"],
                      )),
                  CardNavigator(
                      cardTitle: 'Encounter Deck',
                      navigateTo: CardsController(
                        title: 'Encounter Deck',
                        stateKey: 'encounterDeck',
                        options: widget.campaign.savedState["selectOptions"]
                        ["encounters"],
                        items: ref
                            .watch(campaignSavedStatusProvider)
                            .savedState["encounterDeck"],
                      )),
                ],
              )),
          const Center(
              child: Text('Game map goes here',
                  style: TextStyle(color: Colors.black))),
        ],
      ),
    );
  }
}
