import 'package:client/theme/theme.dart';
import 'package:client/widgets/channel_card.dart';
import 'package:client/widgets/custom_appbar.dart';
import 'package:client/widgets/side_navbar.dart';
import 'package:flutter/material.dart';

import 'package:vrouter/vrouter.dart';

class Dashboardpage extends StatelessWidget {
  const Dashboardpage({super.key});

  @override
  Widget build(BuildContext context) {
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

    List<Map<String, dynamic>> channels = [
      {"id": "1", "title": "test1", "avatarUrl": null, "username": "test1", "isOnline": false},
      {"id": "2", "title": "test2", "avatarUrl": null, "username": "test2", "isOnline": true},
      {"id": "3", "title": "test3", "avatarUrl": null, "username": "test3", "isOnline": false},
      {"id": "4", "title": "test4", "avatarUrl": null, "username": "test4", "isOnline": true},
      {"id": "5", "title": "test5", "avatarUrl": null, "username": "test5", "isOnline": false},
      {"id": "6", "title": "test6", "avatarUrl": null, "username": "test6", "isOnline": true},
      {"id": "7", "title": "test7", "avatarUrl": null, "username": "test7", "isOnline": false},
      {"id": "8", "title": "test8", "avatarUrl": null, "username": "test8", "isOnline": true},
      {"id": "9", "title": "test9", "avatarUrl": null, "username": "test9", "isOnline": false},
      {"id": "10", "title": "test10", "avatarUrl": null, "username": "test10", "isOnline": true},
    ];

    return Scaffold(
      appBar: customAppBar(context, "Browse"),
      body: Flex(
        direction: Axis.horizontal,
        children: [
          Flexible(flex: 1, fit: FlexFit.tight, child: SideNavBar(followedChannels: followedChannels)),
          Flexible(
            flex: 9,
            fit: FlexFit.tight,
            child: Padding(
              padding: EdgeInsets.all(AppTheme.largePadding),
              child: LayoutBuilder(
                  builder: (context, constraints) => GridView.builder(
                        itemCount: channels.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: (constraints.maxWidth / 320).floor(),
                          mainAxisSpacing: 20,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          Map<String, dynamic> channel = channels[index];
                          return ChannelCard(
                              id: channel["id"],
                              title: channel["title"],
                              avatarUrl: channel["avatarUrl"],
                              username: channel["username"],
                              isOnline: channel["isOnline"],
                              onPressed: () {
                                context.vRouter.to("/channel/${channel["id"]}");
                                print("Channel ${channel["id"]} pressed");
                              });
                        },
                      )),
            ),
          )
        ],
      ),
    );
  }
}
