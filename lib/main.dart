import 'package:chat_app/bloc/chat.bot.bloc.dart';
import 'package:chat_app/pages/route.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => ChatBotBloc()),
    ], child: const MyrouteView());
  }
}
