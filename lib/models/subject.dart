class Subject {
  Subject({required this.name, required int mark}) : _mark = mark;

  final String name;
  final int _mark;

  int get mark => _mark;

  String get grade => gradeFromMark(_mark.toDouble());

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