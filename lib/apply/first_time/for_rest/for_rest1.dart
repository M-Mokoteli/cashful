import 'package:flutter/material.dart';

import 'for_rest2.dart';

class ApplyForRest1 extends StatefulWidget {
  const ApplyForRest1({ Key? key }) : super(key: key);

  @override
  _ApplyForRest1State createState() => _ApplyForRest1State();
}

class _ApplyForRest1State extends State<ApplyForRest1> { int _value = 0;
  var myFont = (TextStyle(
      color: Colors.black,
      fontFamily: 'Poppins',
      fontSize: 16,
      fontWeight: FontWeight.bold));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 30,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Color.fromRGBO(1, 67, 55, 1),
        toolbarHeight: 50,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
              margin: EdgeInsets.only(
                left: 20,
                top: 20,
                right: 20,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Text('What is your main source of income?',
                          style: myFont)),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    Radio(
                      activeColor: Colors.black,
                      value: 1,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = (value) as int;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Salary',
                      style: myFont,
                    )
                  ]),
                  Row(children: [
                    Radio(
                        activeColor: Colors.black,
                        value: 2,
                        groupValue: _value,
                        onChanged: (value) {
                          setState(() {
                            _value = (value) as int;
                          });
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Savings', style: myFont)
                  ]),
                  Row(children: [
                    Radio(
                      activeColor: Colors.black,
                      value: 3,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = (value) as int;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Inheritance',
                      style: myFont,
                    )
                  ]),
                  Row(children: [
                    Radio(
                      activeColor: Colors.black,
                      value: 4,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = (value) as int;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Investments',
                      style: myFont,
                    )
                  ]),
                  SizedBox(height: 20),
                  Container(
                      margin: EdgeInsets.only(right: 40),
                      child: Text(
                          'How much is your monthly income?',
                          style: myFont)),
                  SizedBox(width: 4),
                  SizedBox(
                    width: 250,
                  ),
                  Container(width: 270, margin: EdgeInsets.only(right: 18),
                    child: TextField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.all(5),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          )),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Text(
                          "How much are your monthly expenses?",
                          style: myFont)),
                  SizedBox(width: 4),
                  
                  Container(width: 270, margin: EdgeInsets.only(right: 20),
                    child: TextField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.all(5),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          )),
                    ),
                  ),
                  SizedBox(height: 30),
                  
                ],
              ),
            ),
            Container(alignment: Alignment.center, child: Text('2/5'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          elevation: 1,
          child: Icon(
            Icons.arrow_forward,
            color: Colors.black,
          ),
          onPressed: () {Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ApplyForRest2()));}),
    );
  }
}
