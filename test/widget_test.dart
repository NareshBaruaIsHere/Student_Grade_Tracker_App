import 'package:flutter_test/flutter_test.dart';

import 'package:student_grade_tracker_app/main.dart';

void main() {
  testWidgets('App loads with title', (WidgetTester tester) async {
    await tester.pumpWidget(const StudentGradeTrackerApp());

    expect(find.text('Student Grade Tracker'), findsOneWidget);
  });
}
