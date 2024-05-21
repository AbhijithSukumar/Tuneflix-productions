import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:production_ui/views/login_view.dart';
import 'package:production_ui/widgets/tuneflix_main_icon.dart';


class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
            duration: 1000,
            splashIconSize:MediaQuery.of(context).size.width*0.9,
            splash:   Center(
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 TuneFlixMainIcon(spacing: MediaQuery.of(context).size.height*0.35,iconColor: Colors.green,textColor: Colors.green,),
                  const Padding(
                   padding:  EdgeInsets.all(10.0),
                   child:  CircularProgressIndicator(
                    color: Colors.green,
                    strokeWidth: 2,
                   ),
                 )
                ],
              ),
            ),
            nextScreen:const LoginView(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.fade,
            backgroundColor: Colors.white);
  }
}