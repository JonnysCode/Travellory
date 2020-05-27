import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/src/components/animations/loading_logo.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/loadingLogo');
      },
      child: Container(
        color: const Color(0xFFFFFF00),
        child: const Text('X'),
      ),
    );
  }
}

void main() {
  Widget makeTestableWidget() {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/': (context) => const Wrapper(),
        '/loadingLogo': (context) => LoadingLogo()
      },
    );
  }

  Future<void> pumpLoadingLogo(WidgetTester tester) async {
    await tester.tap(find.text('X'));
    await tester.pump();
  }

  testWidgets('loading logo test', (WidgetTester tester) async {
    final testKey = Key('LoadingLogo');

    await tester.pumpWidget(makeTestableWidget());
    expect(find.text('X'), findsOneWidget);
    expect(find.byKey(testKey, skipOffstage: false), findsNothing);

    await pumpLoadingLogo(tester);
    expect(find.text('X'), findsOneWidget);
    expect(find.byKey(testKey, skipOffstage: false), isOffstage);
  });
}
