import 'package:client/widgets/text_field_decoration.dart';
import 'package:flutter/material.dart';

Widget buildTextField({
  required String hintText,
  required TextEditingController controller,
  required String? Function(String?) validator,
  bool isPassword = false,
  bool passwordVisible = false,
  VoidCallback? onVisibiltyToggled,
  required ColorScheme colors,
  required TextTheme textTheme,
  bool isTextArea = false,
}) {
  return Material(
    child: SizedBox(
      height: isTextArea ? 100 : null,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        validator: validator,
        expands: isTextArea,
        keyboardType: isTextArea ? TextInputType.multiline : TextInputType.text,
        maxLines: isTextArea ? null : 1,
        minLines: isTextArea ? null : 1,
        textAlign: TextAlign.start,
        obscureText: isPassword && !passwordVisible,
        decoration: textFieldDecoration(
          hintText: hintText,
          colors: colors,
          isPassword: isPassword,
          passwordVisible: passwordVisible,
          onVisibiltyToggled: onVisibiltyToggled,
        ),
      ),
    ),
  );
}
