import 'package:tasky/todo/data/datasource/todo_database.dart';

class CategoryWithCount {
  final Category category;
  final int allTasks;
  final int? doneTasks;

  CategoryWithCount(this.category, this.allTasks, this.doneTasks);
}
