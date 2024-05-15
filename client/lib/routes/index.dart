import 'package:client/pages/homepage.dart';
import 'package:client/pages/loginpage.dart';
import 'package:client/pages/registerpage.dart';
import 'package:client/routes/app_routes.dart';
import 'package:vrouter/vrouter.dart';

class ConnectedRoutes extends VRouteElementBuilder {
  @override
  List<VRouteElement> buildRoutes() {
    return [
      VWidget(path: AppRoutes.homeRoute, widget: const HomePage()),
      VWidget(path: AppRoutes.loginRoute, widget: const LoginPage()),
      VWidget(path: AppRoutes.registerRoute, widget: const RegisterPage())
    ];
  }
}
