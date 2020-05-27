import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/src/components/shared/banner.dart';

void main() {
  testWidgets('ClipPath', (WidgetTester tester) async {
    final String bannerUrl = 'assets/images/bookings/achievements_banner.jpg';

    await tester.pumpWidget(ClipPath(
      clipper: ArcClipper(),
      child: Image.asset(
        bannerUrl,
        width: 200.0,
        height: 200.0,
        fit: BoxFit.cover,
      ),
    ));

    expect(find.byType(ClipPath, skipOffstage: false), findsOneWidget);
  });

  test('ClipPath', () {
    Path p = ArcClipper().getClip(Size(400, 400));

    expect(p.contains(Offset(0, 0)), isTrue);
    expect(p.contains(Offset(200, 400)), isTrue);
    expect(p.contains(Offset(400, 370)), isTrue);
  });
}
