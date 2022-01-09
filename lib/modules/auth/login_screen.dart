import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/shared/shared.dart';
import 'package:flutter_getx_boilerplate/shared/widgets/button.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController controller = Get.arguments;
  @override
  Widget build(BuildContext context) {
    double scaleWidth = MediaQuery.of(context).size.width / 360;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: scaleWidth * 150),
            // height: 10,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 35.0),
            child: _buildForms(context),
          ),
          Container(
            width: MediaQuery.of(context).size.height,
            height: scaleWidth * 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
              // borderRadius: BorderRadius.circular(15),
              color: ColorConstants.mainColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Container(
              height: scaleWidth * 200,
              child: Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Text("LOGO", style: TextStyle(fontSize: 30)),
                  ),
                  // Image.asset(
                  //   'assets/images/icon_success.png',
                  //   height: MediaQuery.of(context).size.height / 7,
                  //   width: MediaQuery.of(context).size.width / 2.5,
                  //   fit: BoxFit.fill,
                  // ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForms(BuildContext context) {
    return Form(
      key: controller.loginFormKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: CommonWidget.headText(text: "Selamat Datang")),
            CommonWidget.rowHeight(height: 32),
            InputField(
              controller: controller.loginEmailController,
              keyboardType: TextInputType.text,
              placeholder: 'Username',
              validator: (value) {
                if (!Regex.isEmail(value!)) {
                  return 'Email format error.';
                }

                if (value.isEmpty) {
                  return 'Email is required.';
                }
                return null;
              },
            ),
            CommonWidget.rowHeight(),
            InputField(
              controller: controller.loginPasswordController,
              keyboardType: TextInputType.emailAddress,
              placeholder: 'Password',
              password: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password is required.';
                }

                if (value.length < 6 || value.length > 15) {
                  return 'Password should be 6~15 characters';
                }

                return null;
              },
            ),
            TextButton(
              onPressed: () {
                // Navigator.of(context).push(new MaterialPageRoute(
                //     builder: (BuildContext context) => LupaPassword()));
              },
              child: CommonWidget.subtitleText(text: "Lupa Password?"),
            ),
            CommonWidget.rowHeight(height: 32),
            CustomButton(
              buttonText: 'LOGIN',
              width: MediaQuery.of(context).size.width,
              onPressed: () {
                controller.login(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
