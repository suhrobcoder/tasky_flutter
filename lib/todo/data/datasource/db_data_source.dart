import 'package:tasky/core/models/date_range.dart';
import 'package:tasky/todo/data/datasource/category_with_count.dart';
import 'package:tasky/todo/data/datasource/dao/category_dao.dart';
import 'package:tasky/todo/data/datasource/dao/todo_dao.dart';
import 'package:tasky/todo/data/datasource/todo_database.dart';

abstract class DbDataSource {
  Future<void> addCategory(CategorysCompanion category);

  Future<void> addTodo(TodosCompanion todo);

  Future<void> completeTodo(Todo todo);

  Future<void> deleteTodo(Todo todo);

  Stream<List<CategoryWithCount>> getCategories();

  Stream<List<Todo>> getTodosByCategoryAndForDate(
      Category? category, DateRange? dateRange);
}

class DbDataSourceImpl implements DbDataSource {
  final TodoDao todoDao;
  final CategoryDao categoryDao;

  DbDataSourceImpl(this.todoDao, this.categoryDao);

  @override
  Future<void> addCategory(CategorysCompanion category) {
    return categoryDao.insertCategory(category);
  }

  @override
  Future<void> addTodo(TodosCompanion todo) {
    return todoDao.insertTodo(todo);
  }

  @override
  Future<void> completeTodo(Todo todo) {
    return todoDao.completeTodo(todo);
  }

  @override
  Future<void> deleteTodo(Todo todo) {
    return todoDao.deleteTodo(todo);
  }

  @override
  Stream<List<CategoryWithCount>> getCategories() {
    return categoryDao.getCategories();
  }

  @override
  Stream<List<Todo>> getTodosByCategoryAndForDate(
      Category? category, DateRange? dateRange) {
    return todoDao.todosByCategoryAndDateRange(category, dateRange);
  }
}
