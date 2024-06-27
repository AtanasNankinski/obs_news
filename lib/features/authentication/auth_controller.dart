import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:obs_news/features/authentication/auth_repository.dart';
import 'package:obs_news/features/authentication/auth_repository_impl.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  late AuthRepository _authRepository;

  @override
  FutureOr<User?> build() {
    _authRepository = ref.read(authRepositoryProvider);
  }

  Future<void> signUp(String email, String password) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() => _authRepository.signUpWithEmailAndPassword(email, password));
  }

  Future<void> signIn(String email, String password) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() => _authRepository.signInWithEmailAndPassword(email, password));
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
  }

  Future<void> googleSignIn() async {
    try {
      state = AsyncLoading();
      await _authRepository.googleSignIn();
      _authRepository.getCurrentUser().listen((data) {
        state = AsyncData(data);
      });
    } catch(e) {
      rethrow;
    }
  }
}