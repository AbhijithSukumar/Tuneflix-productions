import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:production_ui/ngrok.dart';
import 'package:shared_preferences/shared_preferences.dart';





class AudioPlayerView extends StatefulWidget {
  const AudioPlayerView({super.key});

  @override
  AudioPlayerViewState createState() => AudioPlayerViewState();
}

class AudioPlayerViewState extends State<AudioPlayerView> {
  AudioPlayer _audioPlayer = AudioPlayer();
  String _audioUrl = '${Ngrok.url}'; // Update this with your server URL
  bool _isPlaying = false;
  double _sliderValue = 0.0;
  Duration _duration = Duration();
  Duration _position = Duration();
  
  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        _duration = duration;
      });
    });
    _audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        _position = position;
      });
    });
  }

  Future<void> _play() async {
    final prefs=await SharedPreferences.getInstance();
    String filePath= prefs.getString("filepath") as String;
    await _audioPlayer.play(UrlSource(_audioUrl+filePath));
    setState(() {
      _isPlaying = true;
    });
  }

  Future<void> _pause() async {
    await _audioPlayer.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  Future<void> _forward() async {
    Duration newPosition = _position + Duration(seconds: 10);
    if (newPosition < _duration) {
      await _audioPlayer.seek(newPosition);
    }
  }

  Future<void> _backward() async {
    Duration newPosition = _position - const Duration(seconds: 10);
    if (newPosition > const Duration(seconds: 0)) {
      await _audioPlayer.seek(newPosition);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Audio Player',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            Text(
              '${_position.inSeconds}/${_duration.inSeconds}',
            ),
            SizedBox(height: 20.0),
            Slider(
              value: _position.inSeconds.toDouble(),
              min: 0.0,
              max: _duration.inSeconds.toDouble(),
              onChanged: (double value) {
                setState(() {
                  _sliderValue = value;
                });
              },
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  onPressed: _backward,
                ),
                IconButton(
                  icon: _isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                  onPressed: _isPlaying ? _pause : _play,
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  onPressed: _forward,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
