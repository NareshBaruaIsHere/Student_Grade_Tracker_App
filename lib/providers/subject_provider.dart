import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/subject.dart';

class SubjectProvider extends ChangeNotifier {
  SubjectProvider() {
    _loadSubjects();
  }

  static const String _subjectsKey = 'subjects';
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

  Future<void> addSubject({required String name, required int mark}) async {
    _subjects.add(
      Subject(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        name: name.trim(),
        mark: mark,
      ),
    );
    await _saveSubjects();
    notifyListeners();
  }

  Future<void> updateSubject({
    required String id,
    required String name,
    required int mark,
  }) async {
    final index = _subjects.indexWhere((subject) => subject.id == id);
    if (index == -1) {
      return;
    }

    _subjects[index] = Subject(id: id, name: name.trim(), mark: mark);
    await _saveSubjects();
    notifyListeners();
  }

  Future<void> deleteSubjectById(String id) async {
    _subjects.removeWhere((subject) => subject.id == id);
    await _saveSubjects();
    notifyListeners();
  }

  Future<void> _saveSubjects() async {
    final preferences = await SharedPreferences.getInstance();
    final encoded = _subjects
        .map((subject) => jsonEncode(subject.toMap()))
        .toList();
    await preferences.setStringList(_subjectsKey, encoded);
  }

  Future<void> _loadSubjects() async {
    final preferences = await SharedPreferences.getInstance();
    final encoded = preferences.getStringList(_subjectsKey) ?? [];

    _subjects
      ..clear()
      ..addAll(
        encoded.map((item) {
          final map = jsonDecode(item) as Map<String, dynamic>;
          return Subject.fromMap(map);
        }),
      );

    notifyListeners();
  }
}
