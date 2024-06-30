import 'package:flutter/material.dart';

import 'package:obs_news/shared/theme/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: loadingWidgetBackground,
      child: Center(
        child: CircularProgressIndicator(
          color: loadingIndicatorColor,
        ),
      ),
    );
  }
}
