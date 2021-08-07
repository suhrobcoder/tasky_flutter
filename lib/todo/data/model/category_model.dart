import 'package:tasky/todo/domain/entity/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel.fromEntity(CategoryEntity entity)
      : super(id: entity.id, name: entity.name, color: entity.color);

  CategoryModel.fromMap(Map<String, dynamic> map)
      : super(
          id: map["id"],
          name: map["name"],
          color: map["color"],
        );

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "color": color,
    };
  }
}
