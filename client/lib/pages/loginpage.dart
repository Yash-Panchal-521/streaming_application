import 'package:client/api/login_api.dart';
import 'package:client/routes/app_routes.dart';
import 'package:client/widgets/elevated_button.dart';
import 'package:client/widgets/text_field_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vrouter/vrouter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;
  bool isPasswordVisible = false;
  GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colors = theme.colorScheme;
    TextTheme textTheme = theme.textTheme;

    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth < 600) {
            // For small screen devices
            return _buildLoginWidget(context, colors, textTheme, constraints);
          } else {
            // For medium screen devices
            return Row(
              children: [
                Container(
                  width: constraints.maxWidth / 2,
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
                  child: _buildLoginWidget(
                      context, colors, textTheme, constraints),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildLoginWidget(
    BuildContext context,
    ColorScheme colors,
    TextTheme textTheme,
    BoxConstraints constraints,
  ) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Login",
                    style: textTheme.headlineMedium!.copyWith(
                      color: colors.primary,
                      letterSpacing: -1,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Email",
                  style: textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              TextFormField(
                controller: emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: validateEmail,
                decoration: textFieldDecoration(
                  hintText: "Enter Your Email",
                  colors: colors,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Password",
                  style: textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: passwordController,
                validator: (value) => validatePassword(value),
                obscureText: !passwordVisible,
                decoration: textFieldDecoration(
                    hintText: "Enter Your Password",
                    colors: colors,
                    isPassword: true,
                    passwordVisible: passwordVisible,
                    onVisibiltyToggled: () => setState(() {
                          passwordVisible = !passwordVisible;
                        })),
              ),
              const SizedBox(height: 20),
              primaryElevatedButtonWidget(
                label: "Login",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    login(emailController.text, passwordController.text);
                  }
                },
                colors: colors,
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => context.vRouter.to(AppRoutes.registerRoute),
                child: Text(
                  "Already have an account?",
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
}
