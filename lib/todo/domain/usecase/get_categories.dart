import 'package:dartz/dartz.dart';
import 'package:tasky/core/error/failures.dart';
import 'package:tasky/todo/domain/entity/category_entity.dart';
import 'package:tasky/todo/domain/repository/todo_repository.dart';

class GetCategories {
  final TodoRepository repository;

  GetCategories(this.repository);

  Future<Either<Failure, List<CategoryEntity>>> execute() {
    return repository.getCategories();
  }
}
