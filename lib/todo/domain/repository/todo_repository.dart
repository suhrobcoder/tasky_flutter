import 'package:dartz/dartz.dart';
import 'package:tasky/core/error/failures.dart';
import 'package:tasky/core/models/date_range.dart';
import 'package:tasky/todo/domain/entity/category_entity.dart';
import 'package:tasky/todo/domain/entity/todo_entity.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
  Future<Either<Failure, List<TodoEntity>>> getTodosByCategoryAndForDate({
    CategoryEntity? category,
    DateRange? dateRange,
  });
  Future<Either<Failure, bool>> addTodo(TodoEntity todo);
  Future<Either<Failure, bool>> addCategory(CategoryEntity category);
  Future<Either<Failure, bool>> completeTodo(TodoEntity todo);
  Future<Either<Failure, bool>> deleteTodo(TodoEntity todo);
}
