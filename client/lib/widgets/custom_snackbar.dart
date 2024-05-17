import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

customSnackbar(BuildContext context, int statusCode, String message) {
  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      titleFontSize: 16,
      messageFontSize: 14,
      title: 'Oops!',
      message: message,
      contentType: statusCode == 400 ? ContentType.warning : ContentType.failure,
    ),
  );
  return ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar, snackBarAnimationStyle: AnimationStyle(curve: Curves.easeInOutCubic, duration: const Duration(milliseconds: 500)));
}
