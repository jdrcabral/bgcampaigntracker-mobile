import 'package:campaigntrackerflutter/screens/campaign_detail.dart';
import 'package:flutter/material.dart';

class CampaignCard extends StatelessWidget {
  final String title;
  final int id;
  final DateTime updatedAt;
  const CampaignCard(
      {Key? key,
      required this.id,
      required this.title,
      required this.updatedAt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // clipBehavior is necessary because, without it, the InkWell's animation
      // will extend beyond the rounded edges of the [Card] (see https://github.com/flutter/flutter/issues/109776)
      // This comes with a small performance cost, and you should not set [clipBehavior]
      // unless you need it.
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
