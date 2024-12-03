import 'package:campaigntrackerflutter/components/meta/meta_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Meta Card should render child', (WidgetTester tester) async {
    const Map<String, dynamic> layout = {
      'child': {
        'type': 'text',
        'label': 'test',
      },
    };
    await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MetaCard(layout: layout, pathId: 'root.card',))
        )
    );
    final card = find.byType(Card);
    expect(card, findsOneWidget);
    expect(find.descendant(of: find.byType(Card), matching: find.byType(Text)), findsWidgets);
    expect(find.text('test'), findsOneWidget);
  });
  testWidgets('Meta Card should not render any component', (WidgetTester tester) async {
    Map<String, dynamic> empty = {};
    Map<String, dynamic> layout = {
      'child': empty,
    };
    await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MetaCard(layout: layout, pathId: 'root.card',))
        )
    );
    final card = find.byType(Card);
    expect(card, findsOneWidget);
    expect(find.descendant(of: find.byType(Card), matching: find.byType(Widget)), findsNothing);
  });
}
