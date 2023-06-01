import 'package:isar/isar.dart';

part 'club.g.dart';

@collection
class Club {
  Id id = Isar.autoIncrement;

  late String name;
}
