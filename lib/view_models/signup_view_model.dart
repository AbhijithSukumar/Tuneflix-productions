// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:production_ui/models/signup_model.dart';
import 'package:production_ui/ngrok.dart';
import 'package:production_ui/utilities/routes/routes.dart';

void productionSignin(SignupModel production,BuildContext context) async{
      await http.post(Uri.parse("${Ngrok.url}/api/production/auth/signup"),body: production.toMap());
      Navigator.pushNamed(context, Routes.loginView);
   }