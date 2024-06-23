import 'package:flutter/material.dart';

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
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontFamily: 'Inter',
        ),
      ),
    ),
  );
}