import 'package:tasky/todo/domain/entity/todo_entity.dart';
import 'package:tasky/todo/domain/repository/todo_repository.dart';

class CompleteTodo {
  final TodoRepository repository;

  CompleteTodo(this.repository);

  Future<void> execute(TodoEntity todo) {
    return repository.completeTodo(todo);
  }
}
