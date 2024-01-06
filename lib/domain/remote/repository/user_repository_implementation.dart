import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_blog_app/core/class/resource.dart';
import 'package:my_blog_app/data/remote/entity/user_entity.dart';
import 'package:my_blog_app/data/remote/repository/user_repository.dart';
import 'package:my_blog_app/domain/remote/models/auth/user_model.dart';
import 'package:my_blog_app/domain/remote/services/auth/user_firebase_auth_service.dart';
import 'package:my_blog_app/domain/remote/services/auth/user_firestore_service.dart';

typedef Json = Map<String, dynamic>;

class UserRepositoryImplementation implements UserRepository {
  final _ffs = UserFireStoreService();
  final _auth = UserFireBaseAuthService();

  @override
  Future<Resource<UserModel>> addUserData(UserEntity userEntity) =>
      _ffs.insertObject(UserModel.fromUserEntity(userEntity));

  @override
  Future<Resource<UserModel>> deleteUserData(UserEntity userEntity) =>
      _ffs.deleteObject(UserModel.fromUserEntity(userEntity));

  @override
  Future<Resource<Json>> updateUserData(Json data, String userId) =>
      _ffs.updateObject(data, userId);

  @override
  Future<Resource<UserCredential>> createUserWithEmail(
          String email, String password) =>
      _auth.registerUsingEmailAndPassword(email, password);

  @override
  Future<Resource<UserCredential>> loginUserWithEmail(
          String email, String password) =>
      _auth.loginUsingEmailAndPassword(email, password);

  @override
  Future<Resource<DocumentSnapshot<UserEntity>>> getUserData(String uid) => _ffs.getObject(uid);


}
