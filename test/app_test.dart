import 'package:f_bloc/counter/counter.dart';
import 'package:f_bloc/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Bloc App', () {
    testWidgets('render Counter Page', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
