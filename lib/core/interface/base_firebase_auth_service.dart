import 'package:firebase_auth/firebase_auth.dart';

import '../class/resource.dart';

abstract class BaseFireBaseAuthService {
  Future<Resource<UserCredential>> loginUsingEmailAndPassword(
      String email, String password);

  Future<Resource<UserCredential>> registerUsingEmailAndPassword(
      String email, String password);
}
