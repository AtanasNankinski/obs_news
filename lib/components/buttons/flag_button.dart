import 'package:flutter/material.dart';

import 'package:obs_news/theme/colors.dart';

class FlagButton extends StatelessWidget {
  const FlagButton({super.key, this.child, this.onTap});

  final VoidCallback? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(4), // Border width
            decoration: const BoxDecoration(color: colorButtonFlagMain, shape: BoxShape.circle),
            child: ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(24), // Image radius
                child: child ?? Container(),
              ),
            ),
          ),
          onTap == null
              ? Container(
                  padding: const EdgeInsets.all(4), // Border width
                  decoration: const BoxDecoration(color: colorButtonFlagMain, shape: BoxShape.circle),
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(24),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
