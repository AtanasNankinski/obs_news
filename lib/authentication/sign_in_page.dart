import 'package:flutter/material.dart';

import 'package:obs_news/components/base_layout.dart';
import 'package:obs_news/components/buttons/google_button.dart';
import 'package:obs_news/components/buttons/primary_button.dart';
import 'package:obs_news/components/separator_with_text.dart';
import 'package:obs_news/components/buttons/facebook_button.dart';
import 'package:obs_news/navigation/routing_constants.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      init: () => print("Sign In Page Initialized!"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Sign In",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const Spacer(),
          googleButton(
            onPressed: (){

            },
            content: "Google Sign In",
          ),
          facebookButton(
            onPressed: () {},
            content: "Facebook Sign In",
          ),
          sectionSeparator(
            context: context,
            text: "or"
          ),
          primaryButton(
            onPressed: (){
              Navigator.pushReplacementNamed(context, RoutingConst.signInWithEmail);
            },
            content: "Email Sign In",
            context: context,
          ),
          const Spacer(),
        ],
      ),
      hasPadding: true,
    );
  }
}
