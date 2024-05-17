import 'dart:convert';

import 'package:client/api/index.dart';
import 'package:client/widgets/custom_snackbar.dart';
import 'package:client/widgets/error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

patchChannelPassword(
    BuildContext context, String password, String newPassword) async {
  try {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var body = jsonEncode({"password": password, "newPassword": newPassword});
    var res = await http.patch(
      Uri.parse(Api.passwordSettingsURL),
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      },
    );
    customSnackbar(context, res.statusCode, res.body);
  } on Exception catch (e) {
    errorSnackBar(e, context);
  }
}
