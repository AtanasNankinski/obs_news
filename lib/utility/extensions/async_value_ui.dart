import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUI on AsyncValue {
  void showSnackBarOnError(
      BuildContext context,
      {String? errorText}
  ) {
    if (!isLoading && hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: errorText != null
              ? Text(errorText)
              : Text(error.toString(),
          ),
        ),
      );
    }
  }
}