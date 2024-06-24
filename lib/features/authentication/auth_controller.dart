import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:obs_news/features/authentication/auth_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  Stream<User?> build() {
    final authRepository = ref.read(authRepositoryProvider);
    return authRepository.getCurrentUser();
  }

  Future<void> signUp(String email, String password, String username) async {
    final authRepository = ref.read(authRepositoryProvider);
    state = AsyncLoading();
    await AsyncValue.guard(() => authRepository.signUpWithEmailAndPassword(email, password, username));

    ref.invalidateSelf();
  }

  Future<User?> signIn(String email, String password) async {
    //TODO implement
    return null;
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
  }
}