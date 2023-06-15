import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fermer/ui/kit/colors.dart' as colors;
import 'package:fermer/ui/widgets/chat_page_view.dart';

class ChatListViewItem extends StatelessWidget {
  final AssetImage image;
  final String name;
  final String lastMessage;
  final String time;
  final bool hasUnreadMessage;
  final int newMessageCount;

  const ChatListViewItem({
    required Key key,
    required this.image,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.hasUnreadMessage,
    required this.newMessageCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // actionPane: SlidableDrawerActionPane(),
      // actionExtentRatio: 0.25,
      // secondaryActions: <Widget>[
      //   IconSlideAction(
      //     caption: 'Archive',
      //     color: Colors.blue,
      //     icon: Icons.archive,
      //     onTap: () {},
      //   ),
      //   IconSlideAction(
      //     caption: 'Share',
      //     color: Colors.indigo,
      //     icon: Icons.share,
      //     onTap: () {},
      //   ),
      // ],
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 10,
                child: ListTile(
                  title: Text(
                    name,
                    style: const TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(
                    lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: image,
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        time,
                        style: const TextStyle(fontSize: 12),
                      ),
                      hasUnreadMessage
                          ? Container(
                              margin: const EdgeInsets.only(top: 5.0),
                              height: 18,
                              width: 18,
                              decoration: const BoxDecoration(
                                  color: colors.CustomColors.lightGreen,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25.0),
                                  )),
                              child: Center(
                                  child: Text(
                                newMessageCount.toString(),
                                style: const TextStyle(fontSize: 11),
                              )),
                            )
                          : const SizedBox()
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPageView(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const Divider(
            endIndent: 12.0,
            indent: 12.0,
            height: 0,
          ),
        ],
      ),
    );
  }
}
