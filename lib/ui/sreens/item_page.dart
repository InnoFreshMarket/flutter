import 'dart:convert';

import 'package:fermer/core/auth/server_api.dart';
import 'package:fermer/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';

import '../../core/utils/token_api.dart';
import '../../data/models/item.dart';
import '../../data/models/user.dart';
import '../widgets/item_card.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key, required this.id});

  final int id;

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: SafeArea(
            child: Center(
          child: FutureBuilder(
            future: fetchItem(widget.id),
            builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ItemCard(item: snapshot.data!);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const CircularProgressIndicator();
          }))));
  }
}



Future<Item> fetchItem(int id) async {
  var token = await TokenApi.getAccessToken();
  var response = await ServerApi()
      .get("/users/item/${id}", token)
      .timeout(Duration(seconds: 5));
  if (response.statusCode == 201 || response.statusCode == 200) {
    var item = Item.fromJson(response.data['item']);
    return item;
  } else {
    throw Exception('Failed to fetch data');
  }
}
