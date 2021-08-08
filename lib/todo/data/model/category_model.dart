import 'package:tasky/todo/domain/entity/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel.fromEntity(CategoryEntity entity)
      : super(id: entity.id, name: entity.name, color: entity.color);

  CategoryModel.fromMap(Map<String, dynamic> map,
      {int? allTasks, int? doneTasks})
      : super(
          id: map["id"],
          name: map["name"],
          color: map["color"],
          allTasks: allTasks ?? 0,
          doneTasks: doneTasks ?? 0,
        );

  Map<String, dynamic> toMap({int? newId}) {
    return {
      "id": newId ?? id,
      "name": name,
      "color": color,
    };
  }
}
