import 'package:client/pages/dashboard_page.dart';
import 'package:client/pages/home_page.dart';
import 'package:client/pages/login_page.dart';
import 'package:client/pages/register_page.dart';
import 'package:client/pages/settings_page.dart';
import 'package:client/pages/single_channel_page.dart';
import 'package:client/routes/app_routes.dart';
import 'package:vrouter/vrouter.dart';

class ConnectedRoutes extends VRouteElementBuilder {
  @override
  List<VRouteElement> buildRoutes() {
    return [
      VWidget(path: AppRoutes.homeRoute, widget: const HomePage()),
      VWidget(path: AppRoutes.loginRoute, widget: const LoginPage()),
      VWidget(path: AppRoutes.registerRoute, widget: const RegisterPage()),
      VWidget(path: AppRoutes.dashboard, widget: const Dashboardpage()),
      VWidget(path: AppRoutes.singleChannel, widget: const SingleChannelPage()),
      VWidget(path: AppRoutes.settings, widget: const SettingsPage())
    ];
  }
}
