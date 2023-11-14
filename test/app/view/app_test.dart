import 'package:flutter_test/flutter_test.dart';
import 'package:pet_cam/app/app.dart';
import 'package:pet_cam/sockets/view/socket_page.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(SocketPage), findsOneWidget);
    });
  });
}
