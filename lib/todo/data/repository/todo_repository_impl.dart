import 'package:tasky/core/models/date_range.dart';
import 'package:tasky/todo/data/datasource/db_data_source.dart';
import 'package:tasky/todo/data/datasource/mapper.dart';
import 'package:tasky/todo/domain/entity/category_entity.dart';
import 'package:tasky/todo/domain/entity/todo_entity.dart';
import 'package:tasky/todo/domain/repository/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final DbDataSource dataSource;

  TodoRepositoryImpl(this.dataSource);

  @override
  Future<void> addCategory(CategoryEntity category) {
    return dataSource.addCategory(category.toDbInsertModel());
  }

  @override
  Future<void> addTodo(TodoEntity todo) {
    return dataSource.addTodo(todo.toDbInsertModel());
  }

  @override
  Future<void> completeTodo(TodoEntity todo) {
    return dataSource.completeTodo(todo.toDbModel());
  }

  @override
  Future<void> deleteTodo(TodoEntity todo) {
    return dataSource.deleteTodo(todo.toDbModel());
  }

  @override
  Stream<List<CategoryEntity>> getCategories() {
    return dataSource.getCategories().map((event) => event
        .map(
          (e) => CategoryEntityMapper.fromDbModel(e),
        )
        .toList());
  }

  @override
  Stream<List<TodoEntity>> getTodosByCategoryAndForDate(
      {CategoryEntity? category, DateRange? dateRange}) {
    return dataSource
        .getTodosByCategoryAndForDate(
          category?.toDbModel(),
          dateRange,
        )
        .map(
          (event) => event
              .map(
                (e) => TodoEntityMapper.fromDbModel(e),
              )
              .toList(),
        );
  }

  @override
  Stream<CategoryEntity> getCategory(String name) {
    return dataSource.getCategory(name).map((event) => CategoryEntityMapper.fromDbModel(event));
  }
}
