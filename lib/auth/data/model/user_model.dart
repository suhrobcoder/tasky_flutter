import 'package:tasky/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
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
