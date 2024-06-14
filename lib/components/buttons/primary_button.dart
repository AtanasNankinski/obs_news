import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

Widget primaryButton({
  required VoidCallback onPressed,
  required String content,
  required BuildContext context,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        content,
        style: GoogleFonts.inter(
          textStyle: Theme.of(context).textTheme.bodyMedium,
        )
      ),
    ),
  );
}