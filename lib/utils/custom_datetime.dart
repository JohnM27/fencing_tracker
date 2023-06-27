final List<String> _days = [
  'Lundi',
  'Mardi',
  'Mercredi',
  'Jeudi',
  'vendredi',
  'Samedi',
  'Dimanche',
];

extension CustomDateTime on DateTime {
  String get weekdayString => _days[weekday - 1];
}
