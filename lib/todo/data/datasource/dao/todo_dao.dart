import 'package:moor_flutter/moor_flutter.dart';
import 'package:tasky/core/models/date_range.dart';
import 'package:tasky/todo/data/datasource/table/todos_table.dart';
import 'package:tasky/todo/data/datasource/todo_database.dart';

part 'todo_dao.g.dart';

@UseDao(tables: [Todos])
class TodoDao extends DatabaseAccessor<TodoDatabase> with _$TodoDaoMixin {
  final TodoDatabase db;

  TodoDao(this.db) : super(db);

  Future<void> insertTodo(TodosCompanion todo) => into(todos).insert(todo);
  Future<void> deleteTodo(Todo todo) => delete(todos).delete(todo);
  Future<void> completeTodo(Todo todo) =>
      update(todos).replace(todo.copyWith(done: 1));

  Stream<List<Todo>> todosByCategoryAndDateRange(
      Category? category, DateRange? dateRange) {
    var query = select(todos)
      ..orderBy([
        (t) => OrderingTerm.asc(t.date),
      ]);
    if (category != null) {
      query = query..where((tbl) => tbl.category.equals(category.name));
    }
    if (dateRange != null) {
      query = query
        ..where(
          (tbl) => tbl.date.isBetweenValues(
            dateRange.startTime,
            dateRange.endTime,
          ),
        );
    }
    return query.watch();
  }
}
