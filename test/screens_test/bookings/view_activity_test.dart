import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/src/models/activity_model.dart';
import 'package:travellory/src/screens/activity/view_activity.dart';

final ActivityModel model = ActivityModel()
  ..category = 'Historic'
  ..title = 'Museum visit'
  ..imageNr = 9
  ..imagePath = 'assets/images/activity/activity_9.png'
  ..location = "100 King's Cross Rd, London WC1X 9DT"
  ..startDate = '2020-05-01'
  ..startTime = '12:00'
  ..endDate = '2020-05-01';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/view/activity', arguments: model);
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
        '/view/activity': (context) => ActivityView()
      },
    );
  }

  Future<void> pumpActivityView(WidgetTester tester) async {
    await tester.tap(find.text('X'));
    await tester.pump();
  }

  testWidgets('test if ActivityView page is loaded', (WidgetTester tester) async {
    final testKey = Key('ActivityView');

    await tester.pumpWidget(makeTestableWidget());

    expect(find.text('X'), findsOneWidget);
    expect(find.byKey(testKey, skipOffstage: false), findsNothing);

    await pumpActivityView(tester);
    expect(find.text('X'), findsOneWidget);
    expect(find.byKey(testKey, skipOffstage: false), isOffstage);
  });

  testWidgets('test if view booking header is present', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());
    await pumpActivityView(tester);

    expect(find.byKey(Key('ViewBookingHeader'), skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if view activity page content is present', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());
    await pumpActivityView(tester);

    expect(find.byKey(Key('ActivityViewPage'), skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if bottom bar is present', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());
    await pumpActivityView(tester);

    expect(find.byKey(Key('BottomBar'), skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if exit view button is present', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());
    await pumpActivityView(tester);

    expect(find.byKey(Key('ExitViewPage'), skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if all view fields are present', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());
    await pumpActivityView(tester);

    expect(find.byKey(Key('SectionTitle'), skipOffstage: false), findsNWidgets(3));
    expect(find.byIcon(FontAwesomeIcons.clock, skipOffstage: false), findsNWidgets(2));
    expect(find.byIcon(FontAwesomeIcons.calendarAlt, skipOffstage: false), findsNWidgets(2));
    expect(find.byIcon(FontAwesomeIcons.star, skipOffstage: false), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.mapMarkerAlt, skipOffstage: false), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.info, skipOffstage: false), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.stickyNote, skipOffstage: false), findsOneWidget);
  });
}
