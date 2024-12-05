import 'package:campaigntrackerflutter/components/meta/meta_text_input.dart';
import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Meta text input with multiline', (WidgetTester tester) async {
    const Map<String, dynamic> layout = {
      'inputType': 'multiline',
      'ref': 'notes'
    };
    CampaignSavedStatus campaignSavedStatus = CampaignSavedStatus(
      savedState: {
        'notes': '',
      }
    );
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          campaignSavedStatusProvider.overrideWith((ref) => campaignSavedStatus),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: MetaTextInput(layout: layout, pathId: "root.textInput"))
        )
      )
    );

    final textInput = find.byType(TextField);

    await tester.enterText(textInput, 'Single line text');
    await tester.pumpAndSettle();
    expect(find.text('Single line text'), findsOneWidget);

    await tester.enterText(textInput, 'Line 1\nLine 2\nLine 3');
    await tester.pumpAndSettle();
    expect(find.text('Line 1\nLine 2\nLine 3'), findsOneWidget);
    expect(tester.widget<TextField>(textInput).keyboardType, TextInputType.multiline);
  });
  
    testWidgets('Meta text input with multiline and starting state', (WidgetTester tester) async {
    const Map<String, dynamic> layout = {
      'inputType': 'multiline',
      'ref': 'notes',
    };
    CampaignSavedStatus campaignSavedStatus = CampaignSavedStatus(
      savedState: {
        'notes': 'Already have a note',
      }
    );
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          campaignSavedStatusProvider.overrideWith((ref) => campaignSavedStatus),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: MetaTextInput(layout: layout, pathId: "root.textInput"))
        )
      )
    );

    expect(find.text('Already have a note'), findsOneWidget);
    final textInput = find.byType(TextField);

    await tester.enterText(textInput, 'Single line text');
    await tester.pumpAndSettle();
    expect(find.text('Single line text'), findsOneWidget);

    await tester.enterText(textInput, 'Line 1\nLine 2\nLine 3');
    await tester.pumpAndSettle();
    expect(find.text('Line 1\nLine 2\nLine 3'), findsOneWidget);
    expect(tester.widget<TextField>(textInput).keyboardType, TextInputType.multiline);
  });
  testWidgets('Meta text input with number', (WidgetTester tester) async {
    const Map<String, dynamic> layout = {
      'inputType': 'number',
      'ref': 'threatLevel'
    };
    CampaignSavedStatus campaignSavedStatus = CampaignSavedStatus(
      savedState: {
        'trheatLevel': '0',
      }
    );
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          campaignSavedStatusProvider.overrideWith((ref) => campaignSavedStatus),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: MetaTextInput(layout: layout, pathId: "root.textInput"))
        )
      )
    );

    final textInput = find.byType(TextField);

    await tester.enterText(textInput, '123');
    await tester.pumpAndSettle();
    expect(find.text('123'), findsOneWidget);
    expect(tester.widget<TextField>(textInput).keyboardType, TextInputType.number);
  });
}
