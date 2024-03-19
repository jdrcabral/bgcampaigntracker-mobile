import 'package:campaigntrackerflutter/components/expansion_panel.dart';
import 'package:campaigntrackerflutter/components/increase_decrease.dart';
import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:campaigntrackerflutter/screens/board_games/resident_evil.dart';
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
    return const ResidentEvilCampaign();
  }
}
