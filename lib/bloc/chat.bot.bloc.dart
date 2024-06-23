import 'package:chat_app/model/chat.bot.model.dart';
import 'package:chat_app/repository/chat.bot.repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ChatBotEvent {}

class AskLLMEvent extends ChatBotEvent {
  final String query;
  AskLLMEvent({required this.query});
}

abstract class ChatBotState {
  final List<Message> messages;

  ChatBotState({required this.messages});
}

class ChatBotPendingState extends ChatBotState {
  ChatBotPendingState({required List<Message> messages})
      : super(messages: messages);
}

class ChatBotSuccessState extends ChatBotState {
  ChatBotSuccessState({required List<Message> messages})
      : super(messages: messages);
}

class ChatBotErrorState extends ChatBotState {
  final String errorMessage;
  ChatBotErrorState({required super.messages, required this.errorMessage});
}

class ChatBotInitialState extends ChatBotState {
  ChatBotInitialState()
      : super(messages: [
          Message(message: "Hello", type: "user"),
          Message(message: "How can i help you", type: "assistant")
        ]);
}

class ChatBotBloc extends Bloc<ChatBotEvent, ChatBotState> {
  final ChatBotRepository chatBotRepository = ChatBotRepository();
  late ChatBotEvent lastEvent;
  ChatBotBloc() : super(ChatBotInitialState()) {
    on((AskLLMEvent event, emit) async {
      lastEvent = event;
      List<Message> currentMessages = state.messages;
      emit(ChatBotPendingState(messages: state.messages));
      currentMessages.add(Message(message: event.query, type: "user"));
      try {
        Message responseMessage =
            await chatBotRepository.askLargeLangueModelGPT(event.query);
        currentMessages.add(responseMessage);
        emit(ChatBotSuccessState(messages: currentMessages));
      } catch (e) {
        emit(ChatBotErrorState(
            messages: state.messages, errorMessage: e.toString()));
      }
    });
  }
}
