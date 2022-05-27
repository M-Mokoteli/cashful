import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/configs/size_const.dart';
import 'package:flutter_application_1/models/notification_model.dart' as nm;
import 'package:flutter_application_1/pages/base_view.dart';
import 'package:flutter_application_1/view_models/base_view_model.dart';
import 'package:flutter_application_1/view_models/notifications_view_model.dart';
import 'package:flutter_application_1/widgets/text_h1.dart';
import 'package:intl/intl.dart';

class MessagesScreen extends StatefulWidget {
  @override
  MessagesScreenState createState() => MessagesScreenState();
}

var boldFont = TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w900);

class MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<NotificationViewModel>(onModelReady: (model) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        model.getNotifications();
      });
    }, builder: (context, model, child) {
      return Scaffold(
          body: Stack(
        children: [
          Image.asset("assets/images/notification_wave_bg.png",
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              fit: BoxFit.cover),
          Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  padding: const EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)),
                  child: model.state == ViewState.Idle &&
                          model.notifications != null
                      ? ListView(
                          children: model.notifications
                              .map<Widget>(
                                (nm.Notification notification) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      title: Text(
                                        notification.title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(notification.body),
                                      ),
                                      trailing: Text(DateFormat("dd-MM-yyyy")
                                          .format(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  notification.createdAt!))),
                                      isThreeLine: true,
                                    ),
                                    Divider(
                                      color: Colors.black26,
                                    )
                                  ],
                                ),
                              )
                              .toList(),
                        )
                      : model.state == ViewState.Busy
                          ? Center(
                              child: CircularProgressIndicator(
                                color: kPrimaryBlue,
                              ),
                            )
                          : SizedBox(
                              width: kScreenWidth(context),
                            )),
            ),
          ),
          Positioned(top: 50, left: 20, child: TextH1(title: "Notifications"))
        ],
      ));
    });
  }
}
