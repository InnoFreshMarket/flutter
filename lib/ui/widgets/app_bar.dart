import 'package:fermer/core/auth/auth_manager.dart';
import 'package:fermer/core/utils/token_api.dart';
import 'package:fermer/ui/kit/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _CustomAppBarState extends State<CustomAppBar> {
  List<AppBarElement> elements = [
    AppBarElement(
        title: "Заказы", path: "/orders", icon: Icons.shopping_cart_outlined),
    AppBarElement(
        title: "Избранное",
        path: "/favorites",
        icon: Icons.favorite_border_outlined),
    AppBarElement(
        title: "Корзина", path: "/cart", icon: Icons.shopping_basket_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return PreferredSize(
        preferredSize: const Size.fromWidth(100),
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                      Row(children: [
                        Image.asset(
                          'assets/icons/icon.png',
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text("Fresh Market",
                              style: Theme.of(context).textTheme.displayLarge),
                        ),
                      ]),
                      SizedBox(width: screenSize.width / 20),
                      // TODO add controller to search bar
                      SizedBox(
                        width: screenSize.width / 3,
                        child: SearchBar()) ,
                      const Spacer(),
                      for (AppBarElement element in elements)
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(element.icon),
                                  onPressed: () {
                                    Navigator.pushNamed(context, element.path);
                                  },
                                ),
                                Text(element.title),
                              ],
                            ))
                    ]),),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data == true) {
                          return PopupMenuButton(
                            padding: const EdgeInsets.all(0),
                            position: PopupMenuPosition.under,
                            icon: CircleAvatar(
                                backgroundColor: CustomColors.deepGreen,
                                child: FutureBuilder(
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                            snapshot.data![0].toUpperCase(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20));
                                      } else {
                                        return const Text("-",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20));
                                      }
                                    },
                                    future: _getUserName())),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                  value: 1, child: Text("Профиль")),
                              const PopupMenuItem(
                                  value: 2, child: Text("Настройки")),
                              const PopupMenuItem(
                                  value: 3, child: Text("Выйти")),
                            ],
                            onSelected: (value) {
                              if (value == 1) {
                                setState(() {
                                  Navigator.pushNamed(context, "/profile");
                                });
                              } else if (value == 2) {
                                setState(() {
                                  Navigator.pushNamed(context, "/settings");
                                });
                              } else if (value == 3) {
                                setState(() {
                                  AuthorizationManager().logout();
                                  Navigator.pushNamed(context, "/login");
                                });
                              }
                            },
                          );
                        } else {
                          return PopupMenuButton(
                            position: PopupMenuPosition.under,
                            //  offset:
                            //  RelativeRect.fromLTRB(100, 80, 0, 0),
                            icon: const Icon(Icons.login),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                  value: 4, child: Text("Войти")),
                            ],
                            onSelected: (value) {
                              if (value == 4) {
                                setState(() {
                                  Navigator.pushNamed(context, "/login");
                                });
                              }
                            },
                          );
                        }
                      } else {
                        return PopupMenuButton(
                          position: PopupMenuPosition.under,
                          icon: const Icon(Icons.login),
                          itemBuilder: (context) => [
                            const PopupMenuItem(value: 4, child: Text("Войти")),
                          ],
                          onSelected: (value) {
                            if (value == 4) {
                              setState(() {
                                Navigator.pushNamed(context, "/login");
                              });
                            }
                          },
                        );
                      }
                    },
                    future: _isAuthorized(),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

Future<String> _getUserName() async {
  var name = await TokenApi.getName();
  return name;
}

class AppBarElement {
  AppBarElement({required this.title, required this.path, required this.icon});

  final IconData icon;
  final String title;
  final String path;
}

Future<bool> _isAuthorized() async {
  var isAuth = await AuthorizationManager().isAuthorized();
  return isAuth;
}
