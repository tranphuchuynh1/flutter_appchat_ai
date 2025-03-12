class Message {
  final String username;
  final String text;

  Message({required this.username, required this.text});


  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      username: json['username'] ?? "Unknown",
      text: json['text'] ?? "",
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "text": text,
    };
  }
}
