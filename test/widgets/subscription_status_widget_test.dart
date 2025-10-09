import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noujoum_store/widgets/subscription_status_widget.dart';
import 'package:noujoum_store/screens/subscription_packages_screen.dart';

void main() {
  group('SubscriptionStatusWidget Navigation Tests', () {
    testWidgets('should navigate to packages screen when button is pressed', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: const SubscriptionStatusWidget(),
          ),
        ),
      );

      // Wait for the widget to load
      await tester.pumpAndSettle();

      // Look for navigation buttons (there might be multiple depending on subscription status)
      final navigationButtons = find.byType(ElevatedButton);
      
      if (navigationButtons.evaluate().isNotEmpty) {
        // Tap the first navigation button
        await tester.tap(navigationButtons.first);
        await tester.pumpAndSettle();

        // Verify that the SubscriptionPackagesScreen is pushed
        expect(find.byType(SubscriptionPackagesScreen), findsOneWidget);
      }
    });

    testWidgets('should prevent multiple rapid navigation attempts', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: const SubscriptionStatusWidget(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final navigationButtons = find.byType(ElevatedButton);
      
      if (navigationButtons.evaluate().isNotEmpty) {
        // Tap the button multiple times rapidly
        await tester.tap(navigationButtons.first);
        await tester.tap(navigationButtons.first);
        await tester.tap(navigationButtons.first);
        
        await tester.pumpAndSettle();

        // Should only have one SubscriptionPackagesScreen
        expect(find.byType(SubscriptionPackagesScreen), findsOneWidget);
      }
    });

    testWidgets('should show loading indicator during navigation', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: const SubscriptionStatusWidget(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final navigationButtons = find.byType(ElevatedButton);
      
      if (navigationButtons.evaluate().isNotEmpty) {
        // Tap the button
        await tester.tap(navigationButtons.first);
        await tester.pump(); // Don't settle, so we can see the loading state

        // Should show loading indicator
        expect(find.byType(CircularProgressIndicator), findsAtLeastNWidgets(1));
      }
    });
  });
}
