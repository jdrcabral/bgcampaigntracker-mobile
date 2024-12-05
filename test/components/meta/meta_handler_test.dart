import 'package:campaigntrackerflutter/components/meta/meta_handler.dart';
import 'package:campaigntrackerflutter/components/meta/meta_tab.dart';
import 'package:campaigntrackerflutter/components/meta/meta_text_input.dart';
import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Meta handle with layout of tab returns MetaTab', (WidgetTester tester) async {
    Map<String, dynamic> layout = {
        "type": "tab",
        "children": [
          {
            "label": "Title",
            "icon": "home",
            "type": "tabContent",
            "content": {
              "type": "text",
              "label": "Threat Level"
            },
          }
        ]
    };

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MetaHandler(layout: layout, pathId: 'root',))
      )
    );

    expect(find.byType(MetaTab), findsOneWidget);
    expect(find.text('Title'), findsOneWidget);
    expect(find.byType(Icon), findsOne);
    expect(find.text('Threat Level'), findsOneWidget);
  });

    testWidgets('Meta handle with layout of input returns MetaTextInput', (WidgetTester tester) async {
    Map<String, dynamic> layout = {
        'type': 'input',
        'inputType': 'multiline',
        'ref': 'notes'
    };
    CampaignSavedStatus campaignSavedStatus = CampaignSavedStatus(
      savedState: {
        'notes': 'Already have a note',
      }
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          campaignSavedStatusProvider.overrideWith((ref) => campaignSavedStatus),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: MetaHandler(layout: layout, pathId: 'root',))
        )
      )
    );

    expect(find.byType(MetaTextInput), findsOneWidget);
    expect(tester.widget<TextField>(find.byType(TextField)).keyboardType, TextInputType.multiline);
  });
}
