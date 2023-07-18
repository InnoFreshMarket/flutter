import 'dart:convert';

import 'package:fermer/core/auth/server_api.dart';
import 'package:fermer/core/utils/token_api.dart';
import 'package:fermer/ui/kit/colors.dart';
import 'package:fermer/ui/widgets/add_item.dart';
import 'package:fermer/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';

import '../../data/models/item.dart';
import '../widgets/listView.dart';

class FermerPage extends StatefulWidget {
  const FermerPage({super.key});

  @override
  State<FermerPage> createState() => _FermerPageState();
}

class _FermerPageState extends State<FermerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: CustomColors.deepGreen,
          onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return SellProductDialog();
              }),
        ),
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(),
        body: SafeArea(
            child: SafeArea(
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
        ]))));
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
