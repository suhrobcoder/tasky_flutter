import 'package:moor_flutter/moor_flutter.dart';
import 'package:tasky/todo/data/datasource/category_with_count.dart';
import 'package:tasky/todo/data/datasource/table/todos_table.dart';
import 'package:tasky/todo/data/datasource/todo_database.dart';
import 'package:tasky/todo/data/datasource/table/categorys_table.dart';

part 'category_dao.g.dart';

@UseDao(tables: [Categorys, Todos])
class CategoryDao extends DatabaseAccessor<TodoDatabase>
    with _$CategoryDaoMixin {
  final TodoDatabase db;

  CategoryDao(this.db) : super(db);

  Future<void> insertCategory(CategorysCompanion category) =>
      into(categorys).insert(category);

  Stream<CategoryWithCount> getCategory(String name) {
    final allTasks = todos.id.count();
    final doneTasks = todos.done.sum();
    var query = select(categorys).addColumns([allTasks, doneTasks]).join([
      leftOuterJoin(todos, todos.category.equalsExp(categorys.name)),
    ])
      ..where(categorys.name.equals(name));
    query.groupBy([categorys.name]);
    return query.watch().map(
      (rows) {
        var row = rows[0];
        return CategoryWithCount(
          row.readTable(categorys),
          row.read(allTasks),
          row.read(doneTasks),
        );
      },
    );
  }

  Stream<List<CategoryWithCount>> getCategories() {
    final allTasks = todos.id.count();
    final doneTasks = todos.done.sum();
    var query = select(categorys).addColumns([allTasks, doneTasks]).join([
      leftOuterJoin(todos, todos.category.equalsExp(categorys.name)),
    ]);
    query.groupBy([categorys.name]);
    return query.watch().map(
          (rows) => rows
              .map(
                (row) => CategoryWithCount(
                  row.readTable(categorys),
                  row.read(allTasks),
                  row.read(doneTasks),
                ),
              )
              .toList(),
        );
  }
}
