import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/pages/base_view.dart';
import 'package:flutter_application_1/pages/main_views/account_method.dart';
import 'package:flutter_application_1/view_models/user_view_model.dart';
import 'package:flutter_application_1/widgets/text_h1.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String errorMessage = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String uid;
  late Stream<DocumentSnapshot<Map<String, dynamic>>> db;

  @override
  void initState() {
    super.initState();
    uid = _auth.currentUser!.uid;
    db = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('Profile')
        .doc('Personal details')
        .snapshots();
  }

  var boldFont = TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return BaseView<UserViewModel>(builder: (context, model, child) {
      return Scaffold(
        body: Stack(
          children: [
            Image.asset("assets/images/notification_wave_bg.png",
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                fit: BoxFit.cover),
            Center(
              child: SingleChildScrollView(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  margin:
                      const EdgeInsets.only(left: 30.0, right: 30, top: 100),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text('Account',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Inter'))),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                _settingsListItem(
                                    'First name',
                                    Text(model.user!.firstName,
                                        style: boldFont),
                                    action: () => {}),
                                SizedBox(
                                  height: 20,
                                ),
                                _settingsListItem('Last name',
                                    Text(model.user!.lastName, style: boldFont),
                                    action: () => {}),
                                SizedBox(
                                  height: 20,
                                ),
                                _settingsListItem(
                                  "Phone number",
                                  Text(model.user!.mobileNumber,
                                      style: boldFont),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                _settingsListItem(
                                  'Accounts',
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black,
                                    size: 19.0,
                                  ),
                                  action: () => Navigator.pushNamed(
                                      context, AccountMethod.pageName),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                _settingsListItem("Status",
                                    Text("Verified", style: boldFont)),
                                SizedBox(height: 30),
                                InkWell(
                                    onTap: () async {
                                      await launchUrlString(
                                          "https://www.cashful.me/terms-and-condition");
                                    },
                                    child: Text("Terms and Conditions",
                                        style:
                                            boldFont.copyWith(fontSize: 16))),
                                SizedBox(height: 5),
                                InkWell(
                                    onTap: () async {
                                      await launchUrlString(
                                          "https://www.cashful.me/privacy-policy");
                                    },
                                    child: Text("Privacy policy",
                                        style:
                                            boldFont.copyWith(fontSize: 16))),
                                SizedBox(height: 10),
                                InkWell(
                                    onTap: () async {
                                      try {
                                        await FirebaseAuth.instance.signOut();
                                        errorMessage = '';
                                      } on FirebaseAuthException catch (error) {
                                        errorMessage = error.message!;
                                      }
                                      Navigator.of(context)
                                          .pushReplacementNamed('/signIn');
                                      setState(() {});
                                    },
                                    child: Text("Sign out",
                                        style: boldFont.copyWith(
                                            fontSize: 18,
                                            color: kPrimaryBlue))),
                                SizedBox(height: 20),
                              ],
                            ),
                          )
                        ]),
                  ),
                ),
              ),
            ),
            Positioned(top: 50, left: 20, child: TextH1(title: "Settings"))
          ],
        ),
      );
    });
  }

  Widget _settingsListItem(title, Widget trailing, {action}) {
    return Column(
      children: [
        InkWell(
          onTap: () => action(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), SizedBox(width: 40), trailing],
          ),
        ),
        Divider(color: Colors.black26)
      ],
    );
  }
}
