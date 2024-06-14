import 'package:flutter/material.dart';

import 'package:obs_news/theme/colors.dart';

Widget sectionSeparator({required String text, required BuildContext context}) {
  return Row(
    children: [
      Expanded(
        child: Container(
          color: colorSeparator,
          height: 1,
          width: double.infinity,
          margin: const EdgeInsets.only(right: 20, top: 8, bottom: 8),
        ),
      ),
      Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      Expanded(
        child: Container(
          color: colorSeparator,
          height: 1,
          width: double.infinity,
          margin: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
        ),
      ),
    ],
  );
}