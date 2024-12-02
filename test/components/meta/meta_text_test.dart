import 'package:campaigntrackerflutter/components/meta/meta_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:campaigntrackerflutter/models/campaign_status.dart';

void main() {
  testWidgets('Meta text with label', (WidgetTester tester) async {
    const Map<String, dynamic> layout = {
      'label': 'Label',
    };
    // Build our app and trigger a frame.
    await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MetaText(layout: layout, pathId: "root.text",))
        )
    );

    expect(find.text('Label'), findsOneWidget);
  });

  testWidgets('Meta text with ref', (WidgetTester tester) async {
    const Map<String, dynamic> layout = {
      'ref': 'characters.index.name',
    };    
    CampaignSavedStatus campaignSavedStatus = CampaignSavedStatus(
      savedState: {
        'characters': [
          {
            'name': 'Ignore',
          },
          {
            'name': 'Test',
          },
        ],
      }
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          campaignSavedStatusProvider.overrideWith((ref) => campaignSavedStatus),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: MetaText(layout: layout, pathId: "root.1.text",))
        )
      )
    );
    expect(find.text('Test'), findsOneWidget);
  });
}
