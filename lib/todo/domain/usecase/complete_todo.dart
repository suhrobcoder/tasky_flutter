import 'package:dartz/dartz.dart';
import 'package:tasky/core/error/failures.dart';
import 'package:tasky/todo/domain/entity/todo_entity.dart';
import 'package:tasky/todo/domain/repository/todo_repository.dart';

class CompleteTodo {
  final TodoRepository repository;

  CompleteTodo(this.repository);

  Future<Either<Failure, bool>> execute(TodoEntity todo) {
    return repository.completeTodo(todo);
  }
}
