import "dart:convert";

import "package:client/api/index.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:http/http.dart" as http;

void login(String email, String password) async {
  print("login Entered");
  String body = jsonEncode({"email": email, "password": password});

  dynamic res = await http.post(Uri.parse(Api.loginURL),
      body: body, headers: {'Content-Type': 'application/json'});
  print(res.body);
  Map<String, dynamic> resBodyJson = jsonDecode(res.body);
  print(resBodyJson);
  resBodyJson = resBodyJson["userDetails"];
  print(resBodyJson);

  FlutterSecureStorage storage = const FlutterSecureStorage();
  for (dynamic i in resBodyJson.entries) {
    print("${i.key}: ${i.value}");
    await storage.write(key: "${i.key}", value: "${i.value}");
  }
}
