import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasky/core/error/failures.dart';
import 'package:tasky/core/models/date_range.dart';
import 'package:tasky/todo/data/datasource/db_factory.dart';
import 'package:tasky/todo/data/model/category_model.dart';
import 'package:tasky/todo/data/model/todo_model.dart';

abstract class DbDataSource {
  Future<Either<Failure, bool>> addCategory(CategoryModel category);
  Future<Either<Failure, bool>> addTodo(TodoModel todo);
  Future<Either<Failure, bool>> completeTodo(TodoModel todo);
  Future<Either<Failure, bool>> deleteTodo(TodoModel todo);
  Future<Either<Failure, List<CategoryModel>>> getCategories();
  Future<Either<Failure, List<TodoModel>>> getTodosByCategoryAndForDate(
      CategoryModel? category, DateRange? dateRange);
}

class DbDataSourceImpl implements DbDataSource {
  final Database database;

  DbDataSourceImpl(this.database);

  @override
  Future<Either<Failure, bool>> addCategory(CategoryModel category) async {
    try {
      var res = await database.insert(
        categoryTableName,
        category.toMap(newId: generateRandomId()),
      );
      if (res <= 0) {
        throw Exception();
      }
      return const Right(true);
    } catch (e) {
      return Left(DatabaseFailure("New category adding error"));
    }
  }

  @override
  Future<Either<Failure, bool>> addTodo(TodoModel todo) async {
    try {
      var res = await database.insert(
        categoryTableName,
        todo.toMap(newId: generateRandomId()),
      );
      if (res <= 0) {
        throw Exception();
      }
      return const Right(true);
    } catch (e) {
      return Left(DatabaseFailure("New task adding error"));
    }
  }

  @override
  Future<Either<Failure, bool>> completeTodo(TodoModel todo) async {
    try {
      await database
          .query("UPDATE $tasksTableName SET done=1 WHERE id=${todo.id}");
      return const Right(true);
    } catch (e) {
      return Left(DatabaseFailure("Completing task error"));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteTodo(TodoModel todo) async {
    try {
      var res = await database
          .delete(tasksTableName, where: "id=?", whereArgs: [todo.id]);
      if (res <= 0) {
        throw Exception();
      }
      return const Right(true);
    } catch (e) {
      return Left(DatabaseFailure("Deleting error"));
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      var categories =
          await database.query("SELECT COUNT() FROM $categoryTableName");
      var allTasks = await database.query(
          "SELECT COUNT(task.category_id) all_tasks, category.id FROM category LEFT JOIN task ON category.id = task.category_id GROUP BY category.id");
      var doneTasks = await database.query(
          "SELECT COUNT(task.category_id) done_tasks, category.id doneTasks FROM category LEFT JOIN task ON category.id = task.category_id WHERE task.done = 1 GROUP BY category.id");
      return Right(categories.map((e) {
        int? allTask = allTasks.firstWhere(
          (el) => el["id"] == e["id"],
          orElse: () => {"all_tasks": 0},
        )["all_tasks"] as int?;
        int? doneTask = doneTasks.firstWhere((el) => el["id"] == e["id"],
            orElse: () => {"done_tasks": 0})["done_tasks"] as int?;
        return CategoryModel.fromMap(e, allTasks: allTask, doneTasks: doneTask);
      }).toList());
    } catch (error) {
      return Left(DatabaseFailure(defaultErrorMsg));
    }
  }

  @override
  Future<Either<Failure, List<TodoModel>>> getTodosByCategoryAndForDate(
    CategoryModel? category,
    DateRange? dateRange,
  ) async {
    try {
      var where = category?.name ?? "";
      if (category != null && dateRange != null) {
        where += " AND ";
      }
      where += dateRange != null
          ? "date > ${dateRange.getStartTimeInMillis()} AND date < ${dateRange.getEndTimeInMillis()}"
          : "";
      var whereArgs = [];
      if (category != null) {
        whereArgs.add(category.id);
      }
      if (dateRange != null) {
        whereArgs += [
          dateRange.getStartTimeInMillis(),
          dateRange.getEndTimeInMillis(),
        ];
      }
      var res = await database.query(
        "SELECT * FROM $tasksTableName ORDER BY date DESC",
        where: where,
        whereArgs: whereArgs,
      );
      return Right(res.map((e) => TodoModel.fromMap(e)).toList());
    } catch (error) {
      return Left(DatabaseFailure(defaultErrorMsg));
    }
  }

  int generateRandomId() {
    return Random().nextInt(1 << 31);
  }
}
