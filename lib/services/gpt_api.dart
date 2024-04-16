import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ChatGPT {
  String chatUrl = "https://api.openai.com/v1/chat/completions";
  String imageUrl = "https://api.openai.com/v1/images/generations";

  Future<String> getChatAnswer({required String prompt}) async {
    final uri = Uri.parse(chatUrl);
    String answer = "";

    // ignore: unused_local_variable
    final req = await http.post(
      uri,
      headers: {
     
            "Authorization": "Bearer ${dotenv.env['chatGptApiKey']}",
        "Content-Type": "application/json"
      },
      body: json.encode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            "role": "system",
           "content":
                  "أنت طبيب مختص في مجال الأدوية و الصحة، أجب على المستخدم بإجابات مختصرة قدر المستطاع، وإن تم سؤالك على شيء لا يخص مجالك، أجب ب لا يمكنني مساعدتك في هذا الأمر، هل لديك سؤال طبي",
            },
          {"role": "user", "content": prompt}
        ]
      }),
     )
        .then((value) {
      final response = jsonDecode(utf8.decode(value.bodyBytes) );
      answer = response["choices"][0]["message"]["content"];
    });
    return answer;
  }

  Future<String> getImageAnswer({required String prompt}) async {
    final uri = Uri.parse(imageUrl);
    String answer = "empty";

    final req = await http.post(
      uri,
      headers: {
      
            "Authorization": "Bearer ${dotenv.env['chatGptApiKey']}",
        "Content-Type": "application/json"
      },
      body: json.encode({
        "model": "dall-e-2",
        "prompt": prompt,
        "n": 1,
        "size": "1024x1024"
      }),
    );
    final response = json.decode(req.body);
    print(response);
    answer = response["data"][0]["url"];
    return answer;
  }
}

