import 'package:moor_flutter/moor_flutter.dart';
import 'package:tasky/todo/data/datasource/dao/category_dao.dart';
import 'package:tasky/todo/data/datasource/table/categorys_table.dart';
import 'package:tasky/todo/data/datasource/table/todos_table.dart';
import 'package:tasky/todo/data/datasource/dao/todo_dao.dart';

part 'todo_database.g.dart';

const _dbVersion = 1;
const _dbName = "todos.db";

@UseMoor(tables: [Todos, Categorys], daos: [TodoDao, CategoryDao])
class TodoDatabase extends _$TodoDatabase {
  TodoDatabase()
      : super(
          FlutterQueryExecutor.inDatabaseFolder(
              path: _dbName, logStatements: true)
        );

  @override
  int get schemaVersion => _dbVersion;
}
