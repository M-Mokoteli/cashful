import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/pages/main_views/home_with_bottom_navbar.dart';
import 'package:flutter_application_1/widgets/text_h1.dart';
import 'main.dart';

class LoginScreen extends StatefulWidget {
  static const pageName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  String errorMessage = '';
  bool _obscureText = true;
  late String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Color.fromRGBO(1, 67, 55, 1),
      //   centerTitle: true,
      //   title: new Text(
      //     'Login',
      //     style: TextStyle(
      //         color: Color.fromRGBO(255, 255, 255, 1),
      //         fontFamily: 'Poppins',
      //         fontSize: 25,
      //         letterSpacing: 1.2,
      //         fontWeight: FontWeight.bold,
      //         height: 1),
      //   ),
      // ),
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
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25.0))),
                    child: Form(
                      key: _key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 40.0,
                          ),
                          Text(
                            'Email address',
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
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.left,
                            onChanged: (value) {
                              email = value; // get value from TextField
                            },
                            decoration:
                                InputDecoration(border: UnderlineInputBorder()),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            child: Text(
                              'Password',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                          ),
                          TextFormField(
                            obscureText: _obscureText,
                            textAlign: TextAlign.left,
                            onChanged: (value) {
                              password = value; //get value from textField
                            },
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  color: Colors.grey,
                                  icon: Icon(_obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                                border: UnderlineInputBorder()),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Center(
                              child: Text(
                                errorMessage,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Material(
                            elevation: 1,
                            color: Colors.green[5],
                            borderRadius: BorderRadius.circular(32.0),
                            child: MaterialButton(
                              onPressed: () async {
                                if (_key.currentState!.validate()) {
                                  try {
                                    await _auth
                                        .signInWithEmailAndPassword(
                                            email: email, password: password)
                                        .then((uid) => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeWithBottomNavBar()),
                                            ));
                                  } on FirebaseAuthException {
                                    errorMessage =
                                        'Email and/or password is invalid or does not exist';
                                  }
                                  setState(() {});
                                }
                              },
                              minWidth: double.infinity,
                              height: 45.0,
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateAccountPage()),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account?"),
                                SizedBox(width: 5),
                                Text(
                                  "Sign up",
                                  style: TextStyle(fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                          )
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
  }
}
