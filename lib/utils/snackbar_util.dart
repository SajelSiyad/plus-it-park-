import 'package:flutter/material.dart';

class SnackbarUtil {
  static void showError(String? message, BuildContext context) {
    if (message != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
