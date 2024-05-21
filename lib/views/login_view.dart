// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:production_ui/models/login_model.dart';
import 'package:production_ui/utilities/routes/routes.dart';
import 'package:production_ui/view_models/login_view_model.dart';
import 'package:production_ui/widgets/tuneflix_form_button.dart';
import 'package:production_ui/widgets/tuneflix_form_field.dart';
import 'package:production_ui/widgets/tuneflix_form_label.dart';
import 'package:production_ui/widgets/tuneflix_form_link.dart';
import 'package:production_ui/widgets/tuneflix_form_title.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?)*$");
    RegExp passwordRegex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Center(
                        child: Icon(
                      Icons.play_circle_filled,
                      size: MediaQuery.of(context).size.width * 0.3,
                      color: Colors.green,
                    )),
                  ),
                  TuneFlixFormTitle(
                    formTitle: "Log into Tuneflix",
                    titleTopPadding: MediaQuery.of(context).size.height * 0.05,
                  ),
                  const TuneFlixFormLabel(label: "Email"),
                  TuneFlixFormField(
                    maximumLines: 1,
                    obscureText: false,
                    formController: emailController,
                    validatorFunc: (value) {
                      if (value.isEmpty || value == null) {
                        return "email is required";
                      }
                      if (!emailRegex.hasMatch(value)) {
                        return "email is not valid";
                      }
                      return null;
                    },
                    hint: "Enter your email",
                  ),
                  const TuneFlixFormLabel(label: "Password"),
                  TuneFlixFormField(
                    maximumLines: 1,
                    obscureText: true,
                    formController: passwordController,
                    validatorFunc: (value) {
                      if (value.isEmpty || value == null) {
                        return "password is required";
                      }
                      if (!passwordRegex.hasMatch(value)) {
                        return "password is weak";
                      }
                      return null;
                    },
                    hint: "Enter your password",
                  ),
                  TuneFlixFormButton(
                    onFormSubmit: () async {
                      if (formKey.currentState!.validate()) {
                        String email = emailController.text.trim();
                        String password = passwordController.text.trim();

                        var loginData =
                            LoginModel(email: email, password: password);
                        productionLogin(loginData).then((value) {
                          if (value["status"] == true) {
                            Map<String, dynamic> data =
                                jsonDecode(value["user"]);
                            print(
                                "op/-------------------------------------${data["productionData"]["isVerified"]}");

                            data["productionData"]["isVerified"]==null
                                ? Navigator.pushNamed(
                                    context, Routes.detailsView,
                                    arguments: jsonDecode(value["user"]))
                                : Navigator.pushNamed(context, Routes.dashboard,
                                    arguments: data["productionData"]["_id"]);
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.green,
                                    title: const Text(
                                      "Login failed",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    content: const Text("invalid credentials",
                                        style: TextStyle(color: Colors.white)),
                                    actions: [
                                      TextButton(
                                        child: const Text('OK',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          }
                        });
                      }
                    },
                  ),
                  // const TuneFlixFormSeperator(),
                  TuneFlixFormLink(
                    linkText: "Not a user ? create an account !",
                    linkFunc: () {
                      Navigator.pushNamed(context, Routes.signupView);
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}
