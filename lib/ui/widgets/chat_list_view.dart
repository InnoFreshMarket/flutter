import 'dart:convert';

import 'package:fermer/core/utils/token_api.dart';
import 'package:flutter/material.dart';

import 'package:fermer/ui/widgets/chat_page_view.dart';
import 'package:fermer/ui/kit/colors.dart';

import '../../core/auth/server_api.dart';

class ChatListPage extends StatefulWidget {
  final String title;

  const ChatListPage({Key? key, required this.title}) : super(key: key);

  @override
  ChatListPageState createState() => ChatListPageState();
}

class ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8.0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(95.0),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                  hintText: 'Введите имя пользователя...',
                  suffixIcon: const Padding(
                    padding: EdgeInsetsDirectional.only(end: 12.0),
                    child: Icon(
                      Icons.search,
                      size: 30.0,
                    ), // icon is 48px widget.
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                  filled: true),
            ),
          ),
        ),
        leading: const Icon(
          Icons.arrow_back_ios,
          color: CustomColors.black,
        ),
        backgroundColor: CustomColors.white,
        actions: <Widget>[
          // FloatingActionButton(
          //   onPressed: () {},
          //   mini: true,
          //   backgroundColor: Colors.greenAccent[400],
          //   child: const Icon(
          //     Icons.add,
          //     color: Colors.white,
          //     size: 20.0,
          //   ),
          // )
        ],
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: CustomColors.black,
          ),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ChatListView(),
          ],
        ),
      ),
      //   floatingActionButton: FloatingActionButton(
      //     onPressed: () {},
      //     tooltip: 'Increment',
      //     child: const Icon(Icons.add),
      //   ),
    );
  }
}

class ChatListView extends StatefulWidget {
  const ChatListView({super.key});

  @override
  ChatListViewState createState() {
    return ChatListViewState();
  }
}

class ChatListViewState extends State<ChatListView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
          children: <Widget>[
            FutureBuilder(
                future: fetchId(),
                builder: (context, id) {
                  if (id.hasData) {
                    return FutureBuilder(
                        future: fetchData(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                if (snapshot.data![index]['user1'] ==
                                    id.data!) {
                                  return getItem(
                                      context,
                                      snapshot.data![index]["name1"],
                                      snapshot.data![index]["id"],
                                      snapshot.data![index]['user1']
                                  );
                                } else {
                                  return getItem(
                                      context,
                                      snapshot.data![index]["name2"],
                                      snapshot.data![index]["id"],
                                      snapshot.data![index]['user2']
                                  );
                                }
                              },
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                })
            // ListView(
            //   shrinkWrap: true,
            //   children: <Widget>[
            //     ChatListItemWidget(),
            //   ],
            // ),
          ],
        );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
}

ListTile getItem(context, username, chatId, senderId) {
  return ListTile(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatPageView(
                  username: username,
                  chatId: chatId,
                  senderId: senderId,
                )),
      );
    },
    leading: const InkWell(
      child: Hero(
        tag: 'profile_pic',
        child: CircleAvatar(
          radius: 20.0,
          backgroundColor: CustomColors.lightYellow,
        ),
      ),
    ),
    title: Row(
      children: <Widget>[
        Text(username, style: TextStyle(color: CustomColors.black)),
      ],
    ),
  );
}

Future<List<dynamic>> fetchData() async {
  var token = await TokenApi.getAccessToken();
  final response = await ServerApi().get("/users/chats/", token);
  // print(response);
  if (response.statusCode == 201 || response.statusCode == 200) {
    print("success");

    print(response.data['chats']);

    return List<dynamic>.from(response.data['chats']);
  } else {
    throw Exception('Failed to fetch data');
  }
}

Future<dynamic> fetchId() async {
  // final response = await ServerApi().getId();
  // return List<dynamic>.from(response.data['id']);
  var token = await TokenApi.getAccessToken();
  final response = await ServerApi().get("/users/getId/", token);
  // print(response);
  if (response.statusCode == 201 || response.statusCode == 200) {
    print("success");

    print(response.data['id']);

    return response.data['id'];
  } else {
    throw Exception('Failed to fetch data');
  }
}
