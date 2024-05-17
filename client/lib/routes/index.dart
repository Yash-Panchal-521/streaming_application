import 'package:client/pages/dashboard_page.dart';
import 'package:client/pages/home_page.dart';
import 'package:client/pages/login_page.dart';
import 'package:client/pages/register_page.dart';
import 'package:client/pages/settings_page.dart';
import 'package:client/pages/single_channel_page.dart';
import 'package:client/routes/app_routes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vrouter/vrouter.dart';

class ConnectedRoutes extends VRouteElementBuilder {
  @override
  List<VRouteElement> buildRoutes() {
    return [
      VWidget(path: AppRoutes.homeRoute, widget: const HomePage()),
      VWidget(path: AppRoutes.loginRoute, widget: const LoginPage()),
      VWidget(path: AppRoutes.registerRoute, widget: const RegisterPage()),
      VGuard(
        stackedRoutes: [
          VWidget(path: AppRoutes.dashboard, widget: const Dashboardpage()),
          VWidget(
              path: AppRoutes.singleChannel, widget: const SingleChannelPage()),
          VWidget(path: AppRoutes.settings, widget: const SettingsPage())
        ],
        beforeEnter: (vRedirector) async {
          FlutterSecureStorage storage = const FlutterSecureStorage();
          String? token = await storage.read(key: 'token');
          if (token == null) {
            vRedirector.to(AppRoutes.homeRoute);
          }
        },
      )
    ];
  }
}
