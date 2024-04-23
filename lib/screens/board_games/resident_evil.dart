import 'package:campaigntrackerflutter/components/card_navigator.dart';
import 'package:campaigntrackerflutter/components/expansion_panel.dart';
import 'package:campaigntrackerflutter/components/increase_decrease.dart';
import 'package:campaigntrackerflutter/data/models/campaign.dart';
import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:campaigntrackerflutter/models/resident_evil_campaign_notifier.dart';
import 'package:campaigntrackerflutter/screens/shared/cards_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResidentEvilCampaign extends StatefulWidget {
  final Campaign campaign;
  const ResidentEvilCampaign({Key? key, required this.campaign})
      : super(key: key);

  @override
  _ResidentEvilCampaignState createState() => _ResidentEvilCampaignState();
}

class _ResidentEvilCampaignState extends State<ResidentEvilCampaign>
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
    return ChangeNotifierProvider<CampaignStatus>(
        create: (context) => CampaignStatus(widget.campaign.savedState),
        builder: (context, child) => Scaffold(
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
                    child: Column(children: const [
                      Text(
                        'Threat Level',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      IncreaseDecreaseTextField(counter: 5),
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
                    child: Column(children: const [
                      Text('Game characters goes here',
                          style: TextStyle(color: Colors.black)),
                      ExpansionPanelListExample(),
                      Text('Reserve Characters',
                          style: TextStyle(color: Colors.black)),
                    ]),
                  )),
                  Center(
                      child: Column(
                    children: [
                      Consumer<CampaignStatus>(
                          builder: (context, campaignStatus, child) =>
                              CardNavigator(
                                  cardTitle: 'Item Box',
                                  navigateTo: CardsController(
                                    title: 'Item Box',
                                    stateKey: 'itemBox',
                                    options:
                                        widget.campaign.savedState["items"],
                                    items:
                                        campaignStatus.savedState['itemBox'] ??
                                            [],
                                  ))),
                      ChangeNotifierProvider<ResidentEvilCampaignNotifier>(
                        create: (context) => ResidentEvilCampaignNotifier(
                            widget.campaign.savedState),
                        builder: (context, child) =>
                            Consumer<ResidentEvilCampaignNotifier>(
                                builder: (context, campaignStatus, child) =>
                                    CardNavigator(
                                        cardTitle: 'Item A',
                                        navigateTo: CardsController(
                                          title: 'Item A',
                                          stateKey: 'itemA',
                                          options: widget
                                              .campaign.savedState["items"],
                                          items: campaignStatus.itemA
                                              .map((e) => e.name)
                                              .toList(),
                                        ))),
                      ),
                      CardNavigator(
                          cardTitle: 'Tension Deck',
                          navigateTo: CardsController(
                            title: 'Tension Deck',
                            stateKey: 'tensionDeck',
                            options: (widget.campaign.savedState["tensionCards"]
                                    as List<dynamic>)
                                .map((item) =>
                                    "(${item['value']}) ${item['name']}")
                                .toList(),
                            items: [],
                          )),
                      CardNavigator(
                          cardTitle: 'Narrative Deck',
                          navigateTo: CardsController(
                            title: 'Narrative Deck',
                            stateKey: 'narrativeDeck',
                            options: widget.campaign.savedState["narrative"],
                            items: [],
                          )),
                      CardNavigator(
                          cardTitle: 'Mission Deck',
                          navigateTo: CardsController(
                            title: 'Mission Deck',
                            stateKey: 'missionDeck',
                            options: widget.campaign.savedState["mission"],
                            items: [],
                          )),
                      CardNavigator(
                          cardTitle: 'Encounter Deck',
                          navigateTo: CardsController(
                            title: 'Encounter Deck',
                            stateKey: 'encounterDeck',
                            options: [],
                            items: [],
                          )),
                    ],
                  )),
                  const Center(
                      child: Text('Game map goes here',
                          style: TextStyle(color: Colors.black))),
                ],
              ),
            ));
  }
}
