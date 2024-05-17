import 'package:client/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class SideNavBar extends StatefulWidget {
  final List<Map<String, dynamic>> followedChannels;
  const SideNavBar({super.key, required this.followedChannels});

  @override
  State<SideNavBar> createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colors = theme.colorScheme;
    TextTheme textTheme = theme.textTheme;
    return Container(
      color: colors.scrim.withOpacity(0.3),
      child: Column(
        children: [
          Text(
            "Following channels:",
            style: textTheme.bodyMedium!.copyWith(color: colors.primary, fontWeight: FontWeight.w900),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.followedChannels.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> channel = widget.followedChannels[index];
                return Container(
                  color: index % 2 == 0 ? colors.scrim.withOpacity(0.1) : colors.onPrimary.withOpacity(0.2),
                  padding: EdgeInsets.symmetric(horizontal: AppTheme.smallPadding, vertical: AppTheme.mediumPadding),
                  child: InkWell(
                    onTap: () {
                      context.vRouter.to("/channel/${channel["id"]}");
                    },
                    child: Column(
                      children: [
                        Text(
                          "${channel["username"]}",
                          style: textTheme.bodyMedium!,
                        ),
                        SizedBox(height: AppTheme.smallPadding),
                        Text(
                          channel["isOnline"] ? "Online" : "Offline",
                          style: textTheme.bodyMedium!.copyWith(color: channel["isOnline"] ? Colors.green : Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
