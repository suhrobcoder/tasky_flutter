import 'package:injectable/injectable.dart';
import 'package:tasky/todo/domain/entity/todo_entity.dart';
import 'package:tasky/todo/domain/repository/todo_repository.dart';

@injectable
class DeleteTodo {
  final TodoRepository repository;

  DeleteTodo(this.repository);

  Future<void> execute(TodoEntity todo) {
    return repository.deleteTodo(todo);
  }
}
