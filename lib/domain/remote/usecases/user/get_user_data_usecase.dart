import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_blog_app/core/class/resource.dart';
import 'package:my_blog_app/data/remote/entity/user_entity.dart';
import 'package:my_blog_app/data/remote/repository/user_repository.dart';

class GetUserDataUseCase {
  final UserRepository _repo;

  GetUserDataUseCase(this._repo);

  Resource<Stream<DocumentSnapshot<UserEntity>>> call(String uid) =>
      _repo.getUserStream(uid);                                                           // get real time user data
}
