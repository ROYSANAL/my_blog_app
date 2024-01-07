import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_blog_app/core/class/resource.dart';
import 'package:my_blog_app/data/remote/entity/blog_entity.dart';
import 'package:my_blog_app/data/remote/repository/blog_repository.dart';
import 'package:my_blog_app/domain/remote/models/blogs/blog_model.dart';
import 'package:my_blog_app/domain/remote/services/blogs/blog_firestore_service.dart';
import 'package:my_blog_app/domain/remote/services/blogs/blog_storage_service.dart';

typedef Json = Map<String, dynamic>;

class BlogRepositoryImplementation implements BlogRepository {
  final _fb = BlogFireStoreService();
  final _storage = BlogStorageService();

  @override
  Future<Resource<BlogModel>> addBlogData(BlogEntity blogEntity) =>
      _fb.insertObject(BlogModel.fromEntity(blogEntity));

  @override
  Future<Resource<BlogModel>> deleteBlogData(BlogEntity blogEntity) =>
      _fb.deleteObject(BlogModel.fromEntity(blogEntity));

  @override
  Resource<Stream<QuerySnapshot<BlogModel>>> getAllBlogsByUser(String userId) =>
      _fb.getAllObjects(userId);

  @override
  Future<Resource<Json>> updateBlogData(Json data, String blogId) =>
      _fb.updateObject(data, blogId);

  @override
  Future<Resource<DocumentSnapshot<BlogModel>>> getBlog(String blogId) =>
      _fb.getObject(blogId);

  @override
  Future<Resource<String>> uploadImage(String id, XFile image) =>
      _storage.uploadImage(id, image);

  @override
  Future<Resource<String>> deleteImage(String id) => _storage.deleteImage(id);
}
