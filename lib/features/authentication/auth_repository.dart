import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User?> signUpWithEmailAndPassword(String email, String password);

  Future<User?> signInWithEmailAndPassword(String email, String password);

  Future<User> updateUsername(User user, String username);

  Future<void> signOut();

  Future<void> googleSignIn();

  Stream<User?> getCurrentUser();

}