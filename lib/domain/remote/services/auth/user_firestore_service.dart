import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_blog_app/core/class/resource.dart';
import 'package:my_blog_app/core/interface/base_firestore_service.dart';
import 'package:my_blog_app/domain/remote/models/auth/user_model.dart';

typedef Json = Map<String, dynamic>;

class UserFireStoreService implements BaseFireStoreService<UserModel> {
  final _userCollection =
      FirebaseFirestore.instance.collection("users").withConverter<UserModel>(
            fromFirestore: (snapshot, options) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson(),
          );

  @override
  Future<Resource<UserModel>> deleteObject(UserModel data) async {
    try {
      await _userCollection.doc(data.uid).delete();
      return Success(data);
    } on FirebaseException catch (e) {
      return Failure(e.message.toString());
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Resource<Stream<QuerySnapshot<UserModel>>> getAllObjects(params) {
    try {
      final res =  _userCollection.snapshots();
      return Success(res);
    } on FirebaseException catch (e) {
      return Failure(e.message.toString());
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Future<Resource<DocumentSnapshot<UserModel>>> getObject(String id) async {
    try {
      final res = await _userCollection.doc(id).get();
      return Success(res);
    } on FirebaseException catch (e) {
      return Failure(e.message.toString());
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Future<Resource<UserModel>> insertObject(UserModel data) async {
    try {
      await _userCollection.doc(data.uid).set(data);
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
      await _userCollection.doc(id).update(data);
      return Success(data);
    } on FirebaseException catch (e) {
      return Failure(e.message.toString());
    } catch (e) {
      return Failure(e.toString());
    }
  }
}
