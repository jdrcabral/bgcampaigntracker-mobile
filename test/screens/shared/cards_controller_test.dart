import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:campaigntrackerflutter/screens/shared/cards_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Meta handle with layout of tab returns MetaTab', (WidgetTester tester) async {
    CampaignSavedStatus campaignSavedStatus = CampaignSavedStatus(
      savedState: {
        'values': ["first", "second"],
      }
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          campaignSavedStatusProvider.overrideWith((ref) => campaignSavedStatus),
        ],
        child: MaterialApp(
        home: Scaffold(
          body: CardsController(
            title: 'Cards Controller',
            stateKey: "values", 
            options: ["options1", "options2"], 
            items: ["item1", "item2"],
            pathId: ""
            ),
          )
        )
      )
    );


    expect(find.text('first'), findsOneWidget);
    expect(find.text('second'), findsOneWidget);
  });
}