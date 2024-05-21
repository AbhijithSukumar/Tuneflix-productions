// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:production_ui/models/video_model.dart';
import 'package:http/http.dart' as http;
import 'package:production_ui/ngrok.dart';

class VideoManagemenViewModel extends ChangeNotifier{
  List<VideoModel> _videos=[];

  List<VideoModel> get videos => _videos;
 
  void getVideos(String productionID)async{
     dynamic response=await http.post(
      Uri.parse("${Ngrok.url}/api/production/videos"),body: {"productionID":productionID}
     );

     print(jsonDecode(response.body));
     Map<String,dynamic> responseToMap=jsonDecode(response.body);
     List<dynamic> videoList=responseToMap["videos"];
     List<VideoModel> tempVideos=[];
     for (var data in videoList) {
      var video=VideoModel.fromMap(data);
      print(video.fileName);
      tempVideos.add(video);
     }
     _videos=tempVideos;
     notifyListeners();
  }
}