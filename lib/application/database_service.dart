import 'dart:io';

import 'package:fencing_tracker/domain/collections/club.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._();

  late Isar _isarInstance;

  List<CollectionSchema<dynamic>> schemas = [
    ClubSchema,
  ];

  DatabaseService._();
  factory DatabaseService() => _instance;

  Isar get dbInstance => _isarInstance;

  Future<void> init() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    _isarInstance = await Isar.open(schemas, directory: directory.path);
  }
}
