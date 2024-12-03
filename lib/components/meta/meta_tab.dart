import 'package:campaigntrackerflutter/components/meta/meta_handler.dart';
import 'package:flutter/material.dart';

final Map<String, IconData> iconMap = {
  'home': Icons.home,
  'settings': Icons.settings,
  'add': Icons.add,
  // ... add more mappings for other icons
};

class MetaTab extends StatefulWidget {
  final Map<String, dynamic> layout;
  final String pathId;

  const MetaTab({super.key, required this.layout, required this.pathId});

  @override
  _MetaTabState createState() => _MetaTabState();
}

class _MetaTabState extends State<MetaTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.layout["children"].length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> children = widget.layout["children"];
    List<Widget> tabs = children
        .map((tab) {
      if (tab.containsKey('icon')) {
        return Tab(icon: Icon(iconMap[tab['icon']]), text: tab['label']);
      }
      return Tab(text: tab['label']);
    })
        .toList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Game Detail'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: tabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: children.map((tab) => MetaHandler(layout: tab['content'], pathId: widget.pathId,)).toList(),
      ),
    );
  }
}
