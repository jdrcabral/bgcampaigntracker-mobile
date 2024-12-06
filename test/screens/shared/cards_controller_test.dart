import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:campaigntrackerflutter/screens/shared/cards_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Meta handle with layout of tab returns MetaTab', (WidgetTester tester) async {
    CampaignSavedStatus campaignSavedStatus = CampaignSavedStatus(
      savedState: {
        'values': ["first", "second"],
      }
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          campaignSavedStatusProvider.overrideWith((ref) => campaignSavedStatus),
        ],
        child: MaterialApp(
        home: Scaffold(
          body: CardsController(
            title: 'Cards Controller',
            stateKey: "values", 
            options: ["options1", "options2"], 
            items: ["item1", "item2"],
            pathId: ""
            ),
          )
        )
      )
    );

    expect(find.text('first'), findsOneWidget);
    expect(find.text('second'), findsOneWidget);
    
    final floatingButton = find.byType(FloatingActionButton);
    await tester.tap(floatingButton);
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);

    // Close with Cancel the dialog
    final cancelButton = find.byType(TextButton).at(1);
    await tester.tap(cancelButton);
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);

    // Reopen the dialog
    await tester.tap(floatingButton);
    await tester.pumpAndSettle();

    // Select item and add
    final dropdownSearch = find.byType(DropdownSearch<String>);
    await tester.tap(dropdownSearch);
    await tester.pumpAndSettle();

    final item = find.text('options1');
    await tester.tap(item);
    await tester.pumpAndSettle();

    final addButton = find.byType(TextButton).at(0);
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text('options1'), findsOneWidget);

    // Delete the second item
    final deleteButton = find.byType(IconButton).at(1);
    await tester.tap(deleteButton);
    await tester.pumpAndSettle();

    expect(find.text('first'), findsOneWidget);
    expect(find.text('second'), findsNothing);
    expect(find.text('options1'), findsOneWidget);
  });
}