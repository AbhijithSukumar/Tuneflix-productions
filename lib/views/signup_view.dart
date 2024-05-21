import 'package:flutter/material.dart';
import 'package:production_ui/models/signup_model.dart';
import 'package:production_ui/utilities/routes/routes.dart';
import 'package:production_ui/view_models/signup_view_model.dart';
import 'package:production_ui/widgets/tuneflix_form_button.dart';
import 'package:production_ui/widgets/tuneflix_form_field.dart';
import 'package:production_ui/widgets/tuneflix_form_label.dart';
import 'package:production_ui/widgets/tuneflix_form_link.dart';
import 'package:production_ui/widgets/tuneflix_form_title.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController=TextEditingController();
  var cPasswordController=TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?)*$");
    RegExp passwordRegex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    RegExp mobileRegex = RegExp(r"^\d{10}$");

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   TuneFlixFormTitle(
                    formTitle: "Get your free account",
                    titleTopPadding: MediaQuery.of(context).size.height*0.1,
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
                  const TuneFlixFormLabel(label: "Mobile"),
                  TuneFlixFormField(
                    maximumLines: 1,
                    obscureText: false,
                    formController: phoneController,
                    validatorFunc: (value) {
                      if (value.isEmpty || value == null) {
                        return "email is required";
                      }
                      if (!mobileRegex.hasMatch(value)) {
                        return "mobile number not valid";
                      }
                      return null;
                    },
                    hint: "Enter your mobile number",
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
                  const TuneFlixFormLabel(label: "Cnfirm Password"),
                  TuneFlixFormField(
                    maximumLines: 1,
                    obscureText: true,
                    formController: cPasswordController,
                    validatorFunc: (value) {
                      if (value.isEmpty || value == null) {
                        return "required";
                      }
                      if (passwordController.text!=cPasswordController.text) {
                        return "password is wrong, check again";
                      }
                      return null;
                    },
                    hint: "confirm password",
                  ),
                  TuneFlixFormButton(
                    onFormSubmit: () {
                      if (formKey.currentState!.validate()) {
                        String email=emailController.text.trim();
                        String mobile=phoneController.text.trim();
                        String password=passwordController.text.trim();

                        var production=SignupModel(email: email, mobile: mobile, password: password);
                        productionSignin(production,context);
                      }
                    },
                  ),
                   TuneFlixFormLink(
                      linkText: "Already a user ? login to account !",
                      linkFunc: (){
                        Navigator.pushNamed(context, Routes.loginView);
                      },
                      )
                ],
              ),
            ),
          )),
    );
  }
}
