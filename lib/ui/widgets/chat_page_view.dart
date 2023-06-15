import 'package:fermer/core/auth/server_api.dart';
import 'package:fermer/core/utils/token_api.dart';
import 'package:flutter/material.dart';
import 'package:fermer/ui/kit/colors.dart' as colors;
import 'package:fermer/ui/widgets/messages/received_message.dart';
import 'package:fermer/ui/widgets/messages/sent_message.dart';

class ChatPageView extends StatefulWidget {
  final String? username;
  final int? chatId;
  final int? senderId;

  ChatPageView({
    Key? key,
    this.username,
    this.chatId,
    this.senderId
  }) : super(key: key);

  @override
  _ChatPageViewState createState() => _ChatPageViewState();
}

class _ChatPageViewState extends State<ChatPageView> {
  final TextEditingController _text = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  var childList = <Widget>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 65,
                  child: Container(
                    color: colors.CustomColors.lightYellow,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              widget.username ?? "Jimi Cooke",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                            const Text(
                              "online",
                              style: TextStyle(
                                  color: Colors.white60, fontSize: 12),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                          child: Container(
                            height: 55,
                            width: 55,
                            padding: const EdgeInsets.all(0.0),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 5.0,
                                      spreadRadius: -1,
                                      offset: Offset(0.0, 5.0))
                                ]),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                  color: colors.CustomColors.deepYellow,
                                  child: SizedBox(
                                    child: Image.asset(
                                      "assets/images/person1.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 0,
                  color: Colors.black54,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    // decoration: BoxDecoration(
                    //   image: DecorationImage(
                    //       // image: const AssetImage(
                    //       //     "assets/images/chat-background-1.jpg"),
                    //       fit: BoxFit.cover,
                    //       colorFilter: Settings.isDarkMode
                    //           ? ColorFilter.mode(
                    //           Colors.grey[850], BlendMode.hardLight)
                    //           : ColorFilter.linearToSrgbGamma()),
                    // ),
                    child: SingleChildScrollView(
                        controller: _scrollController,
                        // reverse: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            FutureBuilder(
                              future: fetchData(widget.chatId!),
                              builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                        return ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            if (snapshot.data![index]['sender'] == widget.senderId) {
                                              return Align(
                                                    alignment: Alignment(1, 0),
                                                    child: SentMessageWidget(
                                                      content: snapshot.data![index]['text'],
                                                      isImage: false,
                                                    )
                                              );
                                            } else {
                                              return Align(
                                                  alignment: Alignment(1, 0),
                                                  child: ReceivedMessageWidget(
                                                    content: snapshot.data![index]['text'],
                                                    isImage: false,
                                                  )
                                              );
                                            }
                                          }
                                        );
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                              }
                            )
                            ]
                        )
                    )
                  )
                ),
                const Divider(height: 0, color: Colors.black26),
                SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      maxLines: 20,
                      controller: _text,
                      decoration: InputDecoration(
                        suffixIcon: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: () {
                                setState(() {
                                  print(_text.text);
                                  postMessage(_text.text, widget.chatId!);
                                  _text.clear();
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.image),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        border: InputBorder.none,
                        hintText: "enter your message",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



Future<void> postMessage(String text, int chatId) async {
  await TokenApi.refreshTokens();
  var token = await TokenApi.getAccessToken();
  final response = await ServerApi().post(
      "/users/chat/$chatId/post_message",
      token,
      {'text': text}
  );
  print(response);
}



Future<List<dynamic>> fetchData(int chatId) async {
  var token = await TokenApi.getAccessToken();
  final response = await ServerApi().get("/users/chat/$chatId", token);
  // print(response);
  if (response.statusCode == 201 || response.statusCode == 200) {
    print("success");

    print(response.data['messages']);

    return List<dynamic>.from(response.data['messages']);
  } else {
    throw Exception('Failed to fetch data');
  }
}