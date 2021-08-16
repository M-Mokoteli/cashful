import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_application_1/registration/verification.dart';

class GetStartedPage extends StatefulWidget {

  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {

  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 67, 55, 1),
        toolbarHeight: 100,
        centerTitle: true,
        title: new Text(
          'Get started',
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 25,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
              height: 1),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Form(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: firstName,
                  decoration: InputDecoration(
                    labelText: 'First name',
                    border: UnderlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: lastName,
                  decoration: InputDecoration(
                    labelText: 'Last name',
                    border: UnderlineInputBorder(),
                  ),
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          elevation: 1,
          child: Icon(
            Icons.arrow_forward,
            color: Colors.black,
          ),
          onPressed: () async {//await collectionReference.add({'First name': firstName.text,'Last name': lastName.text});
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => VerificationPage()));
          }),
    ));
  }
}