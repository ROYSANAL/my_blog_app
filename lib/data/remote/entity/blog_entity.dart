class BlogEntity {
  final String id;
  final String title;
  final String body;
  final String authorId;
  final String authorName;
  final String imageUrl;
  final DateTime publishDate;

  BlogEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.authorId,
    required this.authorName,
    required this.imageUrl,
    required this.publishDate,
  });
}
