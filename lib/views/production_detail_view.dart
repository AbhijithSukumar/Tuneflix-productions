// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:production_ui/models/production_detail_model.dart';
import 'package:production_ui/utilities/routes/routes.dart';
import 'package:production_ui/view_models/production_detail_view_model.dart';
import 'package:production_ui/widgets/tuneflix_form_button.dart';
import 'package:production_ui/widgets/tuneflix_form_field.dart';
import 'package:production_ui/widgets/tuneflix_form_label.dart';
import 'package:production_ui/widgets/tuneflix_form_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductionDetailView extends StatefulWidget {
  const ProductionDetailView({super.key});

  @override
  State<ProductionDetailView> createState() => _ProductionDetailViewState();
}

class _ProductionDetailViewState extends State<ProductionDetailView>
    with SingleTickerProviderStateMixin {
  late AnimationController _colorController;
  late Animation<Color?> _colorTween;
  var productionNameController = TextEditingController();
  var registrationController = TextEditingController();
  var companyAddressController = TextEditingController();
  var websiteController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _colorController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _colorTween = ColorTween(begin: Colors.black, end: Colors.green)
        .animate(_colorController);
    _colorController.repeat();

    // Add listener to rebuild the widget when animation value changes
    _colorTween.addListener(_rebuildWidget);
  }

  @override
  void dispose() {
    _colorController.dispose();
    _colorTween.removeListener(_rebuildWidget);
    super.dispose();
  }

  void _rebuildWidget() {
    setState(() {}); // Force rebuild to reflect new color value
  }

  @override
  Widget build(BuildContext context) {
    var productionData = ModalRoute.of(context)?.settings.arguments as Map;
    var productionTempData=productionData["productionData"];
    var productionID=productionTempData["_id"];
    
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
                      formTitle: "Let's get started",
                      titleTopPadding:
                          MediaQuery.of(context).size.height * 0.08),
                  const TuneFlixFormLabel(label: "Company name"),
                  TuneFlixFormField(
                    maximumLines: 1,
                      formController: productionNameController,
                      hint: "Enter company name",
                      validatorFunc: (value) {
                        if (value.isEmpty || value == null) {
                          return "company name required";
                        }
                        return null;
                      },
                      obscureText: false),
                  const TuneFlixFormLabel(label: "Registration ID"),
                  TuneFlixFormField(
                    maximumLines: 1,
                      formController: registrationController,
                      hint: "Enter company registration id",
                      validatorFunc: (value) {
                        if (value.isEmpty || value == null) {
                          return "registration Id required";
                        }
                        return null;
                      },
                      obscureText: false),
                  const TuneFlixFormLabel(label: "Address"),
                  TuneFlixFormField(
                    maximumLines: 1,
                      formController: companyAddressController,
                      hint: "Enter company address",
                      validatorFunc: (value) {
                        if (value.isEmpty || value == null) {
                          return "company address required";
                        }
                        return null;
                      },
                      obscureText: false),
                  const TuneFlixFormLabel(label: "Website"),
                  TuneFlixFormField(
                    maximumLines: 1,
                      formController: websiteController,
                      hint: "Enter company website",
                      validatorFunc: (value) {
                        if (value.isEmpty || value == null) {
                          return "company website required";
                        }
                        return null;
                      },
                      obscureText: false),
                  TuneFlixFormButton(onFormSubmit: () async{
                    final prefs = await SharedPreferences.getInstance();
                    if(formKey.currentState!.validate())
                    {
                      String companyName = productionNameController.text.trim();
                    String regID = registrationController.text.trim();
                    String address = companyAddressController.text.trim();
                    String website = websiteController.text.trim();
                 
                    var production = ProductionDetailModel(
                        companyName: companyName,
                        regID: regID,
                        address: address,
                        website: website,
                        productionID: productionID);

                        productionDetail(production).then((value)async{
                          if(value["status"]==true)
                          {
                            await prefs.setString("productionID", productionID);
                            Navigator.pushNamed(context, Routes.verification);
                          }
                          else
                          {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.green,
                                    title: const Text(
                                      "Company registration failed",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    content: const Text("Server error! try after some time ..",
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
                  }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Center(
                      child: Text(
                        "WELCOME TO TUNEFLIX",
                        style: TextStyle(
                            color: _colorTween.value,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
