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
        MaterialApp(
            home: Scaffold(
                body: const MetaTextInput(layout: layout))
        )
    );

    final textInput = find.byType(TextField);

    await tester.enterText(textInput, 'Single line text');
    expect(find.text('Single line text'), findsOneWidget);

    await tester.enterText(textInput, 'Line 1\nLine 2\nLine 3');
    expect(find.text('Line 1\nLine 2\nLine 3'), findsOneWidget);
  });
}
