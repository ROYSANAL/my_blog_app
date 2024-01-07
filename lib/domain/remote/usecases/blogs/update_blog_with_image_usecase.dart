import 'package:image_picker/image_picker.dart';
import 'package:my_blog_app/core/class/resource.dart';
import 'package:my_blog_app/domain/remote/repository/blog_repository_implementation.dart';

class UpdateBlogWithImageUseCase {
  final _blogRepo = BlogRepositoryImplementation();

  Future<Resource<Json>> call(Json data, XFile image, String id) async {
    final res = await _blogRepo.deleteImage(id);                                         // delete previous image
    if (res is Success<String>) {
      final url = await _blogRepo.uploadImage(id, image);                                   // upload the new image in storage
      if (url is Success<String>) {
        data = {
          ...data,
          "imageUrl": url.data,
        };                                                                                       // append the url in changed "data"
        final res = await _blogRepo.updateBlogData(data, id);                                      // update the document in db
        if (res is Success<Json>) {
          return Success(data);                                                                  // return "data" if updated successfully
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
