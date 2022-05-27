import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/configs/locator.dart';
import 'package:flutter_application_1/pages/base_view.dart';
import 'package:flutter_application_1/view_models/base_view_model.dart';
import 'package:flutter_application_1/view_models/verification_view_model.dart';
import 'package:flutter_application_1/widgets/text_h1.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:image_picker/image_picker.dart';

class ReuploadBankStatementPage extends StatefulWidget {
  static const pageName = "/ReuploadBankStatementPage";
  @override
  _ReuploadBankStatementPageState createState() =>
      _ReuploadBankStatementPageState();
}

FirebaseAuth _auth = FirebaseAuth.instance;
final uid = _auth.currentUser!.uid;

class _ReuploadBankStatementPageState extends State<ReuploadBankStatementPage> {
  final imagePicker = ImagePicker();
  String url = '';

  File? file;

  void imageSelectFromCamera() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
      });
    }
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
              children: [
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
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20.0))),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Upload your latest 3 months bank statement.',
                                textAlign: TextAlign.center,
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
                                  'Uploading clear documents can make the approval process faster.',
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
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: Container(
                                child: Text(
                                  'Accepted formats: PDF only',
                                  textAlign: TextAlign.center,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          child: file == null
                                              ? Icon(Icons.upload)
                                              : Flexible(
                                                  child: PDFView(
                                                    filePath: file!.path,
                                                    pageFling: false,
                                                  ),
                                                )),
                                    ],
                                  ),
                                  color: Colors.grey[300],
                                  width: 260,
                                  height: 180,
                                ),
                              ),
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
                                        MaterialStateProperty.all(Colors.white),
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
                                          Icons.document_scanner,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                      Text(
                                        'Upload',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
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
                    content: Text("Please upload your document to continue")));
                return;
              }
              bool result = await viewModel.uploadBankStatement(file!);
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
