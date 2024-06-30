import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User?> signUpWithEmailAndPassword(String email, String password);

  Future<User?> signInWithEmailAndPassword(String email, String password);

  Future<void> updateUsername(User user, String username);

  Future<void> signOut();

  Future<void> googleSignIn();

  Future<void> facebookSignIn();

  Stream<User?> getCurrentUser();

}