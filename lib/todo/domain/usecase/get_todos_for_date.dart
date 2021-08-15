import 'package:tasky/core/models/date_range.dart';
import 'package:tasky/todo/domain/entity/category_entity.dart';
import 'package:tasky/todo/domain/entity/todo_entity.dart';
import 'package:tasky/todo/domain/repository/todo_repository.dart';

class GetTodosForDate {
  final TodoRepository repository;

  GetTodosForDate(this.repository);

  Stream<List<TodoEntity>> execute({
    required CategoryEntity category,
    DateTime? date,
  }) {
    var startDate = date ?? DateTime.fromMillisecondsSinceEpoch(0);
    var endDate = date?.add(const Duration(days: 1)) ?? DateTime.now();
    return repository.getTodosByCategoryAndForDate(
      category: category,
      dateRange: DateRange(startDate, endDate),
    );
  }
}
