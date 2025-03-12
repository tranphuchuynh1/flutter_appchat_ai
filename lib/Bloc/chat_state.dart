import 'package:equatable/equatable.dart';
import '../models/message.dart';

abstract class ChatState extends Equatable {
  @override
  List<Object> get props => [];
}

class ChatLoading extends ChatState {}

class ChatInitial extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Message> messages;
  final Map<int, String> translations; // Lưu bản dịch

  ChatLoaded(this.messages, this.translations);

  @override
  List<Object> get props => [messages, translations];
}

class ChatError extends ChatState {
  final String message;

  ChatError(this.message);

  @override
  List<Object> get props => [message];
}
