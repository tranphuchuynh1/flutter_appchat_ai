import 'package:equatable/equatable.dart';
import '../models/message.dart';


abstract class ChatState extends Equatable {
  @override
  List<Object> get props => [];
}

class ChatLoading extends ChatState {}

class ChatInitial extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Message> messages; //

  ChatLoaded(this.messages);

  @override
  List<Object> get props => [messages];
}


class ChatError extends ChatState {
  final String message;

  ChatError(this.message);

  @override
  List<Object> get props => [message];
}
