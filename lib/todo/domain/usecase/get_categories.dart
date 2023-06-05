import 'package:injectable/injectable.dart';
import 'package:tasky/todo/domain/entity/category_entity.dart';
import 'package:tasky/todo/domain/repository/todo_repository.dart';

@injectable
class GetCategories {
  final TodoRepository repository;

  GetCategories(this.repository);

  Stream<List<CategoryEntity>> execute() {
    return repository.getCategories();
  }
}
