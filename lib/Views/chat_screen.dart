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
  Set<int> _visibleTranslations = {}; // Lưu trạng thái mở/ẩn bản dịch

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _toggleTranslation(int index) {
    setState(() {
      if (_visibleTranslations.contains(index)) {
        _visibleTranslations.remove(index);
      } else {
        _visibleTranslations.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      appBar: AppBar(
        title: Text("AIChat Translator"),
        backgroundColor: tdWhite,
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
                      final bool isNhan = message.username == "Chị Nhàn";
                      final bool hasTranslation = state.translations
                          .containsKey(index);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MessageBubble(message: message, isMe: isMe),

                          // 👇 Hiển thị nút "Dịch" ngay cả khi chưa có bản dịch
                          if (isNhan)
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: TextButton(
                                onPressed: () {
                                  if (!hasTranslation) {
                                    // Nếu chưa có bản dịch, gửi sự kiện để dịch
                                    context.read<ChatBloc>().add(
                                      TranslateMessage(index),
                                    );
                                  }
                                  _toggleTranslation(index);
                                },
                                child: Text(
                                  _visibleTranslations.contains(index)
                                      ? "Ẩn bản dịch"
                                      : "Dịch",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),

                          // 👇 Hiển thị bản dịch khi người dùng nhấn "Dịch"
                          if (hasTranslation &&
                              _visibleTranslations.contains(index))
                            Padding(
                              padding: const EdgeInsets.only(left: 15, top: 5),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  state.translations[index]!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
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
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: "Nhập tin nhắn...",
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue),
            onPressed: () {
              if (messageController.text.isNotEmpty) {
                context.read<ChatBloc>().add(
                  SendMessage(widget.username, messageController.text),
                );
                messageController.clear();
              }
            },
          ),
        ],
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
