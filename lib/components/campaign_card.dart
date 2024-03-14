import 'package:campaigntrackerflutter/screens/campaign_detail.dart';
import 'package:flutter/material.dart';

class CampaignCard extends StatelessWidget {
  const CampaignCard({Key? key}) : super(key: key);

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
              MaterialPageRoute(builder: (context) => const CampaignDetail()));
        },
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          const ListTile(
            leading: Icon(Icons.album),
            title: Text('The Enchanted Nightingale'),
            subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
          ),
        ]),
      ),
    );
  }
}
