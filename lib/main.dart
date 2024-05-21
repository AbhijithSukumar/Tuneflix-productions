import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:production_ui/utilities/routes/routes.dart';
import 'package:production_ui/view_models/audio_management_view_model.dart';
import 'package:production_ui/view_models/video_management_view_model.dart';
import 'package:production_ui/views/audio_management_view.dart';
import 'package:production_ui/views/audio_player_view.dart';
import 'package:production_ui/views/dashboard_view.dart';
import 'package:production_ui/views/login_view.dart';
import 'package:production_ui/views/production_detail_view.dart';
import 'package:production_ui/views/signup_view.dart';
import 'package:production_ui/views/splash_view.dart';
import 'package:production_ui/views/upload_view.dart';
import 'package:production_ui/views/verification_view.dart';
import 'package:production_ui/views/video_magement_view.dart';
import 'package:production_ui/views/video_player_view.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create:(context) => VideoManagemenViewModel(),),
      ChangeNotifierProvider(create:(context) => AudioManagemenViewModel(),)
    ],
    child: const Root()));
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashView,
      routes: {
        Routes.splashView:(context) => const SplashView(),
        Routes.loginView:(context) => const LoginView(),
        Routes.signupView:(context) => const SignupView(),
        Routes.detailsView:(context) => const ProductionDetailView(),
        Routes.dashboard:(context) => const DashboardView(),
        Routes.verification:(context) => const VerificationView(),
        Routes.upload:(context) => const UploadView(),
        Routes.videoList:(context) => const VideoManagementView(),
        Routes.videoPlayer:(context) => const VideoPlayerView(),
        Routes.audioList:(context) => const AudioManagementView(),
        Routes.audioPlayer:(context) => const AudioPlayerView()
      },
    );
  }
}

