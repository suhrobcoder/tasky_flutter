import 'package:dartz/dartz.dart';
import 'package:tasky/core/error/failures.dart';
import 'package:tasky/todo/domain/entity/category_entity.dart';
import 'package:tasky/todo/domain/repository/todo_repository.dart';

class AddCategory {
  final TodoRepository repository;

  AddCategory(this.repository);

  Future<Either<Failure, bool>> execute(CategoryEntity category) {
    return repository.addCategory(category);
  }
}
