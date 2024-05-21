// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:production_ui/ngrok.dart';
import 'package:production_ui/utilities/routes/routes.dart';
import 'package:production_ui/view_models/audio_management_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioManagementView extends StatefulWidget {
  const AudioManagementView({super.key});

  @override
  State<AudioManagementView> createState() => _AudioManagementViewState();
}

class _AudioManagementViewState extends State<AudioManagementView> {
  @override
  Widget build(BuildContext context) {
    String productionID=ModalRoute.of(context)?.settings.arguments as String;
  var videoProvider=Provider.of<AudioManagemenViewModel>(context,listen: false);

  videoProvider.getVideos(productionID);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer<AudioManagemenViewModel>(
          builder: (context,data,_) {
            return GridView.count(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.9,
              crossAxisCount: 2,
              children: 
                data.audios.isNotEmpty?
                List.generate(data.audios.length, (index){
                  return InkWell(
                    onTap: ()async{
                      final prefs=await SharedPreferences.getInstance();
                      await prefs.setString("filepath", data.audios[index].fileName);
                      Navigator.pushNamed(context, Routes.audioPlayer);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.5
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              "${Ngrok.url}${data.audios[index].thumbnail}",
                              fit: BoxFit.fill,
                              width: 200,
                              height: 100,
                              ),
                          ),
                          Text(data.audios[index].title,style: const TextStyle(color: Colors.green),),
                          Text(data.audios[index].releaseYear.toString(),style: const TextStyle(color: Colors.green),),
                          Text(data.audios[index].genre,style: const TextStyle(color: Colors.green),),
                        ],
                      ),
                    ),
                  );
                }):[const Text("No audios uploaded")]
            );
          }
        ),
      ),
    );
  }
}