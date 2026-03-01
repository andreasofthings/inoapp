import 'package:flutter_test/flutter_test.dart';
import 'package:pod/main.dart';

void main() {
  testWidgets('Method Toolkit smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PodApp(isLoggedIn: true));

    // Verify that our app shows the 'Coach\'s Toolkit' text.
    expect(find.text('Coach\'s Toolkit'), findsOneWidget);

    // 'Library' appears in the bottom navigation bar.
    expect(find.text('Library'), findsOneWidget);

    // 'Empathy Maps' appears in the Quick Picks.
    expect(find.text('Empathy Maps'), findsOneWidget);
  });
}
