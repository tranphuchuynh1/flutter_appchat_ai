import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String apiKey = "AIzaSyDC2V4n9e9mwJ9u94RezUhBE2RAtWwJkug";
  static const String baseUrl = "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-pro:generateContent";


  static Future<String> translateResponse(String responseText) async {
    final response = await http.post(
      Uri.parse("$baseUrl?key=$apiKey"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": "Dịch câu sau sang tiếng Việt: $responseText"}
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