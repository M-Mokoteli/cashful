import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/configs/helper.dart';
import 'package:flutter_application_1/configs/locator.dart';
import 'package:flutter_application_1/models/bank_detail_model.dart';
import 'package:flutter_application_1/models/payment_info_model.dart';
import 'package:flutter_application_1/pages/base_view.dart';
import 'package:flutter_application_1/view_models/base_view_model.dart';
import 'package:flutter_application_1/view_models/payment_methods_view_model.dart';
import 'package:flutter_application_1/view_models/user_view_model.dart';
import 'package:flutter_application_1/widgets/text_h1.dart';
import 'package:provider/provider.dart';

class UpdateBankAccountScreen extends StatefulWidget {
  static const pageName = "updateBankAccount";
  final BankDetail _bankDetail;
  UpdateBankAccountScreen(this._bankDetail, {Key? key}) : super(key: key);

  @override
  _UpdateBankAccountScreenState createState() =>
      _UpdateBankAccountScreenState();
}

class _UpdateBankAccountScreenState extends State<UpdateBankAccountScreen> {
  late final TextEditingController bankName = TextEditingController();
  late final TextEditingController accountHolder = TextEditingController();
  late final TextEditingController accountType = TextEditingController();
  late final TextEditingController branchCode = TextEditingController();
  late final TextEditingController accountNumber = TextEditingController();
  late final BankDetail? bankDetail;
  var _formKey = GlobalKey<FormState>();

  var viewModel = locator<PaymentMethodViewModel>();

  @override
  void initState() {
    bankName.text = widget._bankDetail.bankName;
    accountHolder.text = widget._bankDetail.hodlerName;
    accountType.text = widget._bankDetail.accountType;
    branchCode.text = widget._bankDetail.bankCode;
    accountNumber.text = widget._bankDetail.accountNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<PaymentMethodViewModel>(builder: (context, model, child) {
      return Consumer<UserViewModel>(builder: (context, value, child) {
        return Scaffold(
          backgroundColor: kPrimaryBlue,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextH1(title: "Update bank account"),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20.0))),
                    child: SingleChildScrollView(
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 30, horizontal: 30),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  validator: (value) =>
                                      AppHelper.requiredValidator(value),
                                  controller: bankName,
                                  decoration: InputDecoration(
                                      labelText: 'Bank Name',
                                      floatingLabelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold),
                                      border: _underlineBorder(),
                                      enabledBorder: _underlineBorder(),
                                      focusedBorder: _underlineBorder(
                                          color: kPrimaryBlue)),
                                ),
                                TextFormField(
                                  controller: accountHolder,
                                  validator: (value) =>
                                      AppHelper.requiredValidator(value),
                                  decoration: InputDecoration(
                                      labelText: 'Account Holder',
                                      floatingLabelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold),
                                      border: _underlineBorder(),
                                      enabledBorder: _underlineBorder(),
                                      focusedBorder: _underlineBorder(
                                          color: kPrimaryBlue)),
                                ),
                                TextFormField(
                                  controller: accountType,
                                  validator: (value) =>
                                      AppHelper.requiredValidator(value),
                                  decoration: InputDecoration(
                                      labelText: 'Account Type',
                                      floatingLabelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold),
                                      border: _underlineBorder(),
                                      enabledBorder: _underlineBorder(),
                                      focusedBorder: _underlineBorder(
                                          color: kPrimaryBlue)),
                                ),
                                TextFormField(
                                  controller: branchCode,
                                  validator: (value) =>
                                      AppHelper.requiredValidator(value),
                                  decoration: InputDecoration(
                                      labelText: 'Branch Code',
                                      floatingLabelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold),
                                      border: _underlineBorder(),
                                      enabledBorder: _underlineBorder(),
                                      focusedBorder: _underlineBorder(
                                          color: kPrimaryBlue)),
                                ),
                                TextFormField(
                                  controller: accountNumber,
                                  validator: (value) =>
                                      AppHelper.requiredValidator(value),
                                  decoration: InputDecoration(
                                      labelText: 'Account Number',
                                      floatingLabelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold),
                                      border: _underlineBorder(),
                                      enabledBorder: _underlineBorder(),
                                      focusedBorder: _underlineBorder(
                                          color: kPrimaryBlue)),
                                ),
                                SizedBox(height: 40),
                                ElevatedButton(
                                    child: model.state == ViewState.Busy
                                        ? SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              color: kPrimaryBlue,
                                            ))
                                        : Text('Update details',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins')),
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
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        bankDetail = BankDetail(
                                            hodlerName: accountHolder.text,
                                            accountNumber: accountNumber.text,
                                            accountType: accountType.text,
                                            bankName: bankName.text,
                                            bankCode: branchCode.text);

                                        var result = await viewModel
                                            .updatePaymentInfo(PaymentInfo(
                                                bankDetail: bankDetail));
                                        if (result) {
                                          AppHelper.showSnackBar(
                                              "Update successful", context);
                                        } else {
                                          AppHelper.showSnackBar(
                                              "Update failed, try again.",
                                              context);
                                        }
                                      }
                                    }),
                              ],
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    });
  }

  UnderlineInputBorder _underlineBorder({Color? color}) {
    return UnderlineInputBorder(
        borderSide: BorderSide(color: color ?? Colors.black38));
  }
}
