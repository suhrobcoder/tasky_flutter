import 'package:dartz/dartz.dart';
import 'package:tasky/core/error/failures.dart';
import 'package:tasky/core/extensions/datetime_ext.dart';
import 'package:tasky/core/models/date_range.dart';
import 'package:tasky/todo/domain/entity/category_entity.dart';
import 'package:tasky/todo/domain/entity/todo_entity.dart';
import 'package:tasky/todo/domain/repository/todo_repository.dart';

class GetTodosForWeek {
  final TodoRepository repository;

  GetTodosForWeek(this.repository);

  Future<Either<Failure, List<TodoEntity>>> execute({
    CategoryEntity? category,
  }) {
    return repository.getTodosByCategoryAndForDate(
      category: category,
      dateRange: _getWeekRange(),
    );
  }

  DateRange _getWeekRange() {
    var startOfWeek = DateTime.now().getStartOfWeek();
    return DateRange(startOfWeek, startOfWeek.add(const Duration(days: 7)));
  }
}
