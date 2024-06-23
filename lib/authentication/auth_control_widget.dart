import 'package:flutter/material.dart';

import 'package:obs_news/authentication/sign_in_page.dart';
import 'package:obs_news/news/news_page.dart';

class AuthControlWidget extends StatelessWidget {
  const AuthControlWidget({super.key});

  final bool isSignedIn = false;

  @override
  Widget build(BuildContext context) {
    return isSignedIn ? NewsPage() : SignInPage();
  }
}
