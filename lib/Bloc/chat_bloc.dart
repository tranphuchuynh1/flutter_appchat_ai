import 'package:flutter_bloc/flutter_bloc.dart';
import '../Network/network.dart';
import '../models/message.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatLoaded([], {})) {
    on<SendMessage>(_sendMessage);
    on<TranslateMessage>(_translateMessage);
  }

  final Map<String, String> message_Template = {
    "what are you doing": "I am playing a game",
    "how are you": "I am doing great, thank you!",
    "where are you from": "I am from the internet",
    "who created you": "A smart developer",
    "what is your purpose": "To assist you in chatting",
  };

  Future<void> _sendMessage(SendMessage event, Emitter<ChatState> emit) async {
    final currentState = state;
    if (currentState is ChatLoaded) {
      final List<Message> updatedMessages = List.from(currentState.messages);
      final Map<int, String> translatedMessages = Map.from(
        currentState.translations,
      );

      updatedMessages.add(Message(username: event.username, text: event.text));
      emit(ChatLoaded(updatedMessages, translatedMessages));

      String userMessage = event.text.trim().toLowerCase();

      String botResponse =
          message_Template.containsKey(userMessage)
              ? message_Template[userMessage]!
              : "I don't understand";

      int botMessageIndex = updatedMessages.length;
      updatedMessages.add(Message(username: "Chị Nhàn", text: botResponse));
      emit(ChatLoaded(updatedMessages, translatedMessages));

      // Dịch tin nhắn của bot và lưu vào Map thay vì thêm tin nhắn mới
      String translatedText = await GeminiService.translateResponse(
        botResponse,
      );
      translatedMessages[botMessageIndex] = translatedText;

      emit(ChatLoaded(updatedMessages, translatedMessages));
    }
  }

  Future<void> _translateMessage(
    TranslateMessage event,
    Emitter<ChatState> emit,
  ) async {
    final currentState = state;
    if (currentState is ChatLoaded) {
      final Map<int, String> translatedMessages = Map.from(
        currentState.translations,
      );

      // Kiểm tra nếu chưa có bản dịch, gọi AI Gemini để dịch
      if (!translatedMessages.containsKey(event.index)) {
        String originalText = currentState.messages[event.index].text;
        translatedMessages[event.index] = await GeminiService.translateResponse(
          originalText,
        );
      }

      emit(ChatLoaded(currentState.messages, translatedMessages));
    }
  }
}
