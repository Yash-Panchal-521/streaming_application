import "dart:convert";
import "package:client/api/index.dart";
import "package:client/routes/app_routes.dart";
import "package:client/widgets/custom_snackbar.dart";
import "package:client/widgets/error_snackbar.dart";
import "package:flutter/material.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:http/http.dart" as http;
import "package:vrouter/vrouter.dart";

void register(String email, String password, String username, BuildContext context) async {
  try {
    String body = jsonEncode({"email": email, "password": password, "username": username});

    dynamic res = await http.post(Uri.parse(Api.registerURL), body: body, headers: {'Content-Type': 'application/json'});

    if (res.statusCode == 200) {
      Map<String, dynamic> resBodyJson = jsonDecode(res.body);
      resBodyJson = resBodyJson["userDetails"];
      FlutterSecureStorage storage = const FlutterSecureStorage();
      for (dynamic i in resBodyJson.entries) {
        await storage.write(key: "${i.key}", value: "${i.value}");
      }
      context.vRouter.to(AppRoutes.dashboard);
    } else {
      customSnackbar(context, res.statusCode, res.body);
    }
  } on Exception catch (e) {
    errorSnackBar(e, context);
  }
}
