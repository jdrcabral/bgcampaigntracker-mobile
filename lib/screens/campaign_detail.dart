import 'dart:convert';

import 'package:campaigntrackerflutter/components/meta/meta_handler.dart';
import 'package:campaigntrackerflutter/data/database_service.dart';
import 'package:campaigntrackerflutter/data/models/campaign.dart';
import 'package:campaigntrackerflutter/screens/board_games/resident_evil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CampaignDetail extends StatefulWidget {
  final int id;

  const CampaignDetail({
    super.key,
    required this.id,
  });

  @override
  _CampaignDetailState createState() => _CampaignDetailState();
}

class _CampaignDetailState extends State<CampaignDetail>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  Future<Campaign> _fetchCampaign() async {
    return _databaseService.retrieveCampaign(widget.id);
  }

  Future<Map<String, dynamic>> _loadLayout() async {
    String jsonString = await rootBundle
        .loadString("assets/data/layout.json");
    return jsonDecode(jsonString);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _loadLayout(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data != null) {
            return MetaHandler(layout: snapshot.data!);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
    // return Container(
    //   child: FutureBuilder(
    //     future: _fetchCampaign(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //       if (snapshot.data != null) {
    //         Campaign campaign = snapshot.data!;
    //         return ResidentEvilCampaign(campaign: campaign);
    //       }
    //       // TODO Replace with error
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     },
    //   ),
    // );
  }
}
