import 'dart:convert';

import 'package:fermer/ui/widgets/listView.dart';
import 'package:flutter/material.dart';

import '../../core/auth/server_api.dart';
import '../../core/utils/token_api.dart';
import '../../data/models/item.dart';
import '../../data/models/user.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({super.key, required this.item});

  final Item item;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    var number = 1;

    return Padding(
        padding: EdgeInsets.all(size.width / 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: size.height / 3,
                  width: size.width / 1.2,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.memory(
                          base64Decode(base64.normalize(
                            widget.item.doc,
                          )),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: size.width / 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.item.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge),
                                  Text(
                                      widget.item.subscriptable
                                          ? "✅ Можно оформить подписку"
                                          : "Успей купить пока не разобрали",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall),
                                ],
                              ),
                              FutureBuilder(
                                  builder: (BuildContext context,
                                      AsyncSnapshot<User> snapshot) {
                                    if (snapshot.hasData) {
                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Фермер:"),
                                              Text(snapshot.data!.name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: size.width / 40),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                RatingBarIndicator(
                                                  rating: snapshot.data!.rate,
                                                  itemBuilder:
                                                      (context, index) => Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  itemCount: 5,
                                                  itemSize: 20.0,
                                                  direction: Axis.horizontal,
                                                ),
                                                Text(
                                                    snapshot.data!.rate
                                                        .toStringAsFixed(1),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Цена:"),
                                              Text(
                                                  widget.item.cost_retail
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                            ],
                                          ),
                                        ],
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }
                                    return const CircularProgressIndicator();
                                  },
                                  future: fetchFermer(widget.item.farmer)),
                              Row(
                                children: [
                                  Row(children: [
                                    IconButton(
                                        onPressed: () {
                                          if (number > 0) {
                                            number--;
                                          }
                                        },
                                        icon:
                                            Icon(Icons.remove_circle_outline)),
                                    Text(number.toString()),
                                    IconButton(
                                        onPressed: () {
                                          if (number < widget.item.number) {
                                            number++;
                                          }
                                        },
                                        icon: Icon(Icons.add_circle_outline)),
                                  ]),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width / 40),
                                    child: Column(
                                      children: [
                                        Text('Оптовая скидка:',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(color: Colors.green)),
                                        Text(
                                            '${widget.item.cost_wholesale} для  ${widget.item.number_wholesale}+ ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                      "${number >= widget.item.number_wholesale! ? widget.item.cost_wholesale! * number : widget.item.cost_retail * number}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold)),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        size.width / 20, 0, size.width / 40, 0),
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                            Icons.favorite_border_outlined)),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {},
                                      child: Text("В коризну"))
                                ],
                              )
                            ],
                          ),
                        ),
                      ])),
              Padding(
                padding: EdgeInsets.all(size.width / 40),
                child: SizedBox(
                  height: size.height / 4,
                  width: size.width / 1.2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: size.width / 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Описание:",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(fontWeight: FontWeight.bold)),
                            SizedBox(
                                height: size.height / 5,
                                child: SingleChildScrollView(
                                    child: Text(widget.item.description,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall)))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width / 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Другие продукты этого фермера:",
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(fontWeight: FontWeight.bold)),
                            FutureBuilder(
                                future: otherProduct(widget.item.farmer),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<Item> items = snapshot.data!;
                                    return SizedBox(
                                        height: size.height / 5,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: items.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(context,
                                                      '/users/item/${items[index].id}');
                                                },
                                                child: Card(
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: SizedBox(
                                                            child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                              SizedBox(
                                                                height:
                                                                    size.height /
                                                                        8,
                                                                child: Stack(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    children: [
                                                                      SizedBox(
                                                                        child: Image
                                                                            .memory(
                                                                          base64Decode(
                                                                              base64.normalize(
                                                                            items[index]
                                                                                .doc,
                                                                          )),
                                                                        ),
                                                                      ),
                                                                      IconButton(
                                                                          onPressed:
                                                                              () {},
                                                                          icon: Icon(
                                                                              color: Colors.white,
                                                                              Icons.favorite_border_outlined))
                                                                    ]),
                                                              ),
                                                              Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(items[index]
                                                                            .name),
                                                                        Text(items[index]
                                                                            .cost_retail
                                                                            .toString()),
                                                                      ],
                                                                    ),
                                                                    IconButton(
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .shopping_cart_outlined,
                                                                      ),
                                                                      onPressed:
                                                                          () {},
                                                                    )
                                                                  ])
                                                            ])))),
                                              );
                                            }));
                                  } else if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  }
                                  return const CircularProgressIndicator();
                                })
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]));
  }
}

Future<User> fetchFermer(int id) async {
  var token = await TokenApi.getAccessToken();
  var response = await ServerApi()
      .get("/users/info/${id}", token)
      .timeout(Duration(seconds: 5));
  if (response.statusCode == 201 || response.statusCode == 200) {
    var user = User.fromJson(response.data['info']);
    return user;
  } else {
    throw Exception('Failed to fetch data');
  }
}

Future<List<Item>> otherProduct(int id) async {
  var token = await TokenApi.getAccessToken();
  var response = await ServerApi()
      .get("/users/farmer/${id}", token)
      .timeout(Duration(seconds: 5));
  // print(response);
  if (response.statusCode == 201 || response.statusCode == 200) {
    List<Item> items = [];
    for (var item in response.data['items']) {
      items.add(Item.fromJson(item));
    }
    return items;
  } else {
    throw Exception('Failed to fetch data');
  }
}
