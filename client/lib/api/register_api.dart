import "dart:convert";

import "package:client/api/index.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:http/http.dart" as http;

void register(String email, String password, String username) async {
  String body =
      jsonEncode({"email": email, "password": password, "username": username});

  dynamic res = await http.post(Uri.parse(Api.registerURL),
      body: body, headers: {'Content-Type': 'application/json'});

  Map<String, dynamic> resBodyJson = jsonDecode(res.body);
  resBodyJson = resBodyJson["userDetails"];
  FlutterSecureStorage storage = const FlutterSecureStorage();
  for (dynamic i in resBodyJson.entries) {
    storage.write(key: "${i.key}", value: "${i.token}");
  }
}
