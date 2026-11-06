import 'package:drift/drift.dart';

import '../../features/farmers/data/tables/farmers_table.dart';
import 'connection/connection.dart';

part 'app_database.g.dart';

/// TeaTrack Drift local database.
///
/// After changing tables, bump [schemaVersion], add a step to `onUpgrade`,
/// then run: `dart run build_runner build --delete-conflicting-outputs`
@DriftDatabase(tables: [
  Farmers,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {},
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  /// Removes every local row. Only call once nothing is left unsynced.
  Future<void> deleteAllRecords() {
    return transaction(() async {
      await delete(farmers).go();
    });
  }
}
