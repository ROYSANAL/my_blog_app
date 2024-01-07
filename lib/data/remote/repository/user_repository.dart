import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_blog_app/data/remote/entity/user_entity.dart';

import '../../../core/class/resource.dart';

typedef Json = Map<String, dynamic>;

abstract class UserRepository {
  Future<Resource<UserEntity>> addUserData(UserEntity userEntity);

  Future<Resource<Json>> updateUserData(Json data, String userId);

  Future<Resource<UserEntity>> deleteUserData(UserEntity userEntity);

  Future<Resource<DocumentSnapshot<UserEntity>>> getUserData(String uid);

  Future<Resource<UserCredential>> loginUserWithEmail(
      String email, String password);

  Future<Resource<UserCredential>> createUserWithEmail(
      String email, String password);

  Resource<Stream<DocumentSnapshot<UserEntity>>> getUserStream(String uid);
}
