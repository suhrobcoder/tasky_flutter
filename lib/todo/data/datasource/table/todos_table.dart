import 'package:moor_flutter/moor_flutter.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get category => text()();
  DateTimeColumn get date => dateTime()();
  BoolColumn get notification => boolean()();
  BoolColumn get priorityHigh => boolean()();
  IntColumn get done => integer().withDefault(const Constant(0))();
}
