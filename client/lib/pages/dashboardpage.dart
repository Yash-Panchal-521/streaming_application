import 'package:client/routes/app_routes.dart';
import 'package:client/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vrouter/vrouter.dart';

class Dashboardpage extends StatelessWidget {
  const Dashboardpage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colors = theme.colorScheme;
    TextTheme textTheme = theme.textTheme;

    List<Map<String, dynamic>> followedChannels = [
      {"username": "Channel 1", "id": 1, "isOnline": false},
      {"username": "Channel 2", "id": 2, "isOnline": true},
      {"username": "Channel 3", "id": 3, "isOnline": false},
      {"username": "Channel 4", "id": 4, "isOnline": true},
      {"username": "Channel 5", "id": 5, "isOnline": false},
      {"username": "Channel 6", "id": 6, "isOnline": true},
      {"username": "Channel 7", "id": 7, "isOnline": false},
      {"username": "Channel 8", "id": 8, "isOnline": true},
      {"username": "Channel 9", "id": 9, "isOnline": false},
      {"username": "Channel 10", "id": 10, "isOnline": true},
    ];

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
          "Browse",
          style: textTheme.headlineMedium!.copyWith(color: colors.onPrimary),
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
                // context.vRouter.to(AppRoutes.registerRoute);
              },
              child: Text(
                "My Account",
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
      ),
      body: Flex(
        direction: Axis.horizontal,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              color: colors.scrim.withOpacity(0.3),
              child: Column(
                children: [
                  Text(
                    "Following channels:",
                    style: textTheme.bodyMedium!.copyWith(color: colors.primary, fontWeight: FontWeight.w900),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: followedChannels.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic> channel = followedChannels[index];
                        return Container(
                          color: index % 2 == 0 ? colors.scrim.withOpacity(0.1) : colors.onPrimary.withOpacity(0.2),
                          padding: EdgeInsets.symmetric(horizontal: AppTheme.smallPadding, vertical: AppTheme.mediumPadding),
                          child: Column(
                            children: [
                              Text(
                                "${channel["username"]}",
                                style: textTheme.bodyMedium!,
                              ),
                              SizedBox(height: AppTheme.smallPadding),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    channel["isOnline"] ? "Online" : "Offline",
                                    style: textTheme.bodyMedium!.copyWith(color: channel["isOnline"] ? Colors.green : Colors.red),
                                  ),
                                  Icon(
                                    channel["isOnline"] ? Icons.circle : Icons.circle_outlined,
                                    color: channel["isOnline"] ? Colors.green : Colors.red,
                                    size: 8,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(flex: 9, fit: FlexFit.tight, child: Container()),
        ],
      ),
    );
  }
}
