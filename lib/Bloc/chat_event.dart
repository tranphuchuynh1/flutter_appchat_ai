abstract class ChatEvent {}

class SendMessage extends ChatEvent {
  final String username;
  final String text;

  SendMessage(this.username, this.text);
}

class TranslateMessage extends ChatEvent {
  final int index; // Vị trí tin nhắn cần dịch

  TranslateMessage(this.index);
}
