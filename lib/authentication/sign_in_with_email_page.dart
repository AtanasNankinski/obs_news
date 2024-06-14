import 'package:flutter/material.dart';

import 'package:obs_news/components/base_layout.dart';

class SignInWithEmailPage extends StatelessWidget {
  const SignInWithEmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseWidget(
      hasPadding: true,
      body: Center(
        child: Text("Sign In With Email"),
      ),
    );
  }
}
