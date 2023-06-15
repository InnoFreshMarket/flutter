import 'dart:convert';

import 'package:fermer/core/auth/server_api.dart';
import 'package:fermer/core/utils/token_api.dart';
import 'package:fermer/ui/kit/colors.dart';
import 'package:fermer/ui/widgets/add_item.dart';
import 'package:fermer/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';

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
        onPressed: () => showDialog(context: context, builder: (BuildContext context) { return SellProductDialog();}),
      ),
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(),
        body: SafeArea(
            child: Column(children: [
          SizedBox(
            height: 300,
            
            child: Text("test")
          )
        ])));
  }
}

Future<List<Map<String, dynamic>>> fetchData() async {
  var token = await TokenApi.getAccessToken();
  final response = await ServerApi().get("/users/items/", token).timeout(Duration(seconds: 3));
  // print(response);
  if (response.statusCode == 201 || response.statusCode == 200) {
    print("success");

    print(response.data['items']);

    return List<Map<String, dynamic>>.from(response.data['items']);
  } else {
    throw Exception('Failed to fetch data');
  }
}
