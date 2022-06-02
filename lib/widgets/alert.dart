import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:permission_handler/permission_handler.dart'
    as permissionHandler;

AlertDialog showPermissionDialog(context) {
  return AlertDialog(
    title: Text("Allow Permissions"),
    content: SizedBox(
      height: MediaQuery.of(context).size.height / 3.5,
      child: Column(
        children: [
          Text("It's looks like you denied the permissions"),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 22,
                width: 22,
                decoration: BoxDecoration(
                    color: kPrimaryBlue,
                    borderRadius: BorderRadius.circular(100)),
                child: Center(
                  child: Text(
                    "1",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Flexible(child: Text("Open settings by clicking below button."))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 22,
                width: 22,
                decoration: BoxDecoration(
                    color: kPrimaryBlue,
                    borderRadius: BorderRadius.circular(100)),
                child: Center(
                  child: Text(
                    "2",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Flexible(
                  child: Text(
                      "Go to permissions and allow all the denied permissions."))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kPrimaryBlue)),
                onPressed: () {
                  permissionHandler.openAppSettings();
                },
                child: Text("Open Settings"),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kPrimaryBlue)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Done"),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
