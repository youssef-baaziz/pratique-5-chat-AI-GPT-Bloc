import 'package:chat_app/bloc/chat.bot.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  TextEditingController queryController = TextEditingController();
  ScrollController scroller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          BlocBuilder<ChatBotBloc, ChatBotState>(builder: (context, state) {
            if (state is ChatBotPendingState) {
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is ChatBotSuccessState ||
                state is ChatBotInitialState) {
              return Expanded(
                child: ListView.builder(
                  controller: scroller,
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    bool isUser = state.messages[index].type == 'user';
                    return Column(
                      children: [
                        ListTile(
                          trailing:
                              isUser ? Icon(Icons.person_2_rounded) : null,
                          leading: isUser
                              ? null
                              : Icon(Icons.support_agent_outlined),
                          title: Row(
                            children: [
                              SizedBox(
                                width: isUser ? 100 : 0,
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(
                                    state.messages[index].message!,
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: isUser
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  color: isUser ? Colors.teal : Colors.black12,
                                  padding: EdgeInsets.all(10),
                                ),
                              ),
                              SizedBox(
                                width: isUser ? 0 : 100,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        )
                      ],
                    );
                  },
                ),
              );
            } else if (state is ChatBotErrorState) {
              return Expanded(
                child: Column(
                  children: [
                    Text(
                      state.errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          ChatBotBloc chatBotBloc = context.read<ChatBotBloc>();
                          chatBotBloc.add(chatBotBloc.lastEvent);
                        },
                        child: const Text("Retry"))
                  ],
                ),
              );
            } else {
              return Container();
            }
          }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: queryController,
                    decoration: InputDecoration(
                      hintText: "Type something...",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    String query = queryController.text;
                    context.read<ChatBotBloc>().add(AskLLMEvent(query: query));
                    queryController.text = "";
                  },
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
