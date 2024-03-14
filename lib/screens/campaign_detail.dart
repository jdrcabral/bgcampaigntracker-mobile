import 'package:campaigntrackerflutter/components/expansion_panel.dart';
import 'package:campaigntrackerflutter/components/increase_decrease.dart';
import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CampaignDetail extends StatefulWidget {
  const CampaignDetail({Key? key}) : super(key: key);

  @override
  _CampaignDetailState createState() => _CampaignDetailState();
}

class _CampaignDetailState extends State<CampaignDetail>
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
                  Text('Game information goes here',
                      style: TextStyle(color: Colors.black)),
                  Text(
                    'Threat Level',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  IncreaseDecreaseTextField(counter: 5),
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
                  child: Text('Cards details go here',
                      style: TextStyle(color: Colors.black))),
              Center(
                  child: Text('Game map goes here',
                      style: TextStyle(color: Colors.black))),
            ],
          ),
        ));
  }
}
