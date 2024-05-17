import 'dart:convert';

import 'package:client/api/index.dart';
import 'package:client/widgets/custom_snackbar.dart';
import 'package:client/widgets/error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

getFollowedChannels(BuildContext context) async {
  try {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var res = await http.get(Uri.parse(Api.followedChannelURL), headers: {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    });
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      return data;
    } else {
      customSnackbar(context, res.statusCode, res.body);
    }
  } on Exception catch (e) {
    errorSnackBar(e, context);
  }
}
