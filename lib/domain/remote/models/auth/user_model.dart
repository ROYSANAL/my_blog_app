import 'package:my_blog_app/data/remote/entity/user_entity.dart';

typedef Json = Map<String, dynamic>;

class UserModel extends UserEntity {
  UserModel(
      {required super.name,
      required super.email,
      required super.dateJoined,
      required super.blogsPosted,
      required super.uid});

  Json toJson() => {
        "name": name,
        "email": email,
        "uid": uid,
        "dateJoined": dateJoined.toIso8601String(),
        "blogsPosted": blogsPosted,
      };

  factory UserModel.fromJson(Json json) => UserModel(
        name: json["name"] as String,
        email: json["email"] as String,
        uid: json["uid"] as String,
        dateJoined: DateTime.parse(json["dateJoined"] as String),
        blogsPosted: (json["blogsPosted"] as num).toInt(),
      );

  factory UserModel.fromUserEntity(UserEntity entity) => UserModel(
        name: entity.name,
        email: entity.email,
        uid: entity.uid,
        dateJoined: entity.dateJoined,
        blogsPosted: entity.blogsPosted,
      );
}
