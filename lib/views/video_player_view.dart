// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:production_ui/ngrok.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';



class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({super.key});

  @override
  VideoPlayerViewState createState() => VideoPlayerViewState();
}

class VideoPlayerViewState extends State<VideoPlayerView> {
  // Replace with your actual API endpoint and video ID
  final String apiEndpoint = Ngrok.url;

  late VideoPlayerController videoController=VideoPlayerController.networkUrl(Uri.parse(""));
  late Future<String> videoUrl;

  @override
  void initState() {
    super.initState();
    videoUrl = _fetchVideoUrl();
  }

  Future<String> _fetchVideoUrl() async {
    final prefs=await SharedPreferences.getInstance();
     String filepath=prefs.getString("filepath") as String;
     print(apiEndpoint+filepath);
    return apiEndpoint+filepath;
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        body: FutureBuilder<String>(
          future: videoUrl,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final videoUrl = snapshot.data;
              // Use Chewie for a pre-built player with API support:
              videoController = VideoPlayerController.networkUrl(
                Uri.parse(videoUrl as String),
                // Add other video player options as needed
              );
              return Chewie(
                controller: ChewieController(
                  videoPlayerController: videoController,
                  aspectRatio: 3 / 2,
                  autoPlay: false,
                  looping: false,
                  fullScreenByDefault: true,
                  // Add other Chewie options as needed
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      );
  }
}
