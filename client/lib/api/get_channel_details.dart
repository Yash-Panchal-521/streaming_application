import 'dart:convert';

import 'package:client/api/index.dart';
import 'package:client/widgets/custom_snackbar.dart';
import 'package:client/widgets/error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

getChannelDetails(String channelId, BuildContext context) async {
  try {
    var res = await http.get(Uri.parse(Api.channelsURL + channelId));

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
