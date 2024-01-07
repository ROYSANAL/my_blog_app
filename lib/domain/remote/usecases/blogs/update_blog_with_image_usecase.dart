import 'package:image_picker/image_picker.dart';
import 'package:my_blog_app/core/class/resource.dart';
import 'package:my_blog_app/domain/remote/repository/blog_repository_implementation.dart';

class UpdateBlogWithImageUseCase {
  final _blogRepo = BlogRepositoryImplementation();

  Future<Resource<Json>> call(Json data, XFile image, String id) async {
    final res = await _blogRepo.deleteImage(id);
    if (res is Success<String>) {
      final url = await _blogRepo.uploadImage(id, image);
      if (url is Success<String>) {
        data = {
          ...data,
          "imageUrl": url.data,
        };
        final res = await _blogRepo.updateBlogData(data, id);
        if (res is Success<Json>) {
          return Success(data);
        } else {
          return Failure(res.error.toString());
        }
      } else {
        return Failure(res.error.toString());
      }
    } else {
      return Failure(res.error.toString());
    }
  }
}
