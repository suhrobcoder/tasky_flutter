import 'package:tasky/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String name,
    required String email,
    required String avatarUrl,
  }) : super(id, name, email, avatarUrl);

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      avatarUrl: json["avatarUrl"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "avatarUrl": avatarUrl,
    };
  }
}
