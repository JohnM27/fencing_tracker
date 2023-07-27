final List<String> daysList = [
  'Lundi',
  'Mardi',
  'Mercredi',
  'Jeudi',
  'vendredi',
  'Samedi',
  'Dimanche',
];

final List<String> monthsList = [
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
  String get weekdayString => daysList[weekday - 1];

  String get monthString => monthsList[month - 1];
}
