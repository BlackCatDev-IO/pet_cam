import 'package:flutter_test/flutter_test.dart';
import 'package:pet_cam/app/view/app.dart';
import 'package:pet_cam/p2p_connections/view/home_page.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
