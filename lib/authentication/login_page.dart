import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:obs_news/components/base_layout.dart';
import 'package:obs_news/components/buttons/primary_button.dart';
import 'package:obs_news/components/input/auth_input_field.dart';
import 'package:obs_news/shared/navigation/routing_constants.dart';
import 'package:obs_news/shared/theme/colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();


    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BaseWidget(
        hasPadding: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Login",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const Spacer(),
            AuthInputField(
              controller: emailController,
              inputType: TextFieldType.email,
              hintText: "Email",
            ),
            AuthInputField(
              controller: passwordController,
              inputType: TextFieldType.password,
              hintText: "Password",
            ),
            const Spacer(),
            primaryButton(
              onPressed: (){

              },
              content: "Register",
              context: context,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: Theme.of(context).textTheme.bodySmall,
                  children: [
                    TextSpan(
                      text: "Register",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: colorTextHyperlink,
                          fontWeight: FontWeight.bold
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = (){
                          Navigator.pushReplacementNamed(context, RoutingConst.signInWithEmail);
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}