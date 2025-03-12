import 'package:flutter/material.dart';
import 'package:flutter_appchat_ai/Views/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/chat_bloc.dart';
import '../Bloc/chat_event.dart';
import '../Bloc/chat_state.dart';
import '../models/message.dart';

class ChatScreen extends StatefulWidget {
  final String username;
  ChatScreen({required this.username});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Set<int> _visibleTranslations = {};

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      appBar: AppBar(
        title: Center(
          child: Text("Chat Room", style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoaded) {
                  _scrollToBottom();
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      final bool isMe = message.username == widget.username;
                      final bool isBot = message.username == "Nhàn";

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MessageBubble(message: message, isMe: isMe),
                        ],
                      );
                    },
                  );
                }
                return Center(child: Text("Hãy bắt đầu cuộc trò chuyện ^^"));
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  hintText: "Nhập tin nhắn....",
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (messageController.text.isNotEmpty) {
                  context.read<ChatBloc>().add(SendMessage(widget.username, messageController.text));
                  messageController.clear();
                }
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(Icons.send, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;

  const MessageBubble({required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.username,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isMe ? tdBlueLight : Colors.black,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isMe ? Colors.blue[100] : Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(message.text, style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
