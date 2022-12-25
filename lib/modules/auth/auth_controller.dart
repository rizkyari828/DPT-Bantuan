import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:konconeDeDe/api/api.dart';
import 'package:konconeDeDe/models/models.dart';
import 'package:konconeDeDe/routes/app_pages.dart';
import 'package:konconeDeDe/shared/shared.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final ApiRepository apiRepository;
  AuthController({required this.apiRepository});

  // final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();
  bool registerTermsChecked = false;

  final formKey = GlobalKey<FormState>();
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  RxBool isObscured = true.obs;
  // bool get isObscured => _isObscured;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void login(BuildContext context) async {
    AppFocus.unfocus(context);
    if (formKey.currentState!.validate()) {
      final res = await apiRepository.login(
        loginEmailController.text,
        loginPasswordController.text,
        LoginRequest(
          username: loginEmailController.text,
          password: loginPasswordController.text,
        ),
      );

      // print("Bearer " + res!.token.toString());

      final prefs = Get.find<SharedPreferences>();
      prefs.clear();
      if (res?.error == false) {
        if (res?.data?.token != '' || res?.data?.token != null) {
          prefs.setString(StorageConstants.token, res?.data?.token ?? '');
          prefs.setString(StorageConstants.name, res?.data?.nama ?? '');
          prefs.setString(
              StorageConstants.userId, res?.data?.userId.toString() ?? "");
          prefs.setString(
              StorageConstants.username, res?.data?.username.toString() ?? "");
          prefs.setString(StorageConstants.profilePhoto, res?.data?.foto ?? "");
          prefs.setString(
              StorageConstants.groupId, res?.data?.stsUser.toString() ?? "");
          prefs.setString(StorageConstants.idKomandante,
              res?.data?.idKomandante.toString() ?? "");
          prefs.setString(StorageConstants.nameKomandante,
              res?.data?.nameKomandante.toString() ?? "");
          Get.toNamed(Routes.HOME);
        }
      }
    }

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    messaging.getToken().then((value) {
      print("token FCM Home $value");
      submitToken(value);
    });
  }

  void submitToken(token) async {
    // final res = await apiRepository
    //     .updateFcmProfile(UpdateFcmProfileRequest(fcmToken: token));
    // if (res!.error == false) {
    //   print('Token updated');
    // } else {
    //   print('Token update failed');
    // }
    // listType.addAll(res?.data ?? []);
  }

  void toggleVisibility() => isObscured.value == true
      ? isObscured.value = false
      : isObscured.value = true;

  @override
  void onClose() {
    super.onClose();

    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();

    loginEmailController.dispose();
    loginPasswordController.dispose();
  }
}
