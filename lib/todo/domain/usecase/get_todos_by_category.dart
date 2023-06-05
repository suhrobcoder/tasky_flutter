import 'package:injectable/injectable.dart';
import 'package:tasky/todo/domain/entity/category_entity.dart';
import 'package:tasky/todo/domain/entity/todo_entity.dart';
import 'package:tasky/todo/domain/repository/todo_repository.dart';

@injectable
class GetTodosByCategory {
  final TodoRepository repository;

  GetTodosByCategory(this.repository);

  Stream<List<TodoEntity>> execute(CategoryEntity? category) {
    return repository.getTodosByCategoryAndForDate(category: category);
  }
}
