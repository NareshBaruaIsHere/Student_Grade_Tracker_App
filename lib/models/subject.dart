class Subject {
  Subject({required this.id, required this.name, required int mark})
    : _mark = mark;

  final String id;

  final String name;
  final int _mark;

  int get mark => _mark;

  String get grade => gradeFromMark(_mark.toDouble());

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'mark': _mark};
  }

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      id: map['id'] as String,
      name: map['name'] as String,
      mark: map['mark'] as int,
    );
  }

  static String gradeFromMark(double mark) {
    if (mark >= 80) {
      return 'A';
    }
    if (mark >= 65) {
      return 'B';
    }
    if (mark >= 50) {
      return 'C';
    }
    return 'F';
  }
}
