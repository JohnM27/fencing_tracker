import 'package:fencing_tracker/application/database_service.dart';
import 'package:fencing_tracker/domain/collections/club.dart';
import 'package:isar/isar.dart';

class ClubService {
  Future<bool> createClub(String name) async {
    Isar db = DatabaseService().dbInstance;
    try {
      await db.writeTxn(() async {
        await db.clubs.put(Club()..name = name);
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
