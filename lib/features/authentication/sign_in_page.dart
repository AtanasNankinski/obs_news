import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:obs_news/features/authentication/auth_controller.dart';
import 'package:obs_news/shared/components/base_layout.dart';
import 'package:obs_news/shared/components/buttons/flag_button.dart';
import 'package:obs_news/shared/components/buttons/google_button.dart';
import 'package:obs_news/shared/components/buttons/primary_button.dart';
import 'package:obs_news/shared/components/loading_widget.dart';
import 'package:obs_news/shared/components/separator_with_text.dart';
import 'package:obs_news/shared/components/buttons/facebook_button.dart';
import 'package:obs_news/shared/extensions/async_value_ui.dart';
import 'package:obs_news/shared/extensions/string_extentions.dart';
import 'package:obs_news/shared/localization/localization_controller.dart';
import 'package:obs_news/shared/navigation/routing_constants.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Locale localeState = ref.watch(localizationControllerProvider);
    ref.listen(authControllerProvider, (_, next) {
      next.showSnackBarOnError(context);
    });

    return ref.watch(authControllerProvider).isLoading ? const LoadingWidget() : BaseWidget(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.signIn,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const Spacer(),
          googleButton(
            onPressed: (){
              ref.read(authControllerProvider.notifier).googleSignIn();
            },
            content: AppLocalizations.of(context)!.googleSignIn,
          ),
          facebookButton(
            onPressed: () {},
            content: AppLocalizations.of(context)!.facebookSignIn,
          ),
          sectionSeparator(
            context: context,
            text: AppLocalizations.of(context)!.signInSeparator,
          ),
          primaryButton(
            onPressed: (){
              print("Navigating to the sign in with email screen...");
              context.go(RoutingConst.signInWithEmail.loggedOutRoute());
            },
            content: AppLocalizations.of(context)!.emailSignIn,
            context: context,
          ),
          const Spacer(),
          Row(
            children: [
              const Spacer(),
              FlagButton(
                child: localeState.languageCode == 'bg'
                    ? Image.asset('assets/images/bg_flag.jpg', fit: BoxFit.cover,)
                    : Image.asset('assets/images/en_flag.jpg', fit: BoxFit.cover,),
                onTap: () {
                  ref.read(localizationControllerProvider.notifier).changeLocale();
                },
              ),
            ],
          ),
        ],
      ),
      hasPadding: true,
    );
  }
}
