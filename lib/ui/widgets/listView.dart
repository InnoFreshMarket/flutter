import 'dart:convert';

import 'package:flutter/material.dart';

import '../../data/models/item.dart';
import '../sreens/item_page.dart';

class CustomListView extends StatefulWidget {
  const CustomListView({super.key, required this.items});

  final List<Item> items;

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
        height: size.height / 4,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap:() {
                  Navigator.pushNamed(context, '/users/item/${widget.items[index].id}');
                },
                child: Card(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                              SizedBox(
                                height: size.height / 6,
                                child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Image.memory(
                                        base64Decode(base64.normalize(
                                          widget.items[index].doc,
                                        )),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                              color: Colors.white,
                                              Icons.favorite_border_outlined))
                                    ]),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.items[index].name),
                                        Text(widget.items[index].cost_retail
                                            .toString()),
                                      ],
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.shopping_cart_outlined,
                                      ),
                                      onPressed: () {},
                                    )
                                  ])
                            ])))),
              );
            }));
  }
}
