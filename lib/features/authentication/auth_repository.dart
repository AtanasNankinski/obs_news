import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User?> signUpWithEmailAndPassword(String email, String password, String name);

  Future<User?> signInWithEmailAndPassword(String email, String password);

  Future<void> signOut();

  Stream<User?> getCurrentUser();

}