import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:obs_news/features/authentication/auth_controller.dart';
import 'package:obs_news/features/authentication/auth_repository_impl.dart';
import 'package:obs_news/shared/components/base_layout.dart';
import 'package:obs_news/shared/components/buttons/primary_button.dart';

class NewsPage extends ConsumerWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.watch(userProvider);

    String email = "";

    authProvider.whenData((data) {
      if(data != null) {
        email = data.email ?? "[name placeholder]";
      }
    });

    return BaseWidget(
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
}
