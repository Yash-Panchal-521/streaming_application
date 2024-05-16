import 'package:client/api/register_api.dart';
import 'package:client/routes/app_routes.dart';
import 'package:client/theme/theme.dart';
import 'package:client/widgets/elevated_button.dart';
import 'package:client/widgets/text_field_decoration.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool passwordVisible = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colors = theme.colorScheme;
    TextTheme textTheme = theme.textTheme;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Form(
      key: formKey,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth < 600) {
              // For small screen devices
              return _buildRegisterWidget(
                context,
                colors,
                textTheme,
                screenWidth,
                screenHeight,
              );
            } else {
              // For medium screen devices
              return Row(
                children: [
                  Container(
                    width: screenWidth / 2,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          colors.secondary,
                          colors.primary,
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: _buildRegisterWidget(context, colors, textTheme, screenWidth, screenHeight),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildRegisterWidget(
    BuildContext context,
    ColorScheme colors,
    TextTheme textTheme,
    double screenWidth,
    double screenHeight,
  ) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppTheme.mediumPadding, vertical: AppTheme.mediumPadding), // Adjust padding here
        width: screenWidth > 600 ? screenWidth / 2 : screenWidth,
        height: screenHeight,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start, // Align fields to the start
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(AppTheme.mediumPadding),
                  child: Text(
                    "Register",
                    style: textTheme.headlineMedium!.copyWith(
                      color: colors.primary,
                      letterSpacing: -1,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              _buildTextField(
                hintText: "Username",
                controller: usernameController,
                validator: validateUsername,
                colors: colors,
                textTheme: textTheme,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                hintText: "Email",
                controller: emailController,
                validator: validateEmail,
                colors: colors,
                textTheme: textTheme,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                hintText: "Password",
                controller: passwordController,
                validator: validatePassword,
                isPassword: true,
                colors: colors,
                textTheme: textTheme,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                hintText: "Confirm Password",
                controller: confirmPasswordController,
                validator: validateConfirmPassword,
                isPassword: true,
                colors: colors,
                textTheme: textTheme,
              ),
              const SizedBox(height: 20),
              primaryElevatedButtonWidget(
                label: "Register",
                onPressed: () {
                  if (Form.of(context).validate()) {
                    register(emailController.text, passwordController.text, usernameController.text, context);
                  }
                },
                colors: colors,
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => context.vRouter.to(AppRoutes.loginRoute),
                child: Text(
                  "Already have an account? Login",
                  textAlign: TextAlign.left,
                  style: textTheme.labelMedium!.copyWith(color: colors.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool isPassword = false,
    required ColorScheme colors,
    required TextTheme textTheme,
  }) {
    return Material(
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        validator: validator,
        obscureText: isPassword && !passwordVisible,
        decoration: textFieldDecoration(
          hintText: hintText,
          colors: colors,
          isPassword: isPassword,
          passwordVisible: passwordVisible,
          onVisibiltyToggled: () => setState(() {
            passwordVisible = !passwordVisible;
          }),
        ),
      ),
    );
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your email';
    }
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your password';
    }

    // Check if password contains at least one uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check if password contains at least one lowercase letter
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check if password contains at least one digit
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit';
    }

    // Check if password contains at least one special character
    if (!value.contains(RegExp(r'[!@#\$&*~]'))) {
      return 'Password must contain at least one special character';
    }

    // Check if password length is at least 6 characters
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    // Password meets all criteria
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null) {
      return 'Confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    } else {
      return null;
    }
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your username';
    }
    if (value.length <= 3 || value.length >= 8) {
      return 'Username must be between 4 and 7 characters long';
    } else {
      return null;
    }
  }
}
