import 'package:client/theme/theme.dart';
import 'package:flutter/material.dart';

InputDecoration textFieldDecoration({required String hintText, required ColorScheme colors}) {
  return InputDecoration(
    hintText: hintText,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    filled: true,
    fillColor: Colors.grey[100],
    contentPadding: EdgeInsets.symmetric(
      horizontal: AppTheme.smallPadding,
      vertical: AppTheme.smallPadding,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
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
