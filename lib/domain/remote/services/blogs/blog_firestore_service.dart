import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_blog_app/core/class/resource.dart';
import 'package:my_blog_app/core/interface/base_firestore_service.dart';
import 'package:my_blog_app/domain/remote/models/auth/user_model.dart';
import 'package:my_blog_app/domain/remote/models/blogs/blog_model.dart';

typedef Json = Map<String, dynamic>;

class BlogFireStoreService implements BaseFireStoreService<BlogModel> {
  final _blogCollection =
      FirebaseFirestore.instance.collection("blogs").withConverter<BlogModel>(
            fromFirestore: (snapshot, options) =>
                BlogModel.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson(),
          );

  final _userCollection =
      FirebaseFirestore.instance.collection("users").withConverter<UserModel>(
            fromFirestore: (snapshot, options) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson(),
          );

  @override
  Future<Resource<BlogModel>> deleteObject(BlogModel data) async {
    try {
      final batch = FirebaseFirestore.instance.batch();
      batch.delete(_blogCollection.doc(data.id));
      batch.update(_userCollection.doc(data.authorId),
          {"blogsPublished": FieldValue.increment(-1)});
      batch.commit();
      return Success(data);
    } on FirebaseException catch (e) {
      return Failure(e.message.toString());
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Resource<Stream<QuerySnapshot<BlogModel>>> getAllObjects(Object uid) {
    try {
      final res = _blogCollection.where("authorId", isEqualTo: uid).snapshots();
      return Success(res);
    } on FirebaseException catch (e) {
      return Failure(e.message.toString());
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Future<Resource<DocumentSnapshot<BlogModel>>> getObject(String id) async {
    try {
      final res = await _blogCollection.doc(id).get();
      return Success(res);
    } on FirebaseException catch (e) {
      return Failure(e.message.toString());
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Future<Resource<BlogModel>> insertObject(BlogModel data) async {
    try {
      final batch = FirebaseFirestore.instance.batch();
      batch.set(_blogCollection.doc(data.id), data);
      batch.update(_userCollection.doc(data.authorId),
          {"blogsPosted": FieldValue.increment(1)});
      await batch.commit();
      return Success(data);
    } on FirebaseException catch (e) {
      return Failure(e.message.toString());
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Future<Resource<Json>> updateObject(Json data, String id) async {
    try {
      await _blogCollection.doc(id).update(data);
      return Success(data);
    } on FirebaseException catch (e) {
      return Failure(e.message.toString());
    } catch (e) {
      return Failure(e.toString());
    }
  }
}
