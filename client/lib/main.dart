import 'package:client/routes/app_routes.dart';
import 'package:client/routes/index.dart';
import 'package:client/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VRouter(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        routes: [ConnectedRoutes()],
        mode: VRouterMode.history,
        initialUrl: AppRoutes.homeRoute,
      ),
    );
  }
}
