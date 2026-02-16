import 'package:flutter_test/flutter_test.dart';
import 'package:pod/main.dart';

void main() {
  testWidgets('Method Toolkit smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PodApp());

    // Verify that our app shows the 'Method Toolkit' text.
    expect(find.text('Method Toolkit'), findsOneWidget);
    // 'Library' appears in the header and in the bottom navigation bar.
    expect(find.text('Library'), findsNWidgets(2));
    expect(find.text('Empathy Maps'), findsOneWidget);
  });
}
