import 'package:campaigntrackerflutter/components/card_navigator.dart';
import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:campaigntrackerflutter/screens/shared/cards_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Meta handle with layout of tab returns MetaTab', (WidgetTester tester) async {
    CampaignSavedStatus campaignSavedStatus = CampaignSavedStatus(
      savedState: {
        'values': [],
      }
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          campaignSavedStatusProvider.overrideWith((ref) => campaignSavedStatus),
        ],
        child: MaterialApp(
        home: Scaffold(
          body: CardNavigator(
            cardTitle: 'Card Title',
            navigateTo: CardsController(
              title: 'Cards Controller',
              stateKey: "values", 
              options: [], 
              items: [],
              pathId: ""
              ),
            )
          )
        )
      )
    );

    expect(find.byType(CardNavigator), findsOneWidget);
    expect(find.text('Card Title'), findsOneWidget);
    expect(find.text('Cards Controller'), findsNothing);

    await tester.tap(find.byType(Card));
    await tester.pumpAndSettle();
    expect(find.text('Card Title'), findsNothing);
    expect(find.text('Cards Controller'), findsOneWidget);
  });
}