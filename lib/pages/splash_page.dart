import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/helper.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/pages/base_view.dart';
import 'package:flutter_application_1/view_models/base_view_model.dart';
import 'package:flutter_application_1/view_models/splash_view_model.dart';

class SplashPage extends StatelessWidget {
  static const pageName = '/splash';
  late final User? user;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BaseView<SplashViewModel>(
        onModelReady: (model) {
          model.getUser();
        },
        builder: (context, model, child) {
          if (model.state == ViewState.Idle && model.errorMessage != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Something went wrong"),
                action: SnackBarAction(
                  label: "try again",
                  onPressed: () {
                    model.getUser();
                  },
                ),
              ));
            });
          } else if (model.state == ViewState.Idle) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              user = model.user;
              AppHelper.checkUserStatAndNavigate(context, user);
            });
          }

          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Image.asset(
                "assets/images/app_logo_with_text.png",
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      );
    });
  }
}
