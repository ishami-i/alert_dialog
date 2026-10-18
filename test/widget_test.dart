import 'package:flutter_test/flutter_test.dart';

import 'package:alert_dialog/main.dart';

void main() {
  testWidgets('Product delete and return to main test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProductApp());

    // Verify product list page shows products
    expect(find.text('Pixel'), findsOneWidget);
    expect(find.text('Laptop'), findsOneWidget);

    // Tap on Pixel product
    await tester.tap(find.text('Pixel'));
    await tester.pumpAndSettle();

    // Verify we are on Product Detail Page
    expect(find.text('Pixel is the most featureful phone ever'), findsOneWidget);

    // Scroll until Delete button is visible
    await tester.scrollUntilVisible(
      find.text('Delete'),
      100,
    );

    // Tap Delete button
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    // Verify Alert Dialog shows
    expect(find.text('Confirm?'), findsOneWidget);
    expect(find.text('Do you want to Delete the Pixel?'), findsOneWidget);

    // Tap YES to confirm deletion and return to main
    await tester.tap(find.text('YES'));
    await tester.pumpAndSettle();

    // Verify we are back on main Product List Page and Pixel is removed from page
    expect(find.text('Product Navigation'), findsOneWidget);
    expect(find.text('Pixel'), findsNothing);
    expect(find.text('Laptop'), findsOneWidget);
  });
}
