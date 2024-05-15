import 'package:client/routes/app_routes.dart';
import 'package:client/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colors = theme.colorScheme;
    TextTheme textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                colors.secondary,
                colors.primary,
              ],
            ),
          ),
        ),
        title: Text(
          "Streaming App",
          style: textTheme.headlineMedium!.copyWith(color: colors.onPrimary),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.mediumPadding),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all<Color>(colors.onPrimary),
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
              onPressed: () {
                context.vRouter.to(AppRoutes.registerRoute);
              },
              child: Text(
                "Register",
                style: textTheme.labelMedium!.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.mediumPadding),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(colors.primary),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                    side: BorderSide(
                      width: AppTheme.thinBorderSize,
                      color: colors.onPrimary,
                    ),
                  ),
                ),
              ),
              onPressed: () {
                context.vRouter.to(AppRoutes.loginRoute);
              },
              child: Text(
                "Login",
                style: textTheme.labelMedium!.copyWith(
                  color: colors.onPrimary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
