import 'package:campaigntrackerflutter/screens/campaign_detail.dart';
import 'package:flutter/material.dart';

class MetaCard extends StatelessWidget {
  final String title;
  final int id;
  final DateTime updatedAt;
  const MetaCard(
      {Key? key,
      required this.id,
      required this.title,
      required this.updatedAt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          debugPrint('Card tapped.');
          // Navigator.pushNamed(context, '/campaigns');
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CampaignDetail(id: id)));
        },
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          ListTile(
            leading: Icon(Icons.gamepad),
            title: Text(title),
            subtitle: Text('Updated at: ${updatedAt.toIso8601String()}'),
          ),
        ]),
      ),
    );
  }
}
