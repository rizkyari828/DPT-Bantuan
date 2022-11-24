import 'package:sales/modules/notification/controllers/notification_controller.dart';
import 'package:sales/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationView extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme:
              IconThemeData(color: Colors.black87 //change your color here
                  ),
          centerTitle: false,
          title: Text(
            'Notifikasi',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 20,
              fontFamily: 'Poppins',
            ),
          ),
          backgroundColor: ColorConstants.lightScaffoldBackgroundColor,
          elevation: 0.0,
        ),
        body: Container());
  }


}
