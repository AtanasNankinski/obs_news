import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obs_news/features/authentication/auth_controller.dart';

import 'package:obs_news/features/authentication/sign_in_page.dart';
import 'package:obs_news/features/news/news_page.dart';
import 'package:obs_news/shared/components/base_layout.dart';

class AuthControlWidget extends ConsumerWidget {
  const AuthControlWidget({super.key});

  final bool isSignedIn = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authData = ref.watch(authControllerProvider);
    Widget authResult = loadingWidget();

    authData.when(
      data: (user){
        authResult = user == null ? SignInPage() : NewsPage();
      },
      error: (_, __) {
        authResult = loadingWidget();
      },
      loading: () {
        authResult = loadingWidget();
      },
    );

    return authResult;
  }

  Widget loadingWidget() {
    return const BaseWidget(
      hasPadding: true,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
