import 'package:fermer/ui/kit/theme.dart';
import 'package:fermer/ui/widgets/chat_list_view.dart';
import 'package:flutter/material.dart';

import 'ui/sreens/fermer.dart';
import 'ui/sreens/login.dart';
import 'ui/sreens/register.dart';
import 'ui/sreens/start.dart';

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
    );
  }
}
