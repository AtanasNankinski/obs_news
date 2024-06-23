import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:obs_news/shared/components/base_layout.dart';
import 'package:obs_news/shared/components/buttons/primary_button.dart';
import 'package:obs_news/shared/components/input/auth_input_field.dart';
import 'package:obs_news/shared/navigation/routing_constants.dart';
import 'package:obs_news/shared/theme/colors.dart';

class SignInWithEmailPage extends StatelessWidget {
  const SignInWithEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();


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
              AppLocalizations.of(context)!.registerScreenTitle,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const Spacer(),
            AuthInputField(
              controller: firstNameController,
              inputType: TextFieldType.text,
              hintText: AppLocalizations.of(context)!.registerScreenFirstName,
            ),
            AuthInputField(
              controller: lastNameController,
              inputType: TextFieldType.text,
              hintText: AppLocalizations.of(context)!.registerScreenLastName,
            ),
            AuthInputField(
              controller: emailController,
              inputType: TextFieldType.email,
              hintText: AppLocalizations.of(context)!.registerScreenEmail,
            ),
            AuthInputField(
              controller: passwordController,
              inputType: TextFieldType.password,
              hintText: AppLocalizations.of(context)!.registerScreenPassword,
            ),
            AuthInputField(
              controller: confirmPasswordController,
              inputType: TextFieldType.passwordConfirmation,
              hintText: AppLocalizations.of(context)!.registerScreenConfirmPassword,
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
                  text: "Already have an account? ",
                  style: Theme.of(context).textTheme.bodySmall,
                  children: [
                    TextSpan(
                        text: "Login",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: colorTextHyperlink,
                            fontWeight: FontWeight.bold
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = (){
                            Navigator.pushReplacementNamed(context, RoutingConst.login);
                          }
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
