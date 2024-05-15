import 'package:client/routes/app_routes.dart';
import 'package:client/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vrouter/vrouter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<void> initFuture;

  @override
  void initState() {
    super.initState();
    initFuture = _initFuture();
  }

  Future<void> _initFuture() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    print(token);
    if (token != null) {
      // ignore: use_build_context_synchronously
      context.vRouter.to(AppRoutes.loginRoute);
    }
  }

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.live_tv,
              size: 100,
              color: colors.primary,
            ),
            const SizedBox(height: 20),
            Text(
              "Live Video Streaming",
              style: textTheme.headlineMedium!.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Watch live video streams from around the world.",
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium!.copyWith(
                color: colors.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
