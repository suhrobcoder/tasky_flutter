import 'package:tasky/todo/domain/entity/category_entity.dart';
import 'package:tasky/todo/domain/repository/todo_repository.dart';

class GetCategory {
  final TodoRepository repository;

  GetCategory(this.repository);

  Stream<CategoryEntity> execute(String name) {
    return repository.getCategory(name);
  }
}
