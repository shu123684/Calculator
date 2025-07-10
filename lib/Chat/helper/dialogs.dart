import 'package:calculator/Chat/api/apis.dart';
import 'package:flutter/material.dart';

class Dialogs {
  // Declaring static so that it can be called with Dialogs.showSnackBar
  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
        backgroundColor: APIs.themeManager.themeMode == ThemeMode.dark
            ? Colors.grey[350]
            : Colors.blue.withOpacity(0.8),
      ),
    );
  }

  // progress bar
  static showProgressBar(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(child: CircularProgressIndicator()),
    );
  }
}
