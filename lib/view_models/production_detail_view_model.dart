// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:production_ui/models/production_detail_model.dart';
import 'package:production_ui/ngrok.dart';

Future<Map<String, dynamic>> productionDetail(
    ProductionDetailModel production) async {
      print("inside");
  var response = await http.post(
      Uri.parse("${Ngrok.url}/api/production/auth/details"),
      body: production.toMap());
  if (response.statusCode == 200) {
    return {"user":jsonDecode( response.body), "status": true};
  }
  return {"status": false};
}
