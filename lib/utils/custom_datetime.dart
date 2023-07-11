final List<String> _days = [
  'Lundi',
  'Mardi',
  'Mercredi',
  'Jeudi',
  'vendredi',
  'Samedi',
  'Dimanche',
];

final List<String> _months = [
  'Janvier',
  'Février',
  'Mars',
  'Avril',
  'Mai',
  'Juin',
  'Juillet',
  'Aout',
  'Septembre',
  'Octobre',
  'Novembre',
  'Décembre',
];

extension CustomDateTime on DateTime {
  String get weekdayString => _days[weekday - 1];

  String get monthString => _months[month - 1];
}
