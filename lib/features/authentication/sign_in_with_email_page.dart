import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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

class SignInWithEmailPage extends ConsumerWidget {
  const SignInWithEmailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

    final auth = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (_, next) {
      next.showSnackBarOnError(context);
    });

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BaseWidget(
        isLoading: auth.isLoading,
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
                String email = emailController.text;
                String password = passwordController.text;
                String confirmPassword = confirmPasswordController.text;

                if(_checkCredentials(context, email, password, confirmPassword)) {
                  ref.read(authControllerProvider.notifier).signUp(email, password);
                }
              },
              content: AppLocalizations.of(context)!.registerScreenRegisterButton,
              context: context,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  text: AppLocalizations.of(context)!.registerScreenBottomText,
                  style: Theme.of(context).textTheme.bodySmall,
                  children: [
                    TextSpan(
                      text: AppLocalizations.of(context)!.registerScreenLoginHyperlink,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: colorTextHyperlink,
                          fontWeight: FontWeight.bold
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = (){
                          context.go(RoutingPaths.login.loggedOutRoute());
                        },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _checkCredentials(BuildContext context, String email, String password, String confirmPassword) {
    if(email.isEmpty || password.isEmpty || confirmPassword.isEmpty){
      _showSnackBar(context, AppLocalizations.of(context)!.registerScreenEmptyFields);
      return false;
    }
    if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)){
      _showSnackBar(context, AppLocalizations.of(context)!.registerScreenInvalidEmail);
      return false;
    }
    if(password.length < 8){
      _showSnackBar(context, AppLocalizations.of(context)!.registerScreenInvalidPassword);
      return false;
    }
    if(confirmPassword != password){
      _showSnackBar(context, AppLocalizations.of(context)!.registerScreenPasswordsNotMatching);
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
