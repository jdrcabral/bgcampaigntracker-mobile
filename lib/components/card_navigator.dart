import 'package:flutter/material.dart';

class CardNavigator extends StatelessWidget {
  final String cardTitle;
  final Widget navigateTo;

  const CardNavigator(
      {super.key, required this.cardTitle, required this.navigateTo});

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
          debugPrint('Card tapped. $navigateTo');
          // Navigator.pushNamed(context, '/campaigns');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => navigateTo));
        },
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          ListTile(
            title: Text(cardTitle),
          ),
        ]),
      ),
    );
  }
}
