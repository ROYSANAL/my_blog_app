import 'package:my_blog_app/data/remote/entity/blog_entity.dart';

typedef Json = Map<String, dynamic>;

class BlogModel extends BlogEntity {
  BlogModel(
      {required super.id,
      required super.title,
      required super.body,
      required super.authorId,
      required super.authorName,
      required super.imageUrl,
      required super.publishDate});

  factory BlogModel.fromJson(Json json) => BlogModel(
        id: json["id"] as String,
        title: json["title"] as String,
        body: json["body"] as String,
        authorId: json["authorId"] as String,
        authorName: json["authorName"] as String,
        imageUrl: json["imageUrl"] as String,
        publishDate: DateTime.parse(json["publishDate"] as String),
      );

  Json toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "authorId": authorId,
        "authorName": authorName,
        "imageUrl": imageUrl,
        "publishDate": publishDate.toIso8601String(),
      };

  factory BlogModel.fromEntity(BlogEntity entity) => BlogModel(
        id: entity.id,
        title: entity.title,
        body: entity.body,
        authorId: entity.authorId,
        authorName: entity.authorName,
        imageUrl: entity.imageUrl,
        publishDate: entity.publishDate,
      );
}
