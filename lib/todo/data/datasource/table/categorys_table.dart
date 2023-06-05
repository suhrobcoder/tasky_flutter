import 'package:drift/drift.dart';

class Categorys extends Table {
  TextColumn get name => text()();
  TextColumn get color => text()();

  @override
  Set<Column>? get primaryKey => {name};
}
