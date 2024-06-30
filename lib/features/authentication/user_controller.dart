import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:obs_news/features/authentication/auth_repository.dart';
import 'package:obs_news/features/authentication/auth_repository_impl.dart';

part 'user_controller.g.dart';

@riverpod
class UserController extends _$UserController {
   late AuthRepository _authRepository;

  @override
  Stream<User?> build() {
    _authRepository = ref.read(authRepositoryProvider);
    return _authRepository.getCurrentUser();
  }
}