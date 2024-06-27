import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:obs_news/features/authentication/auth_controller.dart';
import 'package:obs_news/shared/components/base_layout.dart';
import 'package:obs_news/shared/components/buttons/primary_button.dart';
import 'package:obs_news/shared/components/input/auth_input_field.dart';
import 'package:obs_news/shared/extensions/async_value_ui.dart';
import 'package:obs_news/shared/extensions/string_extentions.dart';
import 'package:obs_news/shared/navigation/routing_constants.dart';
import 'package:obs_news/shared/theme/colors.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    ref.listen(authControllerProvider, (_, next) {
      next.showSnackBarOnError(context);
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
              AppLocalizations.of(context)!.loginScreenTitle,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const Spacer(),
            AuthInputField(
              controller: emailController,
              inputType: TextFieldType.email,
              hintText: AppLocalizations.of(context)!.loginScreenEmail,
            ),
            AuthInputField(
              controller: passwordController,
              inputType: TextFieldType.password,
              hintText: AppLocalizations.of(context)!.loginScreenPassword,
            ),
            const Spacer(),
            primaryButton(
              onPressed: (){
                String email = emailController.text;
                String password = passwordController.text;

                if(_checkCredentials(context, email, password)){
                  ref.read(authControllerProvider.notifier).signIn(email, password);
                }
              },
              content: AppLocalizations.of(context)!.loginScreenLoginButton,
              context: context,
            ),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: AppLocalizations.of(context)!.loginScreenBottomText,
                  style: Theme.of(context).textTheme.bodySmall,
                  children: [
                    TextSpan(
                      text: AppLocalizations.of(context)!.loginScreenRegisterHyperlink,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: colorTextHyperlink,
                          fontWeight: FontWeight.bold
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = (){
                          context.go(RoutingConst.signInWithEmail.loggedOutRoute());
                        },
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!.loginScreenForgottenPasswordHyperlink,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: colorTextHyperlink,
                          fontWeight: FontWeight.bold
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = (){
                          print("Forgot Password Hyperlink Tapped");
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

  bool _checkCredentials(BuildContext context, String email, String password) {
    if(email.isEmpty || password.isEmpty){
      _showSnackBar(context, AppLocalizations.of(context)!.registerScreenEmptyFields);
      return false;
    }
    if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)){
      _showSnackBar(context, AppLocalizations.of(context)!.registerScreenInvalidEmail);
      return false;
    }

    return true;
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}