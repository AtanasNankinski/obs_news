import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:obs_news/components/base_layout.dart';
import 'package:obs_news/components/buttons/flag_button.dart';
import 'package:obs_news/components/buttons/google_button.dart';
import 'package:obs_news/components/buttons/primary_button.dart';
import 'package:obs_news/components/separator_with_text.dart';
import 'package:obs_news/components/buttons/facebook_button.dart';
import 'package:obs_news/localization/localization_controller.dart';
import 'package:obs_news/navigation/routing_constants.dart';
import 'package:obs_news/utility/extensions/async_value_ui.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Locale> localeState = ref.watch(localizationProvider);

    ref.listen(
      localizationProvider,
      (_, state) => state.showSnackBarOnError(context, errorText: AppLocalizations.of(context)!.localizationError),
    );

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
              const Spacer(),
              localeState.when(
                data: (locale) {
                  return FlagButton(
                      child: locale.languageCode == 'bg'
                        ? Image.asset('assets/images/bg_flag.jpg', fit: BoxFit.cover,)
                        : Image.asset('assets/images/en_flag.jpg', fit: BoxFit.cover,),
                      onTap: () {
                        ref.read(localizationProvider.notifier).changeLocale();
                      },
                  );
                },
                error: (error, _) => Image.asset('assets/images/en_flag.jpg', fit: BoxFit.cover,),
                loading: () => const FlagButton(),
              )
            ],
          ),
        ],
      ),
      hasPadding: true,
    );
  }
}
