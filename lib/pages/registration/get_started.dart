import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/configs/locator.dart';
import 'package:flutter_application_1/models/user_model.dart' as UserModel;
import 'package:flutter_application_1/pages/base_view.dart';
import 'package:flutter_application_1/pages/registration/verification.dart';
import 'package:flutter_application_1/view_models/base_view_model.dart';
import 'package:flutter_application_1/view_models/registration/get_started_view_model.dart';
import 'package:flutter_application_1/widgets/text_h1.dart';
import 'package:intl/intl.dart';

class GetStartedPage extends StatefulWidget {
  static const pageName = '/getStarted';
  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

// FirebaseAuth _auth = FirebaseAuth.instance;
// final uid = _auth.currentUser!.uid;

class _GetStartedPageState extends State<GetStartedPage> {
  late final TextEditingController firstName = TextEditingController();
  late final TextEditingController lastName = TextEditingController();
  late final TextEditingController dateOfBirth = TextEditingController();
  late final TextEditingController gender = TextEditingController();
  late final TextEditingController id = TextEditingController();
  late final TextEditingController address = TextEditingController();
  late final TextEditingController mobileNumber = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
  }

  // void uploadPersonalDetails() async {
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(Firebasehe)
  //       .collection('Profile')
  //       .doc('Personal details')
  //       .set({
  //     'First name': firstName.text,
  //     'Last name': lastName.text,
  //     'Gender': gender.text,
  //     'Date of birth': dateOfBirth.text,
  //     'ID': id.text,
  //     'Address': address.text,
  //     'Mobile number': mobileNumber.text
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var viewModel = locator<GetStartedViewModel>();
    return BaseView<GetStartedViewModel>(
        builder: (context, model, child) => Scaffold(
            backgroundColor: kPrimaryBlue,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextH1(title: "Get started"),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20.0))),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 30, horizontal: 30),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(
                                          controller: firstName,
                                          decoration: InputDecoration(
                                              labelText: 'First Name',
                                              floatingLabelStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.bold),
                                              border: _underlineBorder(),
                                              enabledBorder: _underlineBorder(),
                                              focusedBorder: _underlineBorder(
                                                  color: kPrimaryBlue)),
                                          validator: (value) {
                                            if (value == "") {
                                              return "required";
                                            }
                                            return null;
                                          }),
                                      TextFormField(
                                          controller: lastName,
                                          decoration: InputDecoration(
                                              labelText: 'Last Name',
                                              floatingLabelStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.bold),
                                              border: _underlineBorder(),
                                              enabledBorder: _underlineBorder(),
                                              focusedBorder: _underlineBorder(
                                                  color: kPrimaryBlue)),
                                          validator: (value) {
                                            if (value == "") {
                                              return "required";
                                            }
                                            return null;
                                          }),
                                      GestureDetector(
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now().subtract(
                                                Duration(days: 36500)),
                                            lastDate: DateTime.now(),
                                          ).then((value) {
                                            print(value);
                                            var date =
                                                DateFormat.yMd().format(value!);
                                            setState(() {
                                              dateOfBirth.text =
                                                  date.toString();
                                            });
                                          });
                                        },
                                        child: Theme(
                                          data: ThemeData(
                                            disabledColor:
                                                Colors.black.withAlpha(160),
                                          ),
                                          child: TextFormField(
                                              controller: dateOfBirth,
                                              enabled: false,
                                              decoration: InputDecoration(
                                                  labelText: 'Date of birth',
                                                  hintText: 'dd/mm/yyyy',
                                                  floatingLabelStyle: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  hintStyle: TextStyle(
                                                      color: Colors.black),
                                                  border: _underlineBorder(),
                                                  enabledBorder:
                                                      _underlineBorder(),
                                                  focusedBorder:
                                                      _underlineBorder(
                                                          color: kPrimaryBlue)),
                                              validator: (value) {
                                                if (value == "") {
                                                  return "required";
                                                }
                                                return null;
                                              }),
                                        ),
                                      ),
                                      DropdownButtonFormField<String>(
                                          value: "Male",
                                          items: ["Male", "Female"]
                                              .map((e) =>
                                                  DropdownMenuItem<String>(
                                                      child: Text(e), value: e))
                                              .toList(),
                                          onChanged: (value) {
                                            if (value != null) {
                                              gender.text = value;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'Gender',

                                            floatingLabelStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold),
                                            // border: _underlineBorder(),
                                            // enabledBorder: _underlineBorder(),
                                            // focusedBorder: _underlineBorder()
                                          ),
                                          validator: (value) {
                                            if (value == "") {
                                              return "required";
                                            }
                                            return null;
                                          }),
                                      TextFormField(
                                          controller: id,
                                          decoration: InputDecoration(
                                              labelText: 'ID number',
                                              floatingLabelStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.bold),
                                              border: _underlineBorder(),
                                              enabledBorder: _underlineBorder(),
                                              focusedBorder: _underlineBorder(
                                                  color: kPrimaryBlue)),
                                          validator: (value) {
                                            if (value == "") {
                                              return "required";
                                            }
                                            return null;
                                          }),
                                      TextFormField(
                                          controller: address,
                                          decoration: InputDecoration(
                                              labelText: 'Address',
                                              hintText:
                                                  '102 Arnd St, Bloemfontein, Free State',
                                              floatingLabelStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.bold),
                                              border: _underlineBorder(),
                                              enabledBorder: _underlineBorder(),
                                              focusedBorder: _underlineBorder(
                                                  color: kPrimaryBlue)),
                                          validator: (value) {
                                            if (value == "") {
                                              return "required";
                                            }
                                            return null;
                                          }),
                                      TextFormField(
                                          controller: mobileNumber,
                                          decoration: InputDecoration(
                                              labelText: 'Mobile number',
                                              floatingLabelStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.bold),
                                              border: _underlineBorder(),
                                              enabledBorder: _underlineBorder(),
                                              focusedBorder: _underlineBorder(
                                                  color: kPrimaryBlue)),
                                          validator: (value) {
                                            if (value == "") {
                                              return "required";
                                            }
                                            return null;
                                          }),
                                    ],
                                  ),
                                )),
                          ],
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
                if (_formKey.currentState!.validate()) {
                  FirebaseMessaging messageing = FirebaseMessaging.instance;
                  String? token = await messageing.getToken();
                  // print("FCM token: $token");
                  UserModel.User user = UserModel.User(
                      id: FirebaseAuth.instance.currentUser!.uid,
                      firstName: firstName.text,
                      lastName: lastName.text,
                      address: address.text,
                      mobileNumber: mobileNumber.text,
                      fcmToken: token ?? "",
                      dob: dateOfBirth.text);
                  bool registrationStatus = await viewModel.register(user);
                  if (registrationStatus) {
                    Navigator.pushReplacementNamed(
                        context, VerificationPage.pageName);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text("Something went wrong please try again")));
                  }
                }
              },
            )));
  }

  UnderlineInputBorder _underlineBorder({Color? color}) {
    return UnderlineInputBorder(
        borderSide: BorderSide(color: color ?? Colors.black38));
  }
}
