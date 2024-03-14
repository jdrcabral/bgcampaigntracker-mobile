import 'package:campaigntrackerflutter/data/models/campaign.dart';
import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncreaseDecreaseTextField extends StatefulWidget {
  final int counter;
  const IncreaseDecreaseTextField({Key? key, required this.counter})
      : super(key: key);

  @override
  _IncreaseDecreaseTextFieldState createState() =>
      _IncreaseDecreaseTextFieldState();
}

class _IncreaseDecreaseTextFieldState extends State<IncreaseDecreaseTextField> {
  void updateCounter(int value) {
    Provider.of<CampaignStatus>(context, listen: false).threatLevel = value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Consumer<CampaignStatus>(
            builder: (context, campaignStatus, child) => IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (campaignStatus.threatLevel > 0) {
                      updateCounter(campaignStatus.threatLevel - 1);
                    }
                  },
                )),
        Consumer<CampaignStatus>(
            builder: (context, campaignStatus, child) => Text(
                  '${campaignStatus.threatLevel}',
                  style: const TextStyle(fontSize: 20),
                )),
        Consumer<CampaignStatus>(
            builder: (context, campaignStatus, child) => IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    updateCounter(campaignStatus.threatLevel + 1);
                  },
                )),
      ],
    );
  }
}
