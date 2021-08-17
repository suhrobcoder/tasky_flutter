import 'package:tasky/core/models/date_range.dart';
import 'package:tasky/todo/domain/entity/category_entity.dart';
import 'package:tasky/todo/domain/entity/todo_entity.dart';
import 'package:tasky/todo/domain/repository/todo_repository.dart';

class GetTodosForToday {
  final TodoRepository repository;

  GetTodosForToday(this.repository);

  Stream<List<TodoEntity>> execute({CategoryEntity? category}) {
    return repository.getTodosByCategoryAndForDate(
      category: category,
      dateRange: DateRange.today(),
    );
  }
}
