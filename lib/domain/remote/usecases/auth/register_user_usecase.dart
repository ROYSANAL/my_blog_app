import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_blog_app/core/class/resource.dart';
import 'package:my_blog_app/domain/remote/models/auth/sign_up_form.dart';
import 'package:my_blog_app/data/remote/entity/user_entity.dart';
import 'package:my_blog_app/data/remote/repository/user_repository.dart';
import 'package:my_blog_app/domain/remote/models/auth/user_model.dart';

class RegisterUserUseCase {
  final UserRepository _userRepo;

  RegisterUserUseCase(this._userRepo);

  Future<Resource<UserModel>> call(SignUpForm form) async {
    final res = await _userRepo.createUserWithEmail(form.email, form.password);
    if (res is Success<UserCredential>) {
      final user = res.data.user!;
      final data = await _userRepo.addUserData(UserEntity(
        name: form.name,
        email: form.email,
        uid: user.uid,
        dateJoined: DateTime.now(),
        blogsPosted: 0,
      ));

      if (data is Success<UserEntity>) {
        return Success(UserModel.fromUserEntity(data.data));
      } else {
        return Failure(data.error!);
      }
    } else {
      return Failure(res.error!);
    }
  }
}
