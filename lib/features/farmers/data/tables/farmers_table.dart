import 'package:drift/drift.dart';

/// Registered tea farmers, kept locally for offline lookup at collection centres.
@DataClassName('FarmerData')
class Farmers extends Table {
  TextColumn get id => text()();
  TextColumn get memberNumber => text().unique()();
  TextColumn get fullName => text()();
  TextColumn get phoneNumber => text().nullable()();
  TextColumn get nationalId => text().nullable()();
  TextColumn get collectionCentre => text().nullable()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
