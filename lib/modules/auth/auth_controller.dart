import 'package:cleaner/models/request/update_fcm_profile_request.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cleaner/api/api.dart';
import 'package:cleaner/models/models.dart';
import 'package:cleaner/routes/app_pages.dart';
import 'package:cleaner/shared/shared.dart';
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
        LoginRequest(
          username: loginEmailController.text,
          password: loginPasswordController.text,
        ),
      );

      print(res);

      print("Bearer " + res!.token);

      final prefs = Get.find<SharedPreferences>();
      prefs.clear();
      if (res.token.isNotEmpty) {
        prefs.setString(StorageConstants.token, res.token);
        prefs.setString(StorageConstants.name, res.data?.name ?? "");
        prefs.setString(StorageConstants.simId, res.data?.simid ?? "");
        prefs.setString(
            StorageConstants.profilePhoto, res.data?.profilePhotoPath ?? "");
        prefs.setString(
            StorageConstants.groupId, res.data?.userType?.id.toString() ?? "");
        prefs.setString(
            StorageConstants.groupName, res.data?.userType?.name ?? "");
        prefs.setString(
            StorageConstants.placement, res.data?.branch?.first.name ?? "");
        Get.toNamed(Routes.HOME);
      }
    }

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    messaging.getToken().then((value) {
      print("token FCM Home $value");
      submitToken(value);
    });
  }

  void submitToken(token) async {
    final res = await apiRepository
        .updateFcmProfile(UpdateFcmProfileRequest(fcmToken: token));
    if (res!.error == false) {
      print('Token updated');
    } else {
      print('Token update failed');
    }
    // listType.addAll(res?.data ?? []);
  }

  void register(BuildContext context) async {
    AppFocus.unfocus(context);
    // if (registerFormKey.currentState!.validate()) {
    //   if (!registerTermsChecked) {
    //     CommonWidget.toast('Please check the terms first.');
    //     return;
    //   }

    //   final res = await apiRepository.register(
    //     RegisterRequest(
    //       email: registerEmailController.text,
    //       password: registerPasswordController.text,
    //     ),
    //   );

    //   final prefs = Get.find<SharedPreferences>();
    //   if (res!.token.isNotEmpty) {
    //     prefs.setString(StorageConstants.token, res.token);
    //     print('Go to Home screen');
    //   }
    // }
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
