import 'package:flutter/foundation.dart';

class CampaignStatus extends ChangeNotifier {
  int _threatLevel = 0;
  int get threatLevel => _threatLevel;
  set threatLevel(int value) {
    _threatLevel = value;
    notifyListeners();
  }
}
