import 'package:campaigntrackerflutter/components/meta/meta_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:campaigntrackerflutter/models/campaign_status.dart';

void main() {
  testWidgets('Meta checkbox', (WidgetTester tester) async {
    CampaignSavedStatus campaignSavedStatus = CampaignSavedStatus(
      savedState: {
        'status': false,
      }
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          campaignSavedStatusProvider.overrideWith((ref) => campaignSavedStatus),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: MetaCheckbox(layout: {'ref': 'status'}, pathId: "root",))
        )
      )
    );
    final checkbox = find.byType(Checkbox);
    expect(tester.widget<Checkbox>(checkbox).value, isFalse);

    await tester.tap(checkbox);
    await tester.pumpAndSettle();

    expect(tester.widget<Checkbox>(checkbox).value, isTrue);
  });
}
