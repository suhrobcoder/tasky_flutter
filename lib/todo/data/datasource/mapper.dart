import 'package:tasky/todo/data/datasource/category_with_count.dart';
import 'package:tasky/todo/data/datasource/todo_database.dart';
import 'package:tasky/todo/domain/entity/category_entity.dart';
import 'package:tasky/todo/domain/entity/todo_entity.dart';

extension TodoEntityMapper on TodoEntity {
  TodosCompanion toDbInsertModel() {
    return TodosCompanion.insert(
        title: title,
        description: description,
        category: category,
        date: date,
        notification: notification,
        priorityHigh: priorityHigh);
  }

  Todo toDbModel() {
    return Todo(
        id: id,
        title: title,
        description: description,
        category: category,
        date: date,
        notification: notification,
        priorityHigh: priorityHigh,
        done: done ? 1 : 0);
  }

  static TodoEntity fromDbModel(Todo todo) {
    return TodoEntity(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        category: todo.category,
        date: todo.date,
        notification: todo.notification,
        priorityHigh: todo.priorityHigh,
        done: todo.done == 1);
  }
}

extension CategoryEntityMapper on CategoryEntity {
  CategorysCompanion toDbInsertModel() {
    return CategorysCompanion.insert(name: name, color: color);
  }

  Category toDbModel() {
    return Category(name: name, color: color);
  }

  static CategoryEntity fromDbModel(CategoryWithCount categoryWithCount) {
    return CategoryEntity(
        name: categoryWithCount.category.name,
        color: categoryWithCount.category.color,
        allTasks: categoryWithCount.allTasks,
        doneTasks: categoryWithCount.doneTasks ?? 0);
  }
}
