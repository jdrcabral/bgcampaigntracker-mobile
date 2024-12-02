import 'package:campaigntrackerflutter/components/meta/meta_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Meta text input with multiline', (WidgetTester tester) async {
    const Map<String, dynamic> layout = {
      'inputType': 'multiline',
    };
    // Build our app and trigger a frame.
    await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MetaTextInput(layout: layout))
        )
    );

    final textInput = find.byType(TextField);

    await tester.enterText(textInput, 'Single line text');
    expect(find.text('Single line text'), findsOneWidget);

    await tester.enterText(textInput, 'Line 1\nLine 2\nLine 3');
    expect(find.text('Line 1\nLine 2\nLine 3'), findsOneWidget);
    expect(tester.widget<TextField>(textInput).keyboardType, TextInputType.multiline);
  });

  testWidgets('Meta text input with number', (WidgetTester tester) async {
    const Map<String, dynamic> layout = {
      'inputType': 'number',
    };
    // Build our app and trigger a frame.
    await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MetaTextInput(layout: layout))
        )
    );

    final textInput = find.byType(TextField);

    await tester.enterText(textInput, '123');
    expect(find.text('123'), findsOneWidget);
    expect(tester.widget<TextField>(textInput).keyboardType, TextInputType.number);
  });
}
