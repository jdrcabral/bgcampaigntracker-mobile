import 'package:flutter/material.dart';

class MetaCard extends StatefulWidget {
  final Map<String, dynamic> tabLayout;

  const MetaCard({Key? key, required this.tabLayout}) : super(key: key);

  @override
  _MetaCardState createState() => _MetaCardState();
}

class _MetaCardState extends State<MetaCard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabLayout["children"].length, vsync: this);
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
        title: Text('Game Detail'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabLayout: widget.tabLayout["children"]
              .map((tab) {
                if (tab.containsKey('icon')) {
                  return Tab(icon: Icon(tab['icon']), text: tab['label'])
                }
                return Tab(text: tab['label'])
              })
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: widget.tabLayout["children"].map((tab) => MetaHandler(tab['content'])).toList(),
      ),
    );
  }
}
