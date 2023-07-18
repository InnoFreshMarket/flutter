import 'dart:convert';

import 'package:fermer/core/auth/server_api.dart';
import 'package:fermer/core/utils/token_api.dart';
import 'package:fermer/data/models/item.dart';
import 'package:fermer/ui/kit/colors.dart';
import 'package:fermer/ui/widgets/app_bar.dart';
import 'package:fermer/ui/widgets/chat_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/main.dart';

import '../widgets/listView.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late Map<Item, int> cart;
  List<Item> fruits = [];
  List<Item> vegetables = [];
  List<Item> other = [];

  @override
  void initState() {
    cart = {};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        drawer: const Drawer(
          child: Column(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Sidebar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              Expanded(
                child: ChatListView(),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.chat),
          backgroundColor: CustomColors.deepGreen,
          // onPressed: () => Navigator.pushNamed(context, "/chats")
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(),
        body: SafeArea(
            child: Column(children: [
          Column(children: [
            SizedBox(
                child: FutureBuilder(
                    future: fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && !snapshot.hasError) {
                        if (snapshot.data!.isEmpty) {
                          return Text("No products");
                        } else {
                          var items = snapshot.data as List<Item>;
                          return Column(children: [
                            Text("Фрукты", style: Theme.of(context).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.bold)),
                            CustomListView(
                                items: items
                                    .where(
                                        (element) => element.category == 'FR')
                                    .toList()),
                            Text("Овощи", style: Theme.of(context).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.bold)),
                            CustomListView(
                                items: items
                                    .where(
                                        (element) => element.category == 'VE')
                                    .toList()),
                            Text("Другое", style: Theme.of(context).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.bold)),
                            CustomListView(
                                items: items
                                    .where(
                                        (element) => element.category == 'OT')
                                    .toList()),
                          ]);
                        }
                      } else
                        return CircularProgressIndicator();
                    }))
          ])
        ])));
  }
}

Future<List<Item>> fetchData() async {
  var token = await TokenApi.getAccessToken();
  final response = await ServerApi()
      .get("/users/items", token)
      .timeout(Duration(seconds: 3));
  if (response.statusCode == 201 || response.statusCode == 200) {
    var items = response.data['items'];
    try {
      List<Item> list = [];
      for (var item in items) {
        list.add(Item.fromJson(item));
      }
      return list;
    } catch (e) {
      print(e);
      throw Exception('Failed to fetch data');
    }
  } else {
    throw Exception('Failed to fetch data');
  }
}
