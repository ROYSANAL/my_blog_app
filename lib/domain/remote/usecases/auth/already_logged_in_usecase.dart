import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_blog_app/core/class/resource.dart';
import 'package:my_blog_app/data/remote/entity/user_entity.dart';
import 'package:my_blog_app/data/remote/repository/user_repository.dart';
import 'package:my_blog_app/domain/remote/models/auth/user_model.dart';

class AlreadyLoggedInUseCase {
  final UserRepository _userRepo;

  AlreadyLoggedInUseCase(this._userRepo);

   Future<Resource<UserModel>> call(String uid) async{
    final data = await _userRepo.getUserData(uid);                                         // get data from firestore
    if (data is Success<DocumentSnapshot<UserEntity>>) {
      return Success(UserModel.fromUserEntity(data.data.data()!));                                 // return user data
    } else {
      return Failure(data.error!);
    }
  }
}
