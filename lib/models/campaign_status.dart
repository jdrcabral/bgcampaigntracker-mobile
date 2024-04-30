import 'package:flutter_riverpod/flutter_riverpod.dart';

final campaignSavedStatusProvider = StateProvider<CampaignSavedStatus>((ref) => CampaignSavedStatus());

class CampaignSavedStatus {
  Map<String, dynamic> savedState = {};

  loadCampaignState(Map<String, dynamic> savedState) {
    this.savedState = savedState;
  }

  CampaignSavedStatus({ Map<String, dynamic>? savedState }) {
    this.savedState = savedState ?? {};
  }

  CampaignSavedStatus clone() {
    return CampaignSavedStatus(savedState: {...savedState});
  }
}
