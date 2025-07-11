import 'package:cached_network_image/cached_network_image.dart';
import 'package:calculator/Chat/api/apis.dart';
import 'package:calculator/Chat/models/chat_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    // primary color for ease of repeatation
    final Color primaryColor = Theme.of(context).primaryColor;

    // Card
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * 0.02, vertical: 4),
      color: APIs.themeManager.themeMode == ThemeMode.light
          ? Colors.white
          : Color(0xFF2d2e2e),
      elevation: .6,

      child: InkWell(
        onTap: () {},
        child: ListTile(
          // user profile picture
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(mq.height * 0.3),
            child: CachedNetworkImage(
              width: mq.height * 0.05,
              height: mq.height * 0.05,
              imageUrl: widget.user.image,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  const CircleAvatar(child: Icon(CupertinoIcons.person)),
            ),
          ),

          // user name
          title: Text(widget.user.name, style: TextStyle(color: primaryColor)),

          // last message
          subtitle: Text(
            widget.user.about,
            maxLines: 1,
            style: TextStyle(color: primaryColor.withOpacity(0.5)),
          ),

          // Time
          trailing: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: Colors.greenAccent.shade400,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
