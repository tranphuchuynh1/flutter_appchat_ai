abstract class ChatEvent {}

class SendMessage extends ChatEvent {
  final String username;
  final String text;

  SendMessage(this.username, this.text);
}

// add 1 event tin nhan tu websocket
class ReceiveMessage extends ChatEvent {
  final String text;

  ReceiveMessage(this.text);
}
