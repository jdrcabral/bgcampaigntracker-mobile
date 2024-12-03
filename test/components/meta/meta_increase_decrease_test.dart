import 'package:campaigntrackerflutter/components/meta/meta_increase_decrease.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:campaigntrackerflutter/models/campaign_status.dart';

void main() {
  testWidgets('Meta increase and decrease', (WidgetTester tester) async {
    CampaignSavedStatus campaignSavedStatus = CampaignSavedStatus(
      savedState: {
        'quantity': '0',
      }
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          campaignSavedStatusProvider.overrideWith((ref) => campaignSavedStatus),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: MetaIncreaseDecrease(stateKey: 'quantity',))
        )
      )
    );
    expect(find.text('0'), findsOneWidget);

    final decreaseButton = find.byType(IconButton).at(0);
    final increaseButton = find.byType(IconButton).at(1);
    expect(decreaseButton, findsOneWidget);
    expect(increaseButton, findsOneWidget);

    await tester.tap(increaseButton);
    await tester.pumpAndSettle();
    expect(find.text('1'), findsOneWidget);
    await tester.tap(increaseButton);
    await tester.pumpAndSettle();
    expect(find.text('2'), findsOneWidget);

    await tester.tap(decreaseButton);
    await tester.pumpAndSettle();
    expect(find.text('1'), findsOneWidget);
    await tester.tap(decreaseButton);
    await tester.pumpAndSettle();
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('Meta increase and decrease does not go bellow 0', (WidgetTester tester) async {
    CampaignSavedStatus campaignSavedStatus = CampaignSavedStatus(
      savedState: {
        'quantity': '0',
      }
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          campaignSavedStatusProvider.overrideWith((ref) => campaignSavedStatus),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: MetaIncreaseDecrease(stateKey: 'quantity',))
        )
      )
    );
    expect(find.text('0'), findsOneWidget);

    final decreaseButton = find.byType(IconButton).at(0);
    expect(decreaseButton, findsOneWidget);

    await tester.tap(decreaseButton);
    await tester.pumpAndSettle();
    expect(find.text('0'), findsOneWidget);
    await tester.tap(decreaseButton);
    await tester.pumpAndSettle();
    expect(find.text('0'), findsOneWidget);
  });
}
