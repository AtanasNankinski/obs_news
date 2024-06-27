import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:obs_news/features/authentication/auth_repository.dart';
import 'package:obs_news/shared/exceptions/exceptions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_impl.g.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepositoryImpl(this._auth, this._googleSignIn);

  @override
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final credentials = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await Future.delayed(const Duration(seconds: 1));
      return credentials.user;
    } catch(e) {
      throw AuthException(e.toString()).message!;
    }
  }

  @override
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch(e) {
      throw AuthException(e.toString()).message!;
    }
  }

  @override
  Future<User> updateUsername(User user, String username) async {
    await _auth.currentUser!.updateDisplayName(username);
    return user;
  }

  @override
  Stream<User?> getCurrentUser() {
    try {
      return _auth.authStateChanges();
    } catch(e) {
      throw AuthException(e.toString()).message!;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch(e) {
      throw AuthException(e.toString()).message!;
    }
  }

  @override
  Future<void> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if(googleUser == null) throw GoogleAuthException().message!;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
    } catch(e) {
      throw GoogleAuthException().message!;
    }
  }
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) => AuthRepositoryImpl(ref.read(firebaseAuthProvider), ref.read(googleSignInProvider));

@riverpod
Stream<User?> user(UserRef ref) {
  final firebaseAuth = ref.watch(authRepositoryProvider);
  return firebaseAuth.getCurrentUser();
}

@riverpod
Raw<FirebaseAuth> firebaseAuth(FirebaseAuthRef ref) => FirebaseAuth.instance;

@riverpod
Raw<GoogleSignIn> googleSignIn(GoogleSignInRef ref) => GoogleSignIn();