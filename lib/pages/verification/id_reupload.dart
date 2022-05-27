import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/configs/locator.dart';
import 'package:flutter_application_1/pages/base_view.dart';
import 'package:flutter_application_1/view_models/base_view_model.dart';
import 'package:flutter_application_1/view_models/verification_view_model.dart';
import 'package:flutter_application_1/widgets/text_h1.dart';
import 'package:image_picker/image_picker.dart';

class ReuploadIDPage extends StatefulWidget {
  static const pageName = "/reuploadID";
  @override
  _ReuploadIDPageState createState() => _ReuploadIDPageState();
}

// FirebaseAuth _auth = FirebaseAuth.instance;
// final uid = _auth.currentUser!.uid;

class _ReuploadIDPageState extends State<ReuploadIDPage> {
  late final imagePicker = ImagePicker();
  String url = '';

  File? file;
  void imageSelectFromGallery() async {
    final image = await imagePicker.pickImage(
      source: ImageSource.gallery,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 100,
      maxWidth: 5000,
      maxHeight: 5000,
    );

    setState(() {
      file = File(image!.path);
    });
  }

  void imageSelectFromCamera() async {
    final image = await imagePicker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 100,
      maxWidth: 5000,
      maxHeight: 5000,
    );
    setState(() {
      file = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = locator<VerificationViewModel>();
    return BaseView<VerificationViewModel>(builder: (context, model, child) {
      return Scaffold(
          backgroundColor: kPrimaryBlue,
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextH1(title: "Verification"),
                ),
                Expanded(
                  child: Container(
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20.0))),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Container(
                                child: Text(
                                  'Upload your ID card for verification',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Uploading clear documents can make the approval process faster',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(),
                                  ),
                                ),
                                constraints: BoxConstraints(
                                    minHeight: 80,
                                    maxHeight: 100,
                                    maxWidth: 360,
                                    minWidth: 80),
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(254, 255, 224, 1),
                                    borderRadius: BorderRadius.circular(20)),
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Center(
                                child: Container(
                                  child: Text(
                                    'Please ensure all corners of your ID card are visible',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Container(
                                child: DottedBorder(
                                  dashPattern: [2, 5, 3, 4],
                                  color: Colors.black,
                                  strokeWidth: 1,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            child: file == null
                                                ? Icon(Icons.upload)
                                                : Image.file(file!,
                                                    width: 260, height: 180)),
                                      ],
                                    ),
                                    color: Colors.grey[300],
                                    width: 260,
                                    height: 180,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Column(
                                children: [
                                  Text('Other forms of accepted ID:',
                                      textAlign: TextAlign.center),
                                  Text('License',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text('Passport',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: imageSelectFromCamera,
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.camera,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                        Text(
                                          'Camera',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  ElevatedButton(
                                    onPressed: imageSelectFromGallery,
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.folder_open,
                                              color: Colors.grey[500],
                                            )),
                                        Text(
                                          'Gallery',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            elevation: 1,
            child: model.state == ViewState.Busy
                ? CircularProgressIndicator(
                    color: kPrimaryBlue,
                  )
                : Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  ),
            onPressed: () async {
              if (file == null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please upload your ID to continue")));
                return;
              }
              bool result = await viewModel.uploadIdentification(file!);
              if (result) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Color(0xFF1B561D),
                    content: Text("Upload successful")));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Something went wrong while uploading try again")));
              }
            },
          ));
    });
  }
}
