import 'package:dartz/dartz.dart';
import 'package:tasky/core/error/failures.dart';
import 'package:tasky/core/models/date_range.dart';
import 'package:tasky/todo/data/model/category_model.dart';
import 'package:tasky/todo/data/model/todo_model.dart';

abstract class DbDataSource {
  Future<Either<Failure, bool>> addCategory(CategoryModel category);
  Future<Either<Failure, bool>> addTodo(TodoModel todo);
  Future<Either<Failure, bool>> completeTodo(TodoModel todo);
  Future<Either<Failure, bool>> deleteTodo(TodoModel todo);
  Future<Either<Failure, List<CategoryModel>>> getCategories();
  Future<Either<Failure, List<TodoModel>>> getTodosByCategoryAndForDate(
      CategoryModel? category, DateRange? dateRange);
}
