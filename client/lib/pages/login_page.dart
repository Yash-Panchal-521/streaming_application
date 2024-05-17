import 'package:client/api/post_login.dart';
import 'package:client/routes/app_routes.dart';
import 'package:client/utils/build_text_field.dart';
import 'package:client/utils/email_validator.dart';
import 'package:client/utils/password_validator.dart';
import 'package:client/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey();
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
                  child: _buildLoginWidget(context, colors, textTheme, constraints),
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
              buildTextField(
                hintText: "Enter Your Email",
                controller: emailController,
                validator: validateEmail,
                colors: colors,
                textTheme: textTheme,
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
              buildTextField(
                hintText: "Enter Your Password",
                controller: passwordController,
                validator: validatePassword,
                colors: colors,
                textTheme: textTheme,
                isPassword: true,
                passwordVisible: passwordVisible,
                onVisibiltyToggled: () => setState(() {
                  passwordVisible = !passwordVisible;
                }),
              ),
              const SizedBox(height: 20),
              primaryElevatedButtonWidget(
                label: "Login",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    login(emailController.text, passwordController.text, context);
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
}
