// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:production_ui/ngrok.dart'; // HTTP client with multipart support
// import 'dart:convert'; // For JSON encoding
// import 'dart:io'; // For file handling

// Replace with your actual Express server URL
const String baseUrl = 'https://your-express-server.com';

Future<dynamic> sendPostRequest(
    {required String title,
    required String description,
    required String language,
    required String genre,
    required dynamic selectedFile,
    required String releaseYear,
    required String selectedFilePath,
    required dynamic thumbnail,
    required String productionID
    }) async {
      print("inside main logic");
      print(selectedFilePath);
  // Prepare multipart request data
  final dio = Dio(); // Create a Dio instance
  final formData = FormData.fromMap({
    'title': title,
    'description': description,
    'language': language,
    'genre': genre,
    'releaseYear': releaseYear,
    'productionID':productionID,
    'selectedFile': await MultipartFile.fromFile(selectedFile.path,
        filename: selectedFile.path.split('/').last),
    'thumbnail': await MultipartFile.fromFile(thumbnail.path,
        filename: thumbnail.path.split('/').last)
  });

  if (selectedFilePath == "Video") {
    print("inside video logic");
    Response response = await dio.post(
      '${Ngrok.url}/api/production/upload/video',
      data: formData,
      options: Options(
        headers: {
          "Content-Type": "multipart/form-data",
        },
      ),
    );
    print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $response");
    return response.statusCode;
  }

  if (selectedFilePath == "Audio") {
    print("inside audio logic");
    Response response = await dio.post(
      '${Ngrok.url}/api/production/upload/audio',
      data: formData,
      options: Options(
        headers: {
          "Content-Type": "multipart/form-data",
        },
      ),
    );
    print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $response");
    return response.statusCode;
  }
}
