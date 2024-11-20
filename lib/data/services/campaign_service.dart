import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:http/http.dart' as http;
import 'package:campaigntrackerflutter/data/database_service.dart';
import 'package:campaigntrackerflutter/data/models/campaign.dart';

class CampaignService {

  final DatabaseService _databaseService = DatabaseService();

  Future<List<Campaign>> list() async {
    if (kIsWeb) {
      var response = await http.get(Uri.parse('http://127.0.0.1:8000/campaigns'));
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => Campaign.fromMap(item)).toList();
    }
    return await _databaseService.listCampaign();
  }

  Future<void> create(Map<String, Object> campaign) async {
    if (kIsWeb) {
      var response = await http.post(
        Uri.parse('http://127.0.0.1:8000/campaigns/'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'board_game': campaign['board_game_id'],
          'name': campaign['name'],
          'saved_state': campaign['savedState'],
        }),
      );
      if (response.statusCode != 201) {
        print(response.body);
      }
      return;
    }
    return await _databaseService.createCampaign(<String, dynamic>{
        'board_game_id': campaign['board_game_id'],
        'name': campaign['name'],
        'saved_state': jsonEncode(campaign['savedState']),
  });
  }
}