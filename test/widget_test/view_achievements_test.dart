import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:travellory/src/providers/achievements_provider.dart';
import 'package:travellory/src/screens/achievements/view_achievements.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/view/achievements');
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AchievementsProvider>(
              create: (context) => AchievementsProvider()),
        ],
        child: MaterialApp(
          routes: <String, WidgetBuilder>{
            '/': (context) => const Wrapper(),
            '/view/achievements': (context) => AchievementsView()
          },
        ));
  }

  Future<void> pumpFlightView(WidgetTester tester) async {
    await tester.tap(find.text('X'));
    await tester.pump();
  }

  // TODO(bertaben): fix test
  testWidgets('test if AchievementsView page is loaded',
      (WidgetTester tester) async {
    final testKey = Key('AchievementsView');

    await tester.pumpWidget(makeTestableWidget());

    expect(find.text('X'), findsOneWidget);
    expect(find.byKey(testKey, skipOffstage: false), findsNothing);

    await pumpFlightView(tester);
    expect(find.text('X'), findsOneWidget);
    expect(find.byKey(testKey, skipOffstage: false), isOffstage);
  });

  testWidgets('test if all continent progress bar are present',
      (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());
    await pumpFlightView(tester);

    expect(find.byKey(Key('World'), skipOffstage: false), findsOneWidget);
    expect(find.byKey(Key('Europe'), skipOffstage: false), findsOneWidget);
    expect(find.byKey(Key('Asia'), skipOffstage: false), findsOneWidget);
    expect(
        find.byKey(Key('North America'), skipOffstage: false), findsOneWidget);
    expect(
        find.byKey(Key('South America'), skipOffstage: false), findsOneWidget);
    expect(
        find.byKey(Key('Africa'), skipOffstage: false), findsOneWidget);
  });
}
