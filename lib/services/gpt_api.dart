import 'dart:convert';

import 'package:http/http.dart' as http;

class ChatGPT {
  String chatUrl = "https://api.openai.com/v1/chat/completions";
  String imageUrl = "https://api.openai.com/v1/images/generations";

  Future<String> getChatAnswer({required String prompt}) async {
    final uri = Uri.parse(chatUrl);
    String answer = "";

    final req = await http.post(
      uri,
      headers: {
     
            "Authorization": " ",
        "Content-Type": "application/json"
      },
      body: json.encode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            "role": "system",
           "content":
                  " انت صيدلاني واسمك ساعد اجب على اي شيء يخص الادويه و الوصفات الدوائيه و الصحه اذا سألت عن اسئله تحتاج استشارة طبيب اخبرهم بأن يستشيرو الطبيب ارهم بعض الصور اذا تطلب الامر",
            },
          {"role": "user", "content": prompt}
        ]
      }),
    );
    final response = json.decode(req.body);
    print(response);
    answer = response["choices"][0]["message"]["content"];
    return answer;
  }

  Future<String> getImageAnswer({required String prompt}) async {
    final uri = Uri.parse(imageUrl);
    String answer = "empty";

    final req = await http.post(
      uri,
      headers: {
      
            "Authorization": " ",
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

