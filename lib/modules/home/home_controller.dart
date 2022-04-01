import 'dart:async';

import 'package:cleaner/models/request/logout_request.dart';
import 'package:cleaner/models/request/rate/submit_rate_request.dart';
import 'package:cleaner/models/request/update_fcm_profile_request.dart';
import 'package:cleaner/models/response/rate/show_rate_review_response.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:cleaner/api/api.dart';
import 'package:cleaner/models/response/user/users_response.dart';
import 'package:cleaner/modules/home/home.dart';
import 'package:cleaner/routes/app_pages.dart';
import 'package:cleaner/shared/shared.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final ApiRepository apiRepository;
  HomeController({required this.apiRepository});

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  late LatLng myLocation = LatLng(0, 0);

  var currentTab = MainTabs.home.obs;
  var users = Rxn<UsersResponse>();
  var user = Rxn<Datum>();
  List<Marker> markers = <Marker>[];
  Set<Circle> circles = <Circle>{};

  late MainTab mainTab;
  late DiscoverTab discoverTab;
  late TaskListTab taskListTab;
  late MeTab meTab;
  DateTime? selectedDate;
  RxString month =
      DateFormat("MMMM yyyy", "id_ID").format(DateTime.now()).toString().obs;

  RxString name = "".obs;
  RxString simId = "".obs;
  RxString profilePhoto = "".obs;
  RxString placement = "".obs;
  RxString location = "".obs;
  RxString building = "".obs;
  RxString groupName = "".obs;
  RxString groupId = "".obs;
  RxBool showRateDialog = false.obs;

  var showRate = ShowReviewRateData().obs;

  late BuildContext context;

  @override
  void onInit() async {
    super.onInit();
    getReviewRate();
    mainTab = MainTab();
    loadUsers();
    discoverTab = DiscoverTab();
    taskListTab = TaskListTab();
    meTab = MeTab();
    determinePosition();

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    messaging.getToken().then((value) {
      print("token FCM Home ${value}");
      submitToken(value);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.data.containsKey('type')) {
        if (message.data['type'] == 'cnc') {
          Get.toNamed(Routes.CN_C);
        } else if (message.data['type'] == 'izin') {
          Get.toNamed(Routes.IZIN);
        } else if (message.data['type'] == 'cuti') {
          Get.toNamed(Routes.CUTI);
        } else if (message.data['type'] == 'overtime') {
          Get.toNamed(Routes.LEMBUR);
        } else if (message.data['type'] == 'task') {
          Get.toNamed(Routes.HOME);
          // getCurrentIndex(MainTabs.inbox);
          if (groupId.value == '3' || groupId.value == '4') {
            switchTab(1);
          } else {
            switchTab(2);
          }
          // return 1;
        } else {
          Get.toNamed(Routes.HOME);
        }
      }
    });
  }

  void callDialog() {
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await showDialog<String>(
          context: context,
          builder: (BuildContext context) => new RatingDialog(
                initialRating: 1.0,
                // your app's name?
                title: Text(
                  'Berikan Rate',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // encourage your user to leave a high rating?
                message:
                    CommonWidget.subtitleText(text: showRate.value.note ?? ''),
                // your app's logo?
                // image: const FlutterLogo(size: 100),
                submitButtonText: 'Submit',
                commentHint: 'Set your custom comment hint',
                onCancelled: () => print('cancelled'),
                onSubmitted: (response) {
                  submitReview(
                      rate: response.rating.round(), note: response.comment);
                  print(
                      'rating: ${response.rating}, comment: ${response.comment}');
                  // TODO: add your own logic
                  if (response.rating < 3.0) {
                    // send their comments to your email or anywhere you wish
                    // ask the user to contact you instead of leaving a bad review
                  } else {
                    // _rateAndReviewApp();
                  }
                },
              ));
    });
  }

  Future<void> onRefresh() async {
    loadUsers();
  }

  loadUsers() async {
    var prefs = Get.find<SharedPreferences>();
    name.value = prefs.getString('name') ?? "";
    simId.value = prefs.getString('simId') ?? "";
    profilePhoto.value = prefs.getString('profilePhoto') ?? "";
    placement.value = prefs.getString('placement') ?? "";
    location.value = prefs.getString('location') ?? "";
    building.value = prefs.getString('building') ?? "";
    groupName.value = prefs.getString('groupName') ?? "";
    groupId.value = prefs.getString('groupId') ?? "";

    // Get.defaultDialog(title: "Alert", content: _dialog);
  }

  void signout() async {
    await Future.delayed(Duration(milliseconds: 3000));
    var storage = Get.find<SharedPreferences>();
    try {
      if (storage.getString(StorageConstants.token) != null) {
        final res = await apiRepository.logout(LogoutRequest(
          username: storage.getString('simId'),
        ));
        if (res?.message == "Logout Success") {
          storage.clear();

          // NavigatorHelper.popLastScreens(popCount: 1);
          goToLoginPages();
        } else {
          Get.snackbar(
            "Error",
            "Logout Failed",
            icon: Icon(Icons.person, color: Colors.white),
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
          EasyLoading.dismiss();
        }
      } else {
        storage.clear();
        // NavigatorHelper.popLastScreens(popCount: 1);
        goToLoginPages();
      }
    } catch (e) {
      storage.clear();
      // NavigatorHelper.popLastScreens(popCount: 1);
      goToLoginPages();
    }
  }

  void switchTab(index) {
    var tab = _getCurrentTab(index);
    currentTab.value = tab;
  }

  int getCurrentIndex(MainTabs tab) {
    if (groupId.value == '3' || groupId.value == '4') {
      switch (tab) {
        case MainTabs.home:
          return 0;
        case MainTabs.inbox:
          return 1;
        case MainTabs.me:
          return 2;
        default:
          return 0;
      }
    } else {
      switch (tab) {
        case MainTabs.home:
          return 0;
        case MainTabs.discover:
          return 1;
        case MainTabs.inbox:
          return 2;
        case MainTabs.me:
          return 3;
        default:
          return 0;
      }
    }
  }

  MainTabs _getCurrentTab(int index) {
    if (groupId.value == '3' || groupId.value == '4') {
      switch (index) {
        case 0:
          return MainTabs.home;
        case 1:
          return MainTabs.inbox;
        case 2:
          return MainTabs.me;
        default:
          return MainTabs.home;
      }
    } else {
      switch (index) {
        case 0:
          return MainTabs.home;
        case 1:
          return MainTabs.discover;
        case 2:
          return MainTabs.inbox;
        case 3:
          return MainTabs.me;
        default:
          return MainTabs.home;
      }
    }
  }

  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
        "Error",
        "Location services are disabled.",
        icon: Icon(Icons.person, color: Colors.white),
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

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
          "Error",
          "Location permissions are denied",
          icon: Icon(Icons.person, color: Colors.white),
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
        print("Location permissions are denied");
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        "Error",
        "Location permissions are permanently denied, we cannot request permissions.",
        icon: Icon(Icons.person, color: Colors.white),
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
      print(
          "Location permissions are permanently denied, we cannot request permissions.");
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    myLocation = LatLng(position.latitude, position.longitude);
    markers.add(Marker(
        markerId: MarkerId('SomeId'),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: InfoWindow(title: 'My Location')));

    final prefs = Get.find<SharedPreferences>();
    if (prefs.getString('token') != null) {
      prefs.setDouble(StorageConstants.initLatitude, position.latitude);
      prefs.setDouble(StorageConstants.initLongitude, position.longitude);
    }

    EasyLoading.dismiss();
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

  void getReviewRate() async {
    final res = await apiRepository.getRate();
    if (res!.error == false) {
      showRate.value = res.data ?? ShowReviewRateData();
      showRateDialog.value = true;
      callDialog();
      print('need review');
    } else {
      print('Token update failed');
    }
    // listType.addAll(res?.data ?? []);
  }

  void submitReview({int rate = 0, String note = ''}) async {
    final res =
        await apiRepository.submitRate(SubmitRate(rate: rate, note: note));
    if (res!.error == false) {
      EasyLoading.showSuccess('Berhasil disimpan');
      // Get.back();
    } else {
      EasyLoading.showError('Gagal disimpan');
    }
    // listType.addAll(res?.data ?? []);
  }

  void goToLoginPages() {
    Get.offAllNamed(Routes.SPLASH);
  }

  void goToCnCPages() {
    Get.toNamed(Routes.CN_C);
  }

  void goToIzinPages() {
    Get.toNamed(Routes.IZIN);
  }

  void goToLemburPages() {
    Get.toNamed(Routes.LEMBUR);
  }

  void goToCutiPages() {
    Get.toNamed(Routes.CUTI);
  }

  void goToInformationPages() {
    Get.toNamed(Routes.INFORMATION);
  }

  void goToRecapPages() {
    Get.toNamed(Routes.RECAP);
  }

  void goToReliverPages() {
    Get.toNamed(Routes.RELIVER);
  }

  void goToListTadKorlapPages() {
    Get.toNamed(Routes.TASK_LIST_TAD_KORLAP_LIST);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
