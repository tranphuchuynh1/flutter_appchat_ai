import 'package:flutter_bloc/flutter_bloc.dart';
import '../Network/network.dart';
import '../models/message.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatLoaded([])) {
    on<SendMessage>(_sendMessage);
  }

  // tao 1 danh sach message template
  final Map<String, String> message_Template = {
    "what are you doing": "I am playing a game",
    "how are you": "I am doing great, thank you!",
    "where are you from": "I am from the internet",
    "who created you": "A smart developer",
    "what is your purpose": "To assist you in chatting"
  };

  Future<void> _sendMessage(SendMessage event, Emitter<ChatState> emit) async {
    final currentState = state;
    if (currentState is ChatLoaded) {
      final List<Message> updatedMessages = List.from(currentState.messages);

      updatedMessages.add(Message(username: event.username, text: event.text));
      emit(ChatLoaded(List.from(updatedMessages))); // cap nhat ui ngay lap tuc'

      String userMessage = event.text.trim().toLowerCase();

      //  ktr require tu` -> message_Template
      String botResponse = message_Template.containsKey(userMessage)
          ? message_Template[userMessage]!
          : "I don't understand ";

      // them phan hoi` tu username
      updatedMessages.add(Message(username: "Chị Nhàn", text: botResponse));
      emit(ChatLoaded(List.from(updatedMessages))); // cap nhat ui ngay lap tuc'

      // goi gemeni ai de tranlation tin nhan
      String translatedText = await GeminiService.translateResponse(botResponse);

      // them tin nhan vao danh sach dich
      updatedMessages.add(Message(username: "Dịch", text: translatedText));

      // doan. nay` emit de render lai UI
      emit(ChatLoaded(List.from(updatedMessages)));
    }
  }
}
