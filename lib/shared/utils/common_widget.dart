import 'package:flutter/material.dart';
import 'package:cleaner/shared/shared.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CommonWidget {
  static AppBar appBar(
      {String title = "",
      bool backIcon = true,
      bool centerTextAlign = false,
      void Function()? callback,
      bool actionIcon = false,
      VoidCallback? onPressedActionIcon}) {
    return AppBar(
      // toolbarHeight: 50,
      automaticallyImplyLeading: backIcon,
      centerTitle: centerTextAlign,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
          fontFamily: 'Poppins',
        ),
      ),
      backgroundColor: ColorConstants.mainColor,
      elevation: 0.0,
      actions: [
        actionIcon == true
            ? IconButton(
                onPressed: onPressedActionIcon,
                tooltip: 'Tambah CnC',
                icon: Icon(Icons.add_box_rounded, size: 20),
              )
            : Container(),
      ],
    );
  }

  static SizedBox rowHeight({double height = 16}) {
    return SizedBox(height: height);
  }

  static SizedBox rowWidth({double width = 30}) {
    return SizedBox(width: width);
  }

  static Text headText({String text = "", Color color = Colors.black87}) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 23,
          fontFamily: 'Poppins'),
    );
  }

  static Text minHeadText({String text = "", Color color = Colors.black87}) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 18,
          fontFamily: 'Poppins'),
    );
  }

  static Text subtitleText(
      {String text = "",
      Color color = Colors.black87,
      FontWeight fontWeight = FontWeight.normal}) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: 13,
          letterSpacing: 0.15,
          fontFamily: 'Poppins'),
    );
  }

  static Text minSubtitleText(
      {String text = "", Color color = Colors.black87,FontWeight fontWeight = FontWeight.normal}) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: 12,
          letterSpacing: 0.15,
          fontFamily: 'Poppins'),
    );
  }

  static Text bodyText({String text = "", Color color = Colors.black87}) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.normal,
          fontSize: 14,
          letterSpacing: 0.5,
          fontFamily: 'Poppins'),
    );
  }

  static Text captionText({String text = "", Color color = Colors.black87}) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.normal,
          fontSize: 10,
          letterSpacing: 0.4,
          fontFamily: 'Poppins'),
    );
  }

  static Row labelExpanded(
      {String label = "", value = "", Color color = Colors.black87}) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: TextStyle(
                color: color,
                fontWeight: FontWeight.normal,
                fontSize: 14,
                letterSpacing: 0.5,
                fontFamily: 'Poppins'),
          ),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.5,
                  fontFamily: 'Poppins')),
        ),
      ],
    );
  }

  static Row widgetExpanded(
      {Widget? left, Widget? right, Color color = Colors.black87}) {
    return Row(
      children: <Widget>[
        Expanded(
          child: left ?? Container(),
        ),
        SizedBox(width: 20),
        Expanded(
          child: right ?? Container(),
        ),
      ],
    );
  }

  static void toast(String error) async {
    await Fluttertoast.showToast(
      msg: error,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  static void errorSnackBar(String error) async {
    Get.snackbar(
      "Informasi",
      error,
      icon: Icon(Icons.warning_rounded, color: Colors.white),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      colorText: Colors.white,
      duration: Duration(seconds: 4),
      isDismissible: true,
      //dismissDirection: SnackDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static Widget cardWithShadow(child) {
    final sw = SizeConfig().screenWidth;
    return Container(
      width: sw,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 20.0,
            spreadRadius: 4.0,
            offset: Offset(
              -10.0,
              10.0,
            ),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: child,
      ),
    );
  }
}
