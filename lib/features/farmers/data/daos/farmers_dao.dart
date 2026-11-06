import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

class FarmersDao {
  final AppDatabase db;

  FarmersDao(this.db);

  Future<List<FarmerData>> getAll() =>
      (db.select(db.farmers)..orderBy([(t) => OrderingTerm.asc(t.fullName)]))
          .get();

  Stream<List<FarmerData>> watchAll() =>
      (db.select(db.farmers)..orderBy([(t) => OrderingTerm.asc(t.fullName)]))
          .watch();

  Future<FarmerData?> getById(String id) =>
      (db.select(db.farmers)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<FarmerData?> getByMemberNumber(String memberNumber) =>
      (db.select(db.farmers)..where((t) => t.memberNumber.equals(memberNumber)))
          .getSingleOrNull();

  Future<List<FarmerData>> search(String query) => (db.select(db.farmers)
        ..where(
          (t) => t.fullName.like('%$query%') | t.memberNumber.like('%$query%'),
        ))
      .get();

  Future<List<FarmerData>> getUnsynced() =>
      (db.select(db.farmers)..where((t) => t.isSynced.equals(false))).get();

  Future<int> insertOrUpdate(FarmersCompanion farmer) =>
      db.into(db.farmers).insertOnConflictUpdate(farmer);

  Future<void> insertAll(List<FarmersCompanion> farmers) => db.batch(
        (batch) => batch.insertAllOnConflictUpdate(db.farmers, farmers),
      );

  Future<void> markSynced(List<String> ids) =>
      (db.update(db.farmers)..where((t) => t.id.isIn(ids))).write(
        FarmersCompanion(
          isSynced: const Value(true),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<int> deleteById(String id) =>
      (db.delete(db.farmers)..where((t) => t.id.equals(id))).go();
}
