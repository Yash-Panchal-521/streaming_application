import 'package:flutter/material.dart';

InputDecoration textFieldDecoration({
  required String hintText,
  required ColorScheme colors,
  bool isPassword = false,
  bool passwordVisible = false,
  VoidCallback? onVisibiltyToggled,
}) {
  return InputDecoration(
    hintText: hintText,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    filled: true,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ), // Adjust padding here
    suffixIcon: isPassword
        ? IconButton(
            icon: Icon(
              size: 16,
              passwordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            ),
            onPressed: onVisibiltyToggled,
          )
        : null,
    border: OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: Colors.grey),
      borderRadius: BorderRadius.circular(0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: colors.primary, width: 2),
      borderRadius: BorderRadius.circular(0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: colors.error, width: 2),
      borderRadius: BorderRadius.circular(0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: colors.error, width: 2),
      borderRadius: BorderRadius.circular(0),
    ),
    errorStyle: TextStyle(color: colors.error, backgroundColor: colors.onPrimary),
  );
}
