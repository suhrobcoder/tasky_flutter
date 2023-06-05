import 'package:injectable/injectable.dart';
import 'package:tasky/todo/domain/entity/todo_entity.dart';
import 'package:tasky/todo/domain/repository/todo_repository.dart';

@injectable
class AddTodo {
  final TodoRepository repository;

  AddTodo(this.repository);

  Future<void> execute(TodoEntity todo) {
    return repository.addTodo(todo);
  }
}
