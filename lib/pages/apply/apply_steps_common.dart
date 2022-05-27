import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/configs/size_const.dart';

class ApplyStepsCommon extends StatelessWidget {
  final Widget internalWidget;
  final Function? onNext;
  final String? bgImgUrl;
  final bool showBack;

  ApplyStepsCommon(
      {Key? key,
      required this.internalWidget,
      this.onNext,
      this.bgImgUrl,
      this.showBack = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBgLight,
        body: Stack(
          children: [
            Image.asset(
              this.bgImgUrl ?? "assets/images/home_wave_bg.png",
              height: kScreenHeight(context) * 0.4,
              fit: BoxFit.fill,
              width: kScreenWidth(context),
            ),
            if (showBack)
              Positioned(
                  left: 20,
                  top: 50,
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back,
                          size: 40, color: Colors.white))),
            internalWidget
          ],
        ),
        floatingActionButton: this.onNext != null
            ? FloatingActionButton(
                backgroundColor: Colors.white,
                elevation: 1,
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
                onPressed: () => this.onNext!())
            : null);
  }
}
