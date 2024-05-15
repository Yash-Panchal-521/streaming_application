import "package:client/theme/theme.dart";
import "package:flutter/material.dart";

Widget primaryElevatedButtonWidget({required String label, required Function() onPressed, required ColorScheme colors}) {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(colors.primary),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(
            width: AppTheme.thinBorderSize,
            color: colors.primary,
          ),
        ),
      ),
    ),
    onPressed: onPressed,
    child: Container(
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(color: colors.onPrimary),
      ),
    ),
  );
}

Widget secondaryElevatedButtonWidget({required String label, required Function() onPressed, required ColorScheme colors}) {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(colors.onPrimary),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(
            width: AppTheme.thinBorderSize,
            color: colors.primary,
          ),
        ),
      ),
    ),
    onPressed: onPressed,
    child: Container(
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(color: colors.primary),
      ),
    ),
  );
}
