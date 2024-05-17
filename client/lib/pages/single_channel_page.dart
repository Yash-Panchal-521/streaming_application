import 'package:client/api/get_channel_details.dart';
import 'package:client/api/post_follow_channel.dart';
import 'package:client/theme/theme.dart';
import 'package:client/widgets/custom_appbar.dart';
import 'package:client/widgets/elevated_button.dart';
import 'package:client/widgets/side_navbar.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class SingleChannelPage extends StatefulWidget {
  const SingleChannelPage({super.key});

  @override
  State<SingleChannelPage> createState() => _SingleChannelPageState();
}

class _SingleChannelPageState extends State<SingleChannelPage> {
  @override
  Widget build(BuildContext context) {
    String? channelId = VRouter.of(context).pathParameters["pk"];
    ThemeData theme = Theme.of(context);
    ColorScheme colors = theme.colorScheme;
    TextTheme textTheme = theme.textTheme;
    return Scaffold(
      appBar: customAppBar(context, "Browse"),
      body: Flex(
        direction: Axis.horizontal,
        children: [
          const Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: SideNavBar(),
          ),
          Flexible(
            flex: 8,
            fit: FlexFit.tight,
            child: FutureBuilder(
              future: getChannelDetails(channelId!, context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  dynamic channel = snapshot.data;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(channel["isOnline"]
                            ? "Channel is Online"
                            : "Channel is offline"),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: AppTheme.mediumPadding),
                                  child: Text(
                                    "${channel["title"]}",
                                    style: textTheme.bodyLarge!
                                        .copyWith(fontWeight: FontWeight.w900),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: AppTheme.largePadding),
                                  child: primaryElevatedButtonWidget(
                                      label: "Follow",
                                      onPressed: () {
                                        postFollowChannel(context, channelId);
                                      },
                                      colors: colors),
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
                            borderRadius: BorderRadius.circular(
                                AppTheme.mediumBorderRadius),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(AppTheme.smallPadding),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("${channel["description"]}")),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
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
