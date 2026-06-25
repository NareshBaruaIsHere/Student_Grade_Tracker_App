import 'package:flutter/foundation.dart';

import '../models/subject.dart';

class SubjectProvider extends ChangeNotifier {
  final List<Subject> _subjects = [];

  List<Subject> get subjects => List.unmodifiable(_subjects);

  List<Subject> get passingSubjects =>
      _subjects.where((subject) => subject.mark >= 50).toList();

  int get totalSubjects => _subjects.length;

  double get averageMark {
    if (_subjects.isEmpty) {
      return 0;
    }
    final marks = _subjects.map((subject) => subject.mark);
    final sum = marks.fold<int>(0, (total, mark) => total + mark);
    return sum / _subjects.length;
  }

  String get overallGrade => Subject.gradeFromMark(averageMark);

  void addSubject({required String name, required int mark}) {
    _subjects.add(Subject(name: name.trim(), mark: mark));
    notifyListeners();
  }

  void deleteSubjectAt(int index) {
    _subjects.removeAt(index);
    notifyListeners();
  }
}