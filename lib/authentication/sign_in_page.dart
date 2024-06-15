import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obs_news/app.dart';

import 'package:obs_news/components/base_layout.dart';
import 'package:obs_news/components/buttons/google_button.dart';
import 'package:obs_news/components/buttons/primary_button.dart';
import 'package:obs_news/components/separator_with_text.dart';
import 'package:obs_news/components/buttons/facebook_button.dart';
import 'package:obs_news/navigation/routing_constants.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseWidget(
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
              Navigator.pushReplacementNamed(context, RoutingConst.signInWithEmail);
            },
            content: AppLocalizations.of(context)!.emailSignIn,
            context: context,
          ),
          const Spacer(),
          Row(
            children: [
              primaryButton(
                onPressed: () {
                  ref.read(localizationProvider.notifier).changeLocale(Locale('en'));
                },
                content: "EN",
                context: context,
              ),
              Spacer(),
              primaryButton(
                onPressed: () {
                  ref.read(localizationProvider.notifier).changeLocale(Locale('bg'));
                },
                content: "BG",
                context: context,
              ),
            ],
          ),
        ],
      ),
      hasPadding: true,
    );
  }
}
