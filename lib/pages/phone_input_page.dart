import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/pages/otp_ver_page.dart';
import 'package:flutter_application_1/view_models/auth_view_model.dart';
import 'package:flutter_application_1/widgets/text_h1.dart';
import 'package:provider/provider.dart';

class PhoneInputPage extends StatefulWidget {
  static const pageName = "/phoneInput";
  @override
  State<PhoneInputPage> createState() => _PhoneInputPageState();
}

class _PhoneInputPageState extends State<PhoneInputPage> {
  var _key = GlobalKey<FormState>();
  var _phoneNumber = "+27886091234";
  @override
  Widget build(BuildContext context) {
    var authViewModel = Provider.of<AuthViewModel>(context);
    return Consumer<AuthViewModel>(
      builder: (context, authVM, child) {
        if (authVM.authState == AuthState.CodeSent) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // Navigator.pop(context);
            authViewModel.authState = AuthState.Idle;
            Navigator.pushNamed(context, OTPVerificationPage.pageName);
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
                  top: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextH1(
                          title: "Login",
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
                                'Phone number',
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
                                height: 10.0,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.phone,
                                textAlign: TextAlign.left,
                                onChanged: (value) {
                                  _phoneNumber = value;
                                },
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: "+27"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                  'Please include country code and leave no spaces in between your number'),
                              SizedBox(
                                height: 40.0,
                              ),
                              MaterialButton(
                                elevation: 1,
                                color: kPrimaryBlue,
                                textColor: Colors.white,
                                padding: EdgeInsets.all(12.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                onPressed: () {
                                  authViewModel.sendOTP(_phoneNumber);
                                },
                                minWidth: double.infinity,
                                height: 45.0,
                                child: authVM.authState == AuthState.Busy
                                    ? CircularProgressIndicator(
                                        color: Colors.white)
                                    : Text(
                                        "Get OTP",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20.0),
                                      ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              // GestureDetector(
                              //   onTap: () {
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => MyHomePage()),
                              //     );
                              //   },
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Text("Don't have an account?"),
                              //       SizedBox(width: 5),
                              //       Text(
                              //         "Sign up",
                              //         style: TextStyle(fontWeight: FontWeight.w900),
                              //       ),
                              //     ],
                              //   ),
                              // )
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
      },
    );
  }
}
