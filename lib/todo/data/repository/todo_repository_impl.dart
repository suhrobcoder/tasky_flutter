import 'package:tasky/todo/data/datasource/db_data_source.dart';
import 'package:tasky/todo/data/model/category_model.dart';
import 'package:tasky/todo/data/model/todo_model.dart';
import 'package:tasky/todo/domain/entity/todo_entity.dart';
import 'package:tasky/todo/domain/entity/category_entity.dart';
import 'package:tasky/core/models/date_range.dart';
import 'package:tasky/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tasky/todo/domain/repository/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final DbDataSource dataSource;

  TodoRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, bool>> addCategory(CategoryEntity category) {
    return dataSource.addCategory(CategoryModel.fromEntity(category));
  }

  @override
  Future<Either<Failure, bool>> addTodo(TodoEntity todo) {
    return dataSource.addTodo(TodoModel.fromEntity(todo));
  }

  @override
  Future<Either<Failure, bool>> completeTodo(TodoEntity todo) {
    return dataSource.completeTodo(TodoModel.fromEntity(todo));
  }

  @override
  Future<Either<Failure, bool>> deleteTodo(TodoEntity todo) {
    return dataSource.deleteTodo(TodoModel.fromEntity(todo));
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() {
    return dataSource.getCategories();
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> getTodosByCategoryAndForDate({
    CategoryEntity? category,
    DateRange? dateRange,
  }) {
    return dataSource.getTodosByCategoryAndForDate(
      category != null ? CategoryModel.fromEntity(category) : null,
      dateRange,
    );
  }
}
