import 'package:my_blog_app/core/class/resource.dart';
import 'package:my_blog_app/domain/remote/repository/blog_repository_implementation.dart';

typedef Json = Map<String, dynamic>;

class UpdateBlogUseCase {
  final _blogRepo = BlogRepositoryImplementation();

  Future<Resource<Json>> call(Json data, String blogId) =>
      _blogRepo.updateBlogData(data, blogId);                                                      // update "data" in the document in db
}
