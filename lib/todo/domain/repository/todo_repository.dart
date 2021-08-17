import 'package:tasky/core/models/date_range.dart';
import 'package:tasky/todo/domain/entity/category_entity.dart';
import 'package:tasky/todo/domain/entity/todo_entity.dart';

abstract class TodoRepository {
  Stream<CategoryEntity> getCategory(String name);
  Stream<List<CategoryEntity>> getCategories();
  Stream<List<TodoEntity>> getTodosByCategoryAndForDate({
    CategoryEntity? category,
    DateRange? dateRange,
  });
  Future<void> addTodo(TodoEntity todo);
  Future<void> addCategory(CategoryEntity category);
  Future<void> completeTodo(TodoEntity todo);
  Future<void> deleteTodo(TodoEntity todo);
}
