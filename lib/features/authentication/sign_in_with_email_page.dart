import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obs_news/features/authentication/auth_controller.dart';

import 'package:obs_news/shared/components/base_layout.dart';
import 'package:obs_news/shared/components/buttons/primary_button.dart';
import 'package:obs_news/shared/components/input/auth_input_field.dart';
import 'package:obs_news/shared/navigation/routing_constants.dart';
import 'package:obs_news/shared/theme/colors.dart';

class SignInWithEmailPage extends ConsumerWidget {
  const SignInWithEmailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController usernameNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();
    
    final authState = ref.watch(authControllerProvider);
    authState.whenData((user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, RoutingConst.defaultRoute);
      }
    });


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
              controller: usernameNameController,
              inputType: TextFieldType.text,
              hintText: AppLocalizations.of(context)!.registerScreenUsername,
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
                String username = usernameNameController.text;
                String email = emailController.text;
                String password = passwordController.text;
                String confirmPassword = confirmPasswordController.text;

                if(username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty){
                  return;
                }
                if(password != confirmPassword){
                  return;
                }

                ref.read(authControllerProvider.notifier).signUp(email, password, username);
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
