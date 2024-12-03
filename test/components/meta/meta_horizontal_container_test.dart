import 'package:campaigntrackerflutter/components/meta/meta_horizontal_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Meta Horizontal Container should render children inside a Row', (WidgetTester tester) async {
    const Map<String, dynamic> layout = {
      'children': [
        {
          'type': 'text',
          'label': 'test',
        },
      ],
    };
    await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MetaHorizontalContainer(layout: layout, pathId: 'root.horizontalContainer',))
        )
    );
    final row = find.byType(Row);
    expect(row, findsOneWidget);
    expect(find.descendant(of: find.byType(Row), matching: find.byType(Text)), findsWidgets);
    expect(find.text('test'), findsOneWidget);
  });
  testWidgets('Meta Horizontal Container should not render any component', (WidgetTester tester) async {
    const Map<String, dynamic> layout = {
      'children': [],
    };
    await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MetaHorizontalContainer(layout: layout, pathId: 'root.horizontalContainer',))
        )
    );
    final row = find.byType(Row);
    expect(row, findsOneWidget);
    expect(find.descendant(of: find.byType(Row), matching: find.byType(Widget)), findsNothing);
  });
}
