import 'package:injectable/injectable.dart';
import 'package:tasky/todo/domain/entity/category_entity.dart';
import 'package:tasky/todo/domain/repository/todo_repository.dart';

@injectable
class AddCategory {
  final TodoRepository repository;

  AddCategory(this.repository);

  Future<void> execute(CategoryEntity category) {
    return repository.addCategory(category);
  }
}
