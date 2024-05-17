import 'package:client/routes/app_routes.dart';
import 'package:client/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vrouter/vrouter.dart';

PreferredSizeWidget customAppBar(BuildContext context, String title) {
  ThemeData theme = Theme.of(context);
  ColorScheme colors = theme.colorScheme;
  TextTheme textTheme = theme.textTheme;

  return AppBar(
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
    title: InkWell(
      onTap: () {
        context.vRouter.to(AppRoutes.dashboard);
      },
      child: Row(
        children: [
          Icon(
            Icons.live_tv,
            color: colors.onPrimary,
            size: textTheme.headlineMedium!.fontSize ?? 55.0,
          ),
          SizedBox(width: AppTheme.smallPadding),
          Text(
            "Browse",
            style: textTheme.headlineMedium!.copyWith(color: colors.onPrimary),
          ),
        ],
      ),
    ),
    actions: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: AppTheme.mediumPadding),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(colors.onPrimary),
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
            context.vRouter.to(AppRoutes.settings);
          },
          child: Text(
            "My Settings",
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
          onPressed: () async {
            FlutterSecureStorage storage = const FlutterSecureStorage();
            await storage.deleteAll();
            context.vRouter.to(AppRoutes.homeRoute);
          },
          child: Text(
            "Logout",
            style: textTheme.labelMedium!.copyWith(
              color: colors.onPrimary,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    ],
  );
}
