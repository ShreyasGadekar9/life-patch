import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String apiKey = "AIzaSyBA1xahidEO2rgOawd_nK87wpIPOARLS8s";

  Future<String> getSolution(String problem) async {
    final url =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-3-flash-preview:generateContent?key=$apiKey";

    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {
                "text":
                "User problem: $problem\nGive a helpful, practical solution in exactly 4 short lines.Do not give extra explanation.Keep language simple and motivating and main thing give in bullet points and use some emoji"
              }
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["candidates"][0]["content"]["parts"][0]["text"];
    } else {
      print("REAL ERROR: ${response.body}");
      return "API Error: ${response.statusCode}";
    }
  } //Solution

  Future<List<dynamic>> getProducts() async {
    final response =
    await http.get(Uri.parse("https://dummyjson.com/products"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["products"];
    } else {
      print("Product API Error: ${response.body}");
      return [];
    }
  } // Products
}