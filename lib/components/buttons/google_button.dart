import 'package:flutter/material.dart';

import 'package:obs_news/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

Widget googleButton({
  required VoidCallback onPressed,
  required String content
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    child: ElevatedButton(
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            Image.asset(
              "assets/images/google-logo.png",
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
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(100, 40),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        backgroundColor: colorButtonGoogle,
        foregroundColor: colorButtonTextDarkColor,
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(30)
            )
        ),
        textStyle: GoogleFonts.inter(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            )
        ),
        disabledBackgroundColor: colorButtonDisabled,
      ),
    ),
  );
}