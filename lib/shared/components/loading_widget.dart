import 'package:flutter/material.dart';
import 'package:obs_news/shared/components/base_layout.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseWidget(
      hasPadding: false,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
