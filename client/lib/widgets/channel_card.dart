import "package:flutter/material.dart";

class ChannelCard extends StatefulWidget {
  final String id;
  final String title;
  final String avatarUrl;
  final String username;
  final bool isOnline;
  final VoidCallback onPressed;

  const ChannelCard({
    super.key,
    required this.id,
    required this.title,
    required this.avatarUrl,
    required this.username,
    required this.isOnline,
    required this.onPressed,
  });

  final String defaultURL =
      "data:image/jpeg;base64,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";

  @override
  State<ChannelCard> createState() => _ChannelCardState();
}

class _ChannelCardState extends State<ChannelCard> {
  double scale = 1.0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 200,
      child: InkWell(
        onTap: widget.onPressed,
        onHover: (value) {
          if (value) {
            setState(() {
              scale = 1.1;
            });
          } else {
            setState(() {
              scale = 1.0;
            });
          }
        },
        child: Transform.scale(
          scale: scale,
          child: Column(
            children: [
              Image.network(
                widget.avatarUrl,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    widget.defaultURL,
                    width: 300,
                    height: 180,
                    fit: BoxFit.fitWidth,
                  );
                },
                width: 320,
                height: 180,
                fit: BoxFit.fitWidth,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                  Text(
                    widget.isOnline ? 'Online' : 'Offline',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w900,
                        color: widget.isOnline ? Colors.green : Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
