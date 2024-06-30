import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:obs_news/features/authentication/auth_controller.dart';
import 'package:obs_news/features/authentication/user_controller.dart';
import 'package:obs_news/shared/components/base_layout.dart';
import 'package:obs_news/shared/components/buttons/primary_button.dart';
import 'package:obs_news/shared/components/loading_widget.dart';

class NewsPage extends ConsumerWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.watch(userControllerProvider);

    String email = "";

    authProvider.whenData((data) {
      email = _checkEmail(data);
    });

    return authProvider.isLoading ? const LoadingWidget() : BaseWidget(
      hasPadding: true,
      title: Text(
        "News",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Spacer(),
          Text(email),
          primaryButton(
            onPressed: () {
              ref.read(authControllerProvider.notifier).signOut();
            },
            content: "Logout",
            context: context,
          ),
          Spacer(),
        ],
      ),
    );
  }

  String _checkEmail(User? user) {
    if(user != null) {
      if(user.email != null) {
        return user.email!;
      }
    }
    return "[email placeholder]";
  }
}
