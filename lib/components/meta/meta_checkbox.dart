import 'package:flutter/material.dart';

// Step 1: Define a model for tab data
class TabData {
  final IconData icon;
  final String text;
  final Widget content;

  TabData({required this.icon, required this.text, required this.content});
}

class CampaignDetail extends StatefulWidget {
  final List<TabData> tabs; // Accept a list of tabs as a parameter

  const CampaignDetail({super.key, required this.tabs});

  @override
  _CampaignDetailState createState() => _CampaignDetailState();
}

class _CampaignDetailState extends State<CampaignDetail>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Use the length of the tabs list for the TabController
    _tabController = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Game Detail'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: _tabController,
          // Generate tabs dynamically from the list
          tabs: widget.tabs
              .map((tab) => Tab(icon: Icon(tab.icon), text: tab.text))
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        // Generate tab views dynamically from the list
        children: widget.tabs.map((tab) => tab.content).toList(),
      ),
    );
  }
}
