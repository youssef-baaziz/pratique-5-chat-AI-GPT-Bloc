import 'package:chat_app/pages/chat.page.dart';
import 'package:chat_app/pages/counter.page.dart';
import 'package:chat_app/pages/home.page.dart';
import 'package:chat_app/pages/login.page.dart';
import 'package:flutter/material.dart';

class MyrouteView extends StatelessWidget {
  const MyrouteView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      routes: {
        "/home": (context) => MyHomePage(),
        "/counter": (context) => CounterPage(),
        "/chat": (context) => ChatPage(),
        "/login": (context) => LoginPage(),
      },
      theme: ThemeData(
          textTheme: TextTheme(
              bodyLarge: TextStyle(fontSize: 22, color: Colors.black)),
          indicatorColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal,
            primary: Colors.teal,
          )),
    );
  }
}
