import 'package:campaigntrackerflutter/components/card_navigator.dart';
import 'package:campaigntrackerflutter/components/expansion_panel.dart';
import 'package:campaigntrackerflutter/components/increase_decrease.dart';
import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:campaigntrackerflutter/screens/shared/cards_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResidentEvilCampaign extends StatefulWidget {
  const ResidentEvilCampaign({Key? key}) : super(key: key);

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
    return ChangeNotifierProvider(
        create: (context) => CampaignStatus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Game Detail'),
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
              const Center(
                  child: Column(
                children: [
                  CardNavigator(
                      cardTitle: 'Tension Deck',
                      navigateTo: CardsController(title: 'Tension Deck')),
                  CardNavigator(
                      cardTitle: 'Narrative Deck',
                      navigateTo: CardsController(title: 'Narrative Deck')),
                  CardNavigator(
                      cardTitle: 'Mission Deck',
                      navigateTo: CardsController(title: 'Mission Deck')),
                  CardNavigator(
                      cardTitle: 'Encounter Deck',
                      navigateTo: CardsController(title: 'Encounter Deck')),
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
