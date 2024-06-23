import 'package:flutter/material.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget({super.key, this.title, this.init, required this.hasPadding, required this.body});

  final VoidCallback? init;
  final bool hasPadding;
  final Widget body;
  final Widget? title;

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
                    ],
                  )
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
