import 'package:client/api/get_channels.dart';
import 'package:client/theme/theme.dart';
import 'package:client/widgets/channel_card.dart';
import 'package:client/widgets/custom_appbar.dart';
import 'package:client/widgets/side_navbar.dart';
import 'package:flutter/material.dart';

import 'package:vrouter/vrouter.dart';

class Dashboardpage extends StatefulWidget {
  const Dashboardpage({super.key});

  @override
  State<Dashboardpage> createState() => _DashboardpageState();
}

class _DashboardpageState extends State<Dashboardpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Browse"),
      body: Flex(
        direction: Axis.horizontal,
        children: [
          const Flexible(flex: 1, fit: FlexFit.tight, child: SideNavBar()),
          Flexible(
            flex: 9,
            fit: FlexFit.tight,
            child: Padding(
              padding: EdgeInsets.all(AppTheme.largePadding),
              child: FutureBuilder(
                  future: getChannels(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      dynamic channels = snapshot.data;
                      channels = channels["channels"];
                      return LayoutBuilder(
                          builder: (context, constraints) => GridView.builder(
                                itemCount: channels.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      (constraints.maxWidth / 320).floor(),
                                  mainAxisSpacing: 20,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  Map<String, dynamic> channel =
                                      channels[index];
                                  return ChannelCard(
                                      id: channel["id"],
                                      title: channel["title"],
                                      avatarUrl: channel["avatarUrl"],
                                      username: channel["username"],
                                      isOnline: channel["isOnline"],
                                      onPressed: () {
                                        context.vRouter
                                            .to("/channel/${channel["id"]}");
                                        print(
                                            "Channel ${channel["id"]} pressed");
                                      });
                                },
                              ));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }
}
