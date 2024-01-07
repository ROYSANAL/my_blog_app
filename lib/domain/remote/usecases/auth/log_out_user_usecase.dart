import 'package:my_blog_app/core/class/resource.dart';
import 'package:my_blog_app/data/remote/repository/user_repository.dart';

class LogOutUserUseCase {
  final UserRepository _repo;

  LogOutUserUseCase(this._repo);

  Future<Resource<String>> call() => _repo.logoutUser();                            // log out the user
}
