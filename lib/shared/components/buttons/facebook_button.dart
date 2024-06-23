import 'package:flutter/material.dart';

import 'package:obs_news/shared/theme/colors.dart';

Widget facebookButton({
  required VoidCallback onPressed,
  required String content
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(100, 40),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        backgroundColor: colorButtonFacebook,
        foregroundColor: colorButtonText,
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(30)
            )
        ),
        textStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        disabledBackgroundColor: colorButtonDisabled,
      ),
      child: Padding(
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            Image.asset(
              "assets/images/facebook-logo.png",
              width: 26,
              height: 26,
            ),
            const Spacer(),
            Text(
              content,
            ),
            const Spacer(),
            Container(width: 26,),
          ],
        ),
      ),
    ),
  );
}