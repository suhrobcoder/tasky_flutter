import 'package:tasky/todo/domain/entity/category_entity.dart';
import 'package:tasky/todo/domain/repository/todo_repository.dart';

class AddCategory {
  final TodoRepository repository;

  AddCategory(this.repository);

  Future<void> execute(CategoryEntity category) {
    return repository.addCategory(category);
  }
}
