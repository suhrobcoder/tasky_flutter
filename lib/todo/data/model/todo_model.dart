import 'package:tasky/todo/domain/entity/todo_entity.dart';

class TodoModel extends TodoEntity {
  TodoModel.fromEntity(TodoEntity entity)
      : super(
          id: entity.id,
          title: entity.title,
          description: entity.description,
          categoryId: entity.categoryId,
          date: entity.date,
          notification: entity.notification,
          priorityHigh: entity.priorityHigh,
          done: entity.done,
        );

  TodoModel.fromMap(Map<String, dynamic> map)
      : super(
            id: map["id"],
            title: map["title"],
            description: map["description"],
            categoryId: map["category_id"],
            date: map["date"],
            notification: map["notification"] == 1,
            priorityHigh: map["priority_high"] == 1,
            done: map["done"] == 1);

  Map<String, dynamic> toMap({int? newId}) {
    return {
      "id": newId ?? id,
      "title": title,
      "description": description,
      "category_id": categoryId,
      "date": date,
      "notification": notification ? 1 : 0,
      "priority_high": priorityHigh ? 1 : 0,
      "done": done ? 1 : 0,
    };
  }
}
