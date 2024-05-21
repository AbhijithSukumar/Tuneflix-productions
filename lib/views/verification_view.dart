// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'package:production_ui/ngrok.dart';
import 'package:production_ui/utilities/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({super.key});

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  bool _isVerified = false;
  bool _isLoading = false;
  

  @override
  void initState() {
    super.initState();
    _checkVerificationStatus();
  }

  void _checkVerificationStatus() async {

      final prefs = await SharedPreferences.getInstance();
      final productionID=prefs.getString("productionID");
    try {
      print("hhhhhhhhhhhhhhhhhhhhhhhhhhh $productionID");
      print(productionID);
      final response = await http.post(Uri.parse("${Ngrok.url}/api/production/auth/verify"),body: {"productionID":productionID});

      if (response.statusCode == 200) {
        setState(() {
          _isLoading=true;
        });
        final Map<String, dynamic> data = jsonDecode(response.body);
        _isVerified = data['verified'];

      } else {
        _throwError(response.body);
      }
    } catch (error) {
      _throwError(error.toString());
    } finally {
      if (_isVerified) {
        Future.delayed(const Duration(seconds: 5), _navigateToDashboard(productionID));
        
      } else {
        // Schedule next check with a reasonable delay (replace with desired interval)
        Future.delayed(const Duration(seconds: 2), _checkVerificationStatus);
      }
    }
  }

  dynamic _navigateToDashboard(pid) {
    print(pid);
    Navigator.pushNamed(context, Routes.dashboard,arguments: pid);
  }

  void _throwError(String error) {
    setState(() {
      _isLoading = false;
    });
    // Handle errors appropriately, e.g., display an error message to the user
    print('Error: $error'); // Example error handling
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _isLoading
                  ? Icon(
                      Icons.verified,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.height * 0.1,
                    )
                  : Icon(
                      Icons.search,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.height * 0.1,
                    ),
              _isLoading
                  ? Text(
                      "verified",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          fontStyle: FontStyle.italic),
                    )
                  : Text(
                      "verification in progress",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          fontStyle: FontStyle.italic),
                    ),
              _isLoading?
              LoadingAnimationWidget.threeRotatingDots(
                color: Colors.white,
                size: MediaQuery.of(context).size.height * 0.1,
              ):
              LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.white,
                size: MediaQuery.of(context).size.height * 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
