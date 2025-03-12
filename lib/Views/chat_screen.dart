import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Chat Room", style: TextStyle(color: Colors.white),)),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoaded) {
                  return ListView.builder(
                    reverse: true,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      final bool isMe = message.username == widget.username;
                      final bool isBot = message.username == "Nhàn";
                      final bool isTranslation = message.username == "Dịch";

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
                                  color: isBot ? Colors.purple : isMe ? Colors.blue : Colors.black,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(top: 2),
                                decoration: BoxDecoration(
                                  color: isMe
                                      ? Colors.blue[100]
                                      : isBot
                                      ? Colors.purple[100]
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      message.text,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    if (isTranslation)
                                      Text(
                                        "📝 ${message.text}",
                                        style: TextStyle(fontSize: 14, color: Colors.black54),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return Center(child: Text("Hãy bắt đầu cuộc trò chuyện ^^"));
              },
            ),
          ),
          Padding(
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
                        border: InputBorder.none, // css an~ duong` vien` dj
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
          ),
        ],
      ),
    );
  }
}
