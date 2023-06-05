import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:tasky/todo/data/datasource/table/categorys_table.dart';
import 'package:tasky/todo/data/datasource/table/todos_table.dart';

part 'todo_database.g.dart';

const _dbVersion = 1;
const _dbName = "todos.db";

@DriftDatabase(tables: [Todos, Categorys])
class TodoDatabase extends _$TodoDatabase {
  TodoDatabase(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => _dbVersion;
}

LazyDatabase openDatabaseConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, _dbName));
    return NativeDatabase.createInBackground(file);
  });
}
