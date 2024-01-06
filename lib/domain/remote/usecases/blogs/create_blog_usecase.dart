import 'package:my_blog_app/core/class/resource.dart';
import 'package:my_blog_app/data/remote/repository/blog_repository.dart';
import 'package:my_blog_app/domain/remote/models/blogs/blog_model.dart';
import 'package:my_blog_app/domain/remote/models/blogs/create_blog_form.dart';

class CreateBlogUseCase {
  final BlogRepository _blogRepo;

  CreateBlogUseCase(this._blogRepo);

  Future<Resource<BlogModel>> call(CreateBlogForm form, String id) async {
    final url = await _blogRepo.uploadImage(id, form.image!);
    if (url is Success<String>) {
      final blogModel = BlogModel(
          id: id,
          title: form.title,
          body: form.body,
          authorId: form.authorId,
          authorName: form.authorName,
          imageUrl: url.data,
          publishDate: DateTime.now());
      final res = await _blogRepo.addBlogData(blogModel);
      return res.transform<BlogModel>(
        (p0) => BlogModel.fromEntity(p0),
      );
    } else {
      return Failure(url.error!);
    }
  }
}
