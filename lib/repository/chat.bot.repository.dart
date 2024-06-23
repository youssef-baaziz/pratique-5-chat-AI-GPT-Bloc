import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chat_app/model/chat.bot.model.dart';

class ChatBotRepository {
  Future<Message> askLargeLangueModelGPT(String query) async {
    var openAiUrl =
        "https://api.mistral.ai/v1/chat/completions"; // Add https:// to the URL
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "" // Ensure this is the correct API key
    };
    var prompt = {
      "model": "mistral-large-latest",
      "messages": [
        {"role": "user", "content": query}
      ],
      "temperature": 0.6,
    };

    try {
      http.Response response = await http.post(Uri.parse(openAiUrl),
          headers: headers, body: json.encode(prompt));
      if (response.statusCode == 200) {
        Map<String, dynamic> result = jsonDecode(response.body);
        if (result['choices'] != null && result['choices'].isNotEmpty) {
          Message message = Message(
              message: result['choices'][0]['message']['content'],
              type: "assistant");
          return message;
        } else {
          throw ("No message choices returned from API.");
        }
      } else {
        throw ("Error ${response.statusCode}: ${response.reasonPhrase}");
      }
    } catch (err) {
      throw ("Error => ${err.toString()}");
    }
  }
}
