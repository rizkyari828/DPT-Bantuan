import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/shared/shared.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommonWidget {
  static AppBar appBar(
      BuildContext context, String title, IconData? backIcon, Color color,
      {void Function()? callback}) {
    return AppBar(
      toolbarHeight: 50,
      leading: backIcon == null
          ? null
          : IconButton(
              icon: Icon(backIcon, color: color),
              onPressed: () {
                if (callback != null) {
                  callback();
                } else {
                  Navigator.pop(context);
                }
              },
            ),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: color, fontFamily: 'Poppins'),
      ),
      backgroundColor: ColorConstants.mainColor,
      elevation: 0.0,
    );
  }

  static SizedBox rowHeight({double height = 16}) {
    return SizedBox(height: height);
  }

  static SizedBox rowWidth({double width = 30}) {
    return SizedBox(width: width);
  }

  static Text headText({String text = ""}) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 23,
          fontFamily: 'Poppins'),
    );
  }

  static Text subtitleText({String text = ""}) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 15,
          letterSpacing: 0.15,
          fontFamily: 'Poppins'),
    );
  }

  static Text bodyText({String text = ""}) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 16,
          letterSpacing: 0.5,
          fontFamily: 'Poppins'),
    );
  }

  static Text captionText({String text = ""}) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 12,
          letterSpacing: 0.4,
          fontFamily: 'Poppins'),
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
}
