import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/configs/helper.dart';
import 'package:flutter_application_1/view_models/auth_view_model.dart';
import 'package:flutter_application_1/widgets/text_h1.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class OTPVerificationPage extends StatefulWidget {
  static const pageName = "/ot";
  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  var _key = GlobalKey<FormState>();
  var _otpCode = "777848";

  @override
  Widget build(BuildContext context) {
    var authViewModel = Provider.of<AuthViewModel>(context);
    return Consumer<AuthViewModel>(builder: (context, authVM, _) {
      if (authVM.authState == AuthState.Success) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          AppHelper.checkUserStatAndNavigate(context, authVM.user);
        });
      } else if (authVM.authState == AuthState.Failed) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Invalid code try again")));
          authVM.authState = AuthState.Idle;
        });
      }
      return Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                height: MediaQuery.of(context).size.height,
              ),
              Positioned(
                top: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back,
                              color: Colors.white, size: 40)),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextH1(
                        title: "OTP Verification",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height - 100,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0))),
                      child: Form(
                        key: _key,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 40.0,
                            ),
                            Text(
                              'OTP Code',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                            SizedBox(
                              height: 1.0,
                            ),
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: PinCodeTextField(
                                cursorColor: kPrimaryBlue,
                                onCompleted: (value) {
                                  authViewModel.verifyOTP(_otpCode);
                                },
                                pinTheme: PinTheme(
                                    activeColor: kPrimaryBlue,
                                    inactiveColor: Colors.black38),
                                appContext: context,
                                length: 6,
                                onChanged: (value) {
                                  _otpCode = value;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            MaterialButton(
                              elevation: 1,
                              color: kPrimaryBlue,
                              textColor: Colors.white,
                              padding: EdgeInsets.all(12.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              onPressed: () async {
                                // Navigator.pushNamed(context, routeName)
                                if (_key.currentState!.validate()) {
                                  authViewModel.verifyOTP(_otpCode);
                                }
                              },
                              minWidth: double.infinity,
                              height: 45.0,
                              child: authVM.authState == AuthState.Busy
                                  ? CircularProgressIndicator(
                                      color: Colors.white)
                                  : authVM.authState == AuthState.Success
                                      ? Icon(Icons.check, color: Colors.white)
                                      : Text(
                                          "Validate",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20.0),
                                        ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
