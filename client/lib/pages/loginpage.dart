import 'package:client/routes/app_routes.dart';
import 'package:client/theme/theme.dart';
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
  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool passwordVisible = false;

  TextEditingController emailController = TextEditingController(text: null);
  TextEditingController passwordController = TextEditingController(text: null);

  String? validateEmail(String? value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    if (value == null) {
      return 'Enter your email';
    }
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
    RegExp regex = RegExp(pattern as String);
    if (value == null) {
      return 'Enter your password';
    }
    if (!regex.hasMatch(value)) {
      return 'Enter valid password';
    } else {
      return null;
    }
  }

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
        key: scaffoldKey,
        body: Row(
          children: [
            Container(
              width: screenWidth / 2,
              height: screenHeight,
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: AppTheme.largeWidth),
              width: screenWidth / 2,
              height: screenHeight,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(AppTheme.mediumPadding),
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
                      padding: EdgeInsets.symmetric(
                        vertical: AppTheme.smallPadding,
                      ),
                      child: Text(
                        "Email",
                        style: textTheme.labelMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Material(
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: emailController,
                        validator: validateEmail,
                        decoration: textFieldDecoration(
                          hintText: "Enter Your Email",
                          colors: colors,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppTheme.smallPadding,
                      ),
                      child: Text(
                        "Password",
                        style: textTheme.labelMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Material(
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: passwordController,
                        validator: validatePassword,
                        obscureText: !passwordVisible,
                        decoration: textFieldDecoration(
                          hintText: "Enter Your Password",
                          colors: colors,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    primaryElevatedButtonWidget(
                      label: "Login",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login successful")));
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
            )
          ],
        ),
      ),
    );
  }
}
