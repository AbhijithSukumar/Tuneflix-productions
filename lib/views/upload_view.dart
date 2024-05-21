import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:production_ui/utilities/routes/routes.dart';
import 'package:production_ui/view_models/upload_view_model.dart';
import 'package:production_ui/widgets/tuneflix_form_button.dart';
import 'package:production_ui/widgets/tuneflix_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:dio/dio.dart';

class UploadView extends StatefulWidget {
  const UploadView({super.key});

  @override
  State<UploadView> createState() => _UploadViewState();
}

class _UploadViewState extends State<UploadView> {
  File? _selectedVideo;
  File? _selectedAudio;
  XFile? _selectedImage;
  String selectedFileType = "Video";
  int selectedYear = DateTime.now().year;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() => _selectedImage = image);
  }

  Future<void> pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      setState(() {
        _selectedVideo = File(result.files.single.path!);
      });

      // try {
      //   await uploadVideo(
      //       _selectedVideo!, _selectedVideo!.path.split('/').last);
      // } catch (e) {
      //   print(e);
      //   setState(() {
      //     _uploadStatus = "Error uploading video";
      //   });
      // }
    }
  }

  Future<void> pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    print("result              $result");

    if (result != null) {
      setState(() {
        _selectedAudio = File(result.files.single.path!);
      });

      // try {
      //   await uploadVideo(
      //       _selectedVideo!, _selectedVideo!.path.split('/').last);
      // } catch (e) {
      //   print(e);
      //   setState(() {
      //     _uploadStatus = "Error uploading video";
      //   });
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    String productionID=ModalRoute.of(context)?.settings.arguments as String;
    List<String> fileTypes = ["Video", "Audio"];
    List<int> years =
        List.generate(DateTime.now().year - 1900 + 1, (i) => 1900 + i);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02, horizontal: screenWidth * 0.02),
          child: SizedBox(
            height: screenHeight * 0.85,
            width: screenWidth,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    child: Column(
                      children: [
                        const Text("Select your upload file type"),
                        DropdownButton<String>(
                          underline: null,
                          value:
                              selectedFileType, // Track the current selection
                          isExpanded:
                              true, // Optionally expand the menu to full width
                          items: fileTypes.map((String language) {
                            return DropdownMenuItem<String>(
                              value: language,
                              child: Text(
                                language,
                                selectionColor: Colors.white,
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedFileType = newValue as String;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                  SizedBox(
                    height: _selectedImage != null
                        ? screenHeight * 0.32
                        : screenHeight * 0.15,
                    width: screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _selectedImage != null
                            ? Image.file(
                                File(_selectedImage!.path),
                                fit: BoxFit.fill,
                                height: screenHeight * 0.2,
                                width: screenWidth * 0.85,
                              )
                            : const Text('No thumbnail selected'),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.green)),
                          onPressed: _pickImage,
                          child: Text('Select $selectedFileType thumbnail'),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                  TuneFlixFormField(
                    formController: titleController,
                    hint: "Enter $selectedFileType Title",
                    validatorFunc: (value) {
                      if (value.isEmpty || value == null) {
                        return "Title is required";
                      }
                      return null;
                    },
                    obscureText: false,
                    maximumLines: 1,
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                  TuneFlixFormField(
                    formController: descriptionController,
                    hint: "Enter $selectedFileType description",
                    validatorFunc: (value) {
                      if (value.isEmpty || value == null) {
                        return "Description must be atleast 20 words";
                      }
                      return null;
                    },
                    obscureText: false,
                    maximumLines: 5,
                  ),
                  SizedBox(
                    height: screenHeight * 0.2,
                    width: screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_selectedVideo != null)
                          Text("Selected Video: ${_selectedVideo!.path}")
                        else if (_selectedAudio != null)
                          Text("Selected Video: ${_selectedAudio!.path}")
                        else
                          Text('No $selectedFileType selected'),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.green)),
                          onPressed: selectedFileType == "Video"
                              ? pickVideo
                              : pickAudio,
                          child: Text('Select $selectedFileType'),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                  selectedFileType == "Video"
                      ? TuneFlixFormField(
                          formController: languageController,
                          hint: "Enter video Language",
                          validatorFunc: (value) {
                            if (value.isEmpty || value == null) {
                              return "language is required";
                            }
                            return null;
                          },
                          obscureText: false,
                          maximumLines: 1)
                      : const SizedBox(),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                  TuneFlixFormField(
                      formController: genreController,
                      hint: "Enter genre",
                      validatorFunc: (value) {
                        if (value.isEmpty || value == null) {
                          return "genre is required";
                        }
                        return null;
                      },
                      obscureText: false,
                      maximumLines: 1),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    child: Column(
                      children: [
                        const Text("Select release year"),
                        DropdownButton<int>(
                          value: selectedYear,
                          items: years
                              .map((year) => DropdownMenuItem(
                                  value: year, child: Text('$year')))
                              .toList(),
                          onChanged: (int? newYear) {
                            setState(() {
                              selectedYear = newYear!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  TuneFlixFormButton(onFormSubmit: () async{
                    if (formKey.currentState!.validate()) {
                      String title = titleController.text.trim();
                      String description = descriptionController.text.trim();
                      String language = languageController.text.trim();
                      String genre = genreController.text.trim();
                      dynamic thumbnail = _selectedImage;
                      String releaseYear = selectedYear.toString();
                      dynamic selectedFile = selectedFileType == "Video"
                          ? _selectedVideo
                          : _selectedAudio;

                      sendPostRequest(
                              selectedFilePath: selectedFileType,
                              title: title,
                              description: description,
                              language: language,
                              genre: genre,
                              selectedFile: selectedFile,
                              releaseYear: releaseYear,
                              productionID: productionID,
                              thumbnail: thumbnail)
                          .then((value) {
                        if (value == 200) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.green,
                                  title: Text(
                                    "Tuneflix $selectedFileType team response",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  content: Text(
                                      "$selectedFileType uploaded successfully",
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  actions: [
                                    TextButton(
                                      child: const Text('OK',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, Routes.dashboard,arguments: productionID);
                                      },
                                    ),
                                  ],
                                );
                              });
                        }
                      });
                    }
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
