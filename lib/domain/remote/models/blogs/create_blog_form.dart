import 'package:image_picker/image_picker.dart';

class CreateBlogForm {
  final String title;
  final String body;
  final XFile? image;
  final String authorId;
  final String authorName;

  CreateBlogForm(
      {required this.title,
      required this.body,
      required this.image,
      required this.authorId,
      required this.authorName});
}
