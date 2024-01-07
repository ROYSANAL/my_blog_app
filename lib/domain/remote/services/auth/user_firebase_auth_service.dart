import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_blog_app/core/class/resource.dart';
import 'package:my_blog_app/core/interface/base_firebase_auth_service.dart';

class UserFireBaseAuthService implements BaseFireBaseAuthService {
  final _mAuth = FirebaseAuth.instance;

  @override
  Future<Resource<UserCredential>> loginUsingEmailAndPassword(
      String email, String password) async {
    try {
      final res = await _mAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return Success(res);
    } on FirebaseAuthException catch (e) {
      return Failure(e.message.toString());
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Future<Resource<UserCredential>> registerUsingEmailAndPassword(
      String email, String password) async {
    try {
      final res = await _mAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return Success(res);
    } on FirebaseAuthException catch (e) {
      return Failure(e.message.toString());
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Future<Resource<String>> logOutUser() async {
    try {
      await _mAuth.signOut();
      return Success("logout");
    } on FirebaseAuthException catch (e) {
      return Failure(e.message.toString());
    } catch (e) {
      return Failure(e.toString());
    }
  }
}
