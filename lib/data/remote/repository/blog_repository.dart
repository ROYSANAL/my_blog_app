import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_blog_app/core/class/resource.dart';
import 'package:my_blog_app/core/interface/base_firestore_service.dart';
import 'package:my_blog_app/data/remote/entity/blog_entity.dart';

abstract class BlogRepository {
  Future<Resource<BlogEntity>> addBlogData(BlogEntity blogEntity);

  Future<Resource<Json>> updateBlogData(Json data, String blogId);

  Future<Resource<BlogEntity>> deleteBlogData(BlogEntity blogEntity);

  Resource<Stream<QuerySnapshot<BlogEntity>>> getAllBlogsByUser(String userId);

  Future<Resource<DocumentSnapshot<BlogEntity>>> getBlog(String blogId);

  Future<Resource<String>> uploadImage(String id , XFile image);

  Future<Resource<String>> deleteImage(String id );
}
