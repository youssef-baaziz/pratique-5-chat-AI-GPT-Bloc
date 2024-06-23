import 'package:chat_app/widgets/drawer.header.widget.dart';
import 'package:chat_app/widgets/drawer.item.widget.dart';
import 'package:flutter/material.dart';

class MyCustomDrawer extends StatelessWidget {
  const MyCustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          MyDrawerHeader(),
          MyDrawerItem(
            title: "Home",
            itemIcon: Icon(Icons.home),
            route: "/",
          ),
          Divider(
            height: 1,
            color: Theme.of(context).primaryColor,
          ),
          MyDrawerItem(
            title: "Counter",
            itemIcon: Icon(Icons.person),
            route: "/counter",
          ),
          Divider(
            height: 1,
            color: Theme.of(context).primaryColor,
          ),
          MyDrawerItem(
            title: "Chat Bloc",
            itemIcon: Icon(Icons.chat),
            route: "/chat",
          ),
          Divider(
            height: 1,
            color: Theme.of(context).primaryColor,
          ),
          MyDrawerItem(
            title: "Logout",
            itemIcon: Icon(Icons.login),
            route: "/login",
          ),
          Divider(
            height: 1,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
