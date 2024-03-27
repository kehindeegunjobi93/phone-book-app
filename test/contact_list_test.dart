import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:phone_book_app/pages/contact_detail.dart';
import 'package:phone_book_app/pages/contact_list.dart';

// Mock NavigatorObserver to verify navigation
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets('Contact list page displays contacts',
      (WidgetTester tester) async {
    // Create a mock navigator observer
    final mockObserver = MockNavigatorObserver();

    // Build the ContactListPage
    await tester.pumpWidget(
      MaterialApp(
        home: const ContactList(),
        navigatorObservers: [mockObserver],
      ),
    );

    // Expect to find at least one contact
    expect(find.byType(ListTile), findsOneWidget);
  });

  testWidgets('Contacts are clickable and navigate to detail page',
      (WidgetTester tester) async {
    // Create a mock navigator observer
    final mockObserver = MockNavigatorObserver();

    // Build the ContactListPage
    await tester.pumpWidget(
      MaterialApp(
        home: const ContactList(),
        navigatorObservers: [mockObserver],
      ),
    );

    // Tap the first contact tile
    await tester.tap(find.byType(ListTile).first);

    // Wait for the Navigator to complete the transition
    await tester.pumpAndSettle();

    Route<dynamic> myRoute =
        MaterialPageRoute(builder: (context) => const ContactDetail());

    // Verify that the Navigator pushed a route to the detail page
    verify(mockObserver.didPush(myRoute, any));

    // Verify that the detail page is displayed
    expect(find.text('Choose Avatar'), findsOneWidget);
  });
}
