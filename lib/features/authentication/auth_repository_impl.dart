import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:obs_news/features/authentication/auth_repository.dart';
import 'package:obs_news/shared/exceptions/exceptions.dart';

part 'auth_repository_impl.g.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;

  AuthRepositoryImpl(this._auth, this._googleSignIn, this._facebookAuth);

  @override
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final credentials = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if(credentials.user == null) return null;
      await _auth.currentUser!.updateDisplayName("New User");
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
  Future<void> updateUsername(User user, String username) async {
    await _auth.currentUser!.updateDisplayName(username);
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
      await _facebookAuth.logOut();
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

  @override
  Future<void> facebookSignIn() async {
    try {
      final LoginResult facebookUser = await _facebookAuth.login();

      if(facebookUser.accessToken == null) throw FacebookAuthException().message!;

      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(facebookUser.accessToken!.tokenString);
      await _auth.signInWithCredential(facebookAuthCredential);
    } catch(e) {
      throw FacebookAuthException().message!;
    }
  }
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) => AuthRepositoryImpl(ref.read(firebaseAuthProvider), ref.read(googleSignInProvider), ref.read(facebookAuthProvider));

@riverpod
Raw<FirebaseAuth> firebaseAuth(FirebaseAuthRef ref) => FirebaseAuth.instance;

@riverpod
Raw<GoogleSignIn> googleSignIn(GoogleSignInRef ref) => GoogleSignIn();

@riverpod
Raw<FacebookAuth> facebookAuth(FacebookAuthRef ref) => FacebookAuth.instance;