import 'package:client/theme/theme.dart';
import 'package:client/widgets/custom_appbar.dart';
import 'package:client/widgets/elevated_button.dart';
import 'package:client/widgets/side_navbar.dart';
import 'package:flutter/material.dart';

class SingleChannelPage extends StatefulWidget {
  const SingleChannelPage({super.key});

  @override
  State<SingleChannelPage> createState() => _SingleChannelPageState();
}

class _SingleChannelPageState extends State<SingleChannelPage> {
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

  Map<String, dynamic> channel = {
    "id": "1",
    "title": "test1",
    "username": "test1",
    "isOnline": false,
    "description": "This is a test channel description."
  };
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colors = theme.colorScheme;
    TextTheme textTheme = theme.textTheme;
    return Scaffold(
      appBar: customAppBar(context, "Browse"),
      body: Flex(
        direction: Axis.horizontal,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: SideNavBar(followedChannels: followedChannels),
          ),
          Flexible(
            flex: 8,
            fit: FlexFit.tight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(channel["isOnline"] ? "Channel is Online" : "Channel is offline"),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: AppTheme.mediumPadding),
                            child: Text(
                              "${channel["title"]}",
                              style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w900),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: AppTheme.largePadding),
                            child: primaryElevatedButtonWidget(label: "Follow", onPressed: () {}, colors: colors),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(AppTheme.mediumPadding),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${channel["username"]}",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(AppTheme.mediumPadding),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors.scrim.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppTheme.mediumBorderRadius),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(AppTheme.smallPadding),
                      child: Align(alignment: Alignment.centerLeft, child: Text("${channel["description"]}")),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Container(
                color: colors.scrim.withOpacity(0.3),
              ))
        ],
      ),
    );
  }
}
