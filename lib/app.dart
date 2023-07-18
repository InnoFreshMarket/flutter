import 'package:fermer/ui/kit/theme.dart';
import 'package:fermer/ui/sreens/item_page.dart';
import 'package:fermer/ui/widgets/chat_list_view.dart';
import 'package:flutter/material.dart';

import 'ui/sreens/fermer.dart';
import 'ui/sreens/login.dart';
import 'ui/sreens/register.dart';
import 'ui/sreens/client.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomUI().theme,
      title: 'Fresh Market',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => StartPage(),
        '/fermer': (context) => FermerPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/chats': (context) => ChatListPage(title: "Сообщения")
      },
      onGenerateRoute: (routeSettings){
        var settings = routeSettings;
        var path = settings.name?.split('/') ;
        if (path!.length >= 3){
        if(path![1] == 'users' && path[2] == 'item' ){
          return MaterialPageRoute(builder: (context) => ItemPage(id: int.parse(path[3])), settings: RouteSettings(name: settings.name),
);
        } } else {
          return MaterialPageRoute(builder: (context) => StartPage(), settings: RouteSettings(name: settings.name));
        }
      }
    );
  }
}
