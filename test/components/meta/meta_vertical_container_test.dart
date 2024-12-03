import 'package:campaigntrackerflutter/components/meta/meta_vertical_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Meta Vertical Container should render children inside a column', (WidgetTester tester) async {
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
            body: MetaVerticalContainer(layout: layout, pathId: 'root.verticalContainer',))
        )
    );
    final column = find.byType(Column);
    expect(column, findsOneWidget);
    expect(find.descendant(of: find.byType(Column), matching: find.byType(Text)), findsWidgets);
    expect(find.text('test'), findsOneWidget);
  });
  testWidgets('Meta Vertical Container should not render any component', (WidgetTester tester) async {
    const Map<String, dynamic> layout = {
      'children': [],
    };
    await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MetaVerticalContainer(layout: layout, pathId: 'root.verticalContainer',))
        )
    );
    final column = find.byType(Column);
    expect(column, findsOneWidget);
    expect(find.descendant(of: find.byType(Column), matching: find.byType(Widget)), findsNothing);
  });
}
