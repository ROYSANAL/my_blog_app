import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_blog_app/core/class/resource.dart';
import 'package:my_blog_app/data/remote/entity/blog_entity.dart';
import 'package:my_blog_app/data/remote/repository/blog_repository.dart';

class GetAllUserBlogsUseCase {
  final BlogRepository _blogRepo;

  GetAllUserBlogsUseCase(this._blogRepo);

  Resource<Stream<QuerySnapshot<BlogEntity>>> call(String uid) => _blogRepo.getAllBlogsByUser(uid);   // get realtime  (stream) of documents from db
}
