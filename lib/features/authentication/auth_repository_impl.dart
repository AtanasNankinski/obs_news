import 'package:firebase_auth/firebase_auth.dart';

import 'package:obs_news/features/authentication/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_impl.g.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth;

  AuthRepositoryImpl(this._auth);

  @override
  Future<User?> signUpWithEmailAndPassword(String email, String password, String username) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
            await _auth.currentUser!.updateDisplayName(username);
          });
      return credential.user;
    } catch(e) {
      throw FirebaseAuthException(code: e.toString());
    }
  }

  @override
  Future<User?> signInWithEmailAndPassword(String email, String password) {
    try {
      final credential = _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.then((value) => value.user);
    } catch(e) {
      throw FirebaseAuthException(code: e.toString());
    }
  }

  @override
  Stream<User?> getCurrentUser() {
    try {
      return _auth.authStateChanges();
    } catch(e) {
      throw FirebaseAuthException(code: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch(e) {
      throw FirebaseAuthException(code: e.toString());
    }
  }
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) => AuthRepositoryImpl(ref.read(firebaseAuthProvider));

@riverpod
FirebaseAuth firebaseAuth(FirebaseAuthRef ref) => FirebaseAuth.instance;