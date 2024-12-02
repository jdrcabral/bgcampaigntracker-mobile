import 'dart:convert';

import 'package:campaigntrackerflutter/components/meta/meta_handler.dart';
import 'package:campaigntrackerflutter/data/database_service.dart';
import 'package:campaigntrackerflutter/data/models/campaign.dart';
import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:campaigntrackerflutter/models/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CampaignDetail extends ConsumerStatefulWidget {
  final int id;

  const CampaignDetail({
    super.key,
    required this.id,
  });

  @override
  _CampaignDetailState createState() => _CampaignDetailState();
}

class _CampaignDetailState extends ConsumerState<CampaignDetail> {
  final DatabaseService _databaseService = DatabaseService();


  Future<Campaign> _fetchCampaign() async {
    return _databaseService.retrieveCampaign(widget.id);
  }

  Future<List<Map<String, dynamic>>> _loadLayout() async {
    String jsonString = await rootBundle
        .loadString("assets/data/layout.json");
    String components = await rootBundle.loadString("assets/data/resident_evil/core.json");
    return [jsonDecode(jsonString), jsonDecode(components)];
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
            ref
                .read(componentsProvider)
                .loadComponents(snapshot.data![1]);
            ref
                .read(campaignSavedStatusProvider)
                .loadCampaignState({
              "threatLevel": "5",
              "notes": "",
              "characters": [],
              "reserve": [],
              "itemA": [],
            });
            return MetaHandler(layout: snapshot.data![0], pathId: "root");
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
