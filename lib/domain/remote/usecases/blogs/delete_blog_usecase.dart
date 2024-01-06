import 'package:my_blog_app/core/class/resource.dart';
import 'package:my_blog_app/data/remote/repository/blog_repository.dart';
import 'package:my_blog_app/domain/remote/models/blogs/blog_model.dart';

class DeleteBlogUseCase {
  final BlogRepository _blogRepo;

  DeleteBlogUseCase(this._blogRepo);

  Future<Resource<BlogModel>> call(BlogModel blogModel) async {
    final res = await _blogRepo.deleteBlogData(blogModel);
    return res.transform<BlogModel>((p0) => BlogModel.fromEntity(p0));
  }
}
