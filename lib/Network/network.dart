import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String apiKey = "AIzaSyD7g46kQEix8Wmz-lE9e9Zi4WsSsuoQAKo";
  static const String baseUrl = "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-pro:generateContent";


  static Future<String> translateResponse(String responseText) async {
    final response = await http.post(
      Uri.parse("$baseUrl?key=$apiKey"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": "Hãy dịch câu sau sang tiếng Việt một cách tự nhiên, ngắn gọn, không giải thích thêm: $responseText"}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["candidates"][0]["content"]["parts"][0]["text"] ?? "Không có bản dịch";
    }
    return "Lỗi dịch ";
  }
}