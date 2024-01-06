import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_blog_app/core/class/resource.dart';
import 'package:my_blog_app/data/remote/entity/user_entity.dart';
import 'package:my_blog_app/data/remote/repository/user_repository.dart';
import 'package:my_blog_app/domain/remote/models/auth/login_form.dart';
import 'package:my_blog_app/domain/remote/models/auth/user_model.dart';

class LoginUserUseCase {
  final UserRepository _userRepo;

  LoginUserUseCase(this._userRepo);

  Future<Resource<UserModel>> call(LoginForm form) async {
    final res = await _userRepo.loginUserWithEmail(form.email, form.password);
    if (res is Success<UserCredential>) {
      final data = await _userRepo.getUserData(res.data.user!.uid);
      if (data is Success<DocumentSnapshot<UserEntity>>) {
        return Success(UserModel.fromUserEntity(data.data.data()!));
      } else {
        return Failure(res.error!);
      }
    } else {
      return Failure(res.error!);
    }
  }
}
