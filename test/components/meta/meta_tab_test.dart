import 'package:campaigntrackerflutter/components/meta/meta_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Meta tab with label', (WidgetTester tester) async {
    const Map<String, dynamic> layout = {
      'children': [
        {
          'label': 'TabName',
          'content': {
            'type': 'text',
            'label': 'TextTest',
          },
        },
      ],
    };
    await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MetaTab(layout: layout, pathId: 'root.tab',))
        )
    );
    expect(find.text('TabName'), findsOneWidget);
    expect(find.text('TextTest'), findsOneWidget);
  });
  testWidgets('Meta tab with multiples', (WidgetTester tester) async {
    const Map<String, dynamic> layout = {
      'children': [
        {
          'label': 'FirstTab',
          'content': {
            'type': 'text',
            'label': 'FirstText',
          },
        },
        {
          'label': 'SecondTab',
          'content': {
            'type': 'text',
            'label': 'SecondText',
          },
        },
      ],
    };
    await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MetaTab(layout: layout, pathId: 'root.tab',))
        )
    );
    expect(find.text('FirstTab'), findsOneWidget);
    expect(find.text('FirstText'), findsOneWidget);
    expect(find.text('SecondTab'), findsOneWidget);
    expect(find.text('SecondText'), findsNothing);

    // Changing tabs
    final secondTab = find.byType(Tab).at(1);
    await tester.tap(secondTab);
    await tester.pumpAndSettle();
    expect(find.text('FirstText'), findsNothing);
    expect(find.text('SecondText'), findsOneWidget);
  });
  testWidgets('Meta tab with icon', (WidgetTester tester) async {
    const Map<String, dynamic> layout = {
      'children': [
        {
          'label': 'TabName',
          'icon': 'settings',
          'content': {
            'type': 'text',
            'label': 'TextTest',
          },
        },
      ],
    };
    await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MetaTab(layout: layout, pathId: 'root.tab',))
        )
    );
    expect(find.byType(Icon), findsOne);
    expect(find.text('TabName'), findsOneWidget);
    expect(find.text('TextTest'), findsOneWidget);
  });
}
