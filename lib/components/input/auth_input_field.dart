import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:obs_news/components/decorations/input_decorations.dart';
import 'package:obs_news/shared/theme/colors.dart';

class AuthInputField extends ConsumerWidget {
  const AuthInputField({super.key, required this.controller, required this.inputType, this.hintText = "", this.enabled = true, this.onChanged});

  final TextEditingController controller;
  final TextFieldType inputType;
  final String hintText;
  final bool enabled;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool obscure = ref.watch(_passwordFieldObscureProvider);

    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: TextField(
        decoration: !_isPasswordField(inputType)
            ? defaultTextFieldDecoration(
          hintText: _determineHintText(inputType, hintText),
          context: context,
        )
            : defaultTextFieldDecoration(
          hintText: _determineHintText(inputType, hintText),
          context: context,)
            .copyWith(
          suffixIcon: IconButton(
            icon: Icon(
              // Checking which icon should be used based on if the text is obscured or not
              obscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
            iconSize: 20,
            onPressed: (){
              ref.read(_passwordFieldObscureProvider.notifier).state = !obscure;
            },
          ),
        ),
        onChanged: onChanged,
        controller: controller,
        enableSuggestions: _isPasswordField(inputType)
            ? false
            : true,
        autocorrect: false,
        obscureText: _isPasswordField(inputType)
            ? obscure
            : false,
        textInputAction: TextInputAction.done,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: colorTextInputField,
        ),
        enabled: enabled,
      ),
    );
  }

  String _determineHintText(TextFieldType inputType, String hintText){
    switch(inputType) {
      case TextFieldType.email:
        return "Email";
      case TextFieldType.password:
        return "Password";
      case TextFieldType.passwordConfirmation:
        return "Confirm Password";
      case TextFieldType.text:
        if(hintText != ""){
          return hintText;
        }
        return "Text";
    }
  }

  bool _isPasswordField(TextFieldType inputType){
    if(inputType == TextFieldType.passwordConfirmation || inputType == TextFieldType.password){
      return true;
    }
    return false;
  }
}

final _passwordFieldObscureProvider = StateProvider.autoDispose<bool>(
      (ref) => true,
);

enum TextFieldType {
  email,
  password,
  passwordConfirmation,
  text,
}