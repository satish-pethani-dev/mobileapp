import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_preview/app.dart';

void main() {
  testWidgets('App renders landing screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MobilePreviewApp());

    expect(find.text('Shopify Mobile Preview'), findsOneWidget);
    expect(find.text('Scan preview QR'), findsOneWidget);
  });
}
