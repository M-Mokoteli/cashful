import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/configs/helper.dart';
import 'package:flutter_application_1/models/bank_detail_model.dart';
import 'package:flutter_application_1/widgets/text_h1.dart';

class AddBankAccountScreen extends StatefulWidget {
  const AddBankAccountScreen({Key? key}) : super(key: key);

  @override
  _AddBankAccountScreenState createState() => _AddBankAccountScreenState();
}

class _AddBankAccountScreenState extends State<AddBankAccountScreen> {
  final TextEditingController bankName = TextEditingController();
  final TextEditingController accountHolder = TextEditingController();
  final TextEditingController accountType = TextEditingController();
  final TextEditingController branchCode = TextEditingController();
  final TextEditingController accountNumber = TextEditingController();
  BankDetail? bankDetail;
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBlue,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextH1(title: "Add bank account"),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            validator: (value) => AppHelper.requiredValidator(value),
                            controller: bankName,
                            decoration: InputDecoration(
                                labelText: 'Bank Name',
                                floatingLabelStyle:
                                    TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                                border: _underlineBorder(),
                                enabledBorder: _underlineBorder(),
                                focusedBorder: _underlineBorder(color: kPrimaryBlue)),
                          ),
                          TextFormField(
                            controller: accountHolder,
                            validator: (value) => AppHelper.requiredValidator(value),
                            decoration: InputDecoration(
                                labelText: 'Account Holder',
                                floatingLabelStyle:
                                    TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                                border: _underlineBorder(),
                                enabledBorder: _underlineBorder(),
                                focusedBorder: _underlineBorder(color: kPrimaryBlue)),
                          ),
                          TextFormField(
                            controller: accountType,
                            validator: (value) => AppHelper.requiredValidator(value),
                            decoration: InputDecoration(
                                labelText: 'Account Type',
                                floatingLabelStyle:
                                    TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                                border: _underlineBorder(),
                                enabledBorder: _underlineBorder(),
                                focusedBorder: _underlineBorder(color: kPrimaryBlue)),
                          ),
                          TextFormField(
                            controller: branchCode,
                            validator: (value) => AppHelper.requiredValidator(value),
                            decoration: InputDecoration(
                                labelText: 'Branch Code',
                                floatingLabelStyle:
                                    TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                                border: _underlineBorder(),
                                enabledBorder: _underlineBorder(),
                                focusedBorder: _underlineBorder(color: kPrimaryBlue)),
                          ),
                          TextFormField(
                            controller: accountNumber,
                            validator: (value) => AppHelper.requiredValidator(value),
                            decoration: InputDecoration(
                                labelText: 'Account Number',
                                floatingLabelStyle:
                                    TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                                border: _underlineBorder(),
                                enabledBorder: _underlineBorder(),
                                focusedBorder: _underlineBorder(color: kPrimaryBlue)),
                          ),
                          SizedBox(height: 40),
                          ElevatedButton(
                            child: Text('Add bank account',
                                style:
                                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                bankDetail = BankDetail(
                                    hodlerName: accountHolder.text,
                                    accountNumber: accountNumber.text,
                                    accountType: accountType.text,
                                    bankName: bankName.text,
                                    bankCode: branchCode.text);
                                Navigator.pop(context, bankDetail);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  UnderlineInputBorder _underlineBorder({Color? color}) {
    return UnderlineInputBorder(borderSide: BorderSide(color: color ?? Colors.black38));
  }
}
