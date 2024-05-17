import 'package:client/api/post_register.dart';
import 'package:client/routes/app_routes.dart';
import 'package:client/theme/theme.dart';
import 'package:client/utils/build_text_field.dart';
import 'package:client/utils/email_validator.dart';
import 'package:client/utils/password_validator.dart';
import 'package:client/utils/username_validator.dart';
import 'package:client/widgets/elevated_button.dart';
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
              buildTextField(
                hintText: "Username",
                controller: usernameController,
                validator: validateUsername,
                colors: colors,
                textTheme: textTheme,
              ),
              const SizedBox(height: 20),
              buildTextField(
                hintText: "Email",
                controller: emailController,
                validator: validateEmail,
                colors: colors,
                textTheme: textTheme,
              ),
              const SizedBox(height: 20),
              buildTextField(
                hintText: "Password",
                controller: passwordController,
                validator: validatePassword,
                isPassword: true,
                passwordVisible: passwordVisible,
                onVisibiltyToggled: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
                colors: colors,
                textTheme: textTheme,
              ),
              const SizedBox(height: 20),
              buildTextField(
                hintText: "Confirm Password",
                controller: confirmPasswordController,
                validator: validateConfirmPassword,
                isPassword: true,
                passwordVisible: passwordVisible,
                onVisibiltyToggled: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
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
}
