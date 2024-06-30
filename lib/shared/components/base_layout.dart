import 'package:flutter/material.dart';

import 'package:obs_news/shared/components/loading_widget.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget({super.key, this.title, required this.hasPadding, required this.body, this.isLoading = false});

  final bool hasPadding;
  final Widget body;
  final Widget? title;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: title != null
          ? AppBar(
              title: title!,
          )
          : null,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Stack(
                  children: [
                    Padding(
                      padding: hasPadding ? const EdgeInsets.all(18.0) : EdgeInsets.zero,
                      child: body,
                    ),
                    isLoading ? const LoadingWidget() : Container(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
