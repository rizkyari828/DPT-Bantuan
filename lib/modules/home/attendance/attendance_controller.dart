import 'dart:async';

import 'package:cleaner/models/request/attendance/submit_attendance.dart';
import 'package:cleaner/models/response/user/user_schedule.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceController extends GetxController {
  final ApiRepository apiRepository;

  AttendanceController({required this.apiRepository});

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  var currentTab = MainTabs.home.obs;
  var users = Rxn<UsersResponse>();
  var user = Rxn<Datum>();
  var markers = <Marker>[].obs;
  var circles = <Circle>[].obs;
  // List<Marker> markers = <Marker>[];
  // Set<Circle> circles = <Circle>{};

  late MainTab mainTab;
  late DiscoverTab discoverTab;
  late TaskListTab taskListTab;
  late MeTab meTab;
  late LatLng myLocation = LatLng(0, 0);
  late UserScheduleResponse userSchedule;

  String? namaLokasi;
  RxBool isClockIn = false.obs;
  RxString timeString = '--:--'.obs;
  RxString timeIn = '--:--'.obs;
  RxString timeOut = '--:--'.obs;
  RxString duration = '--:--'.obs;

  final String currentTime = getSystemTime();

  String name = "";
  String simId = "";

  static String getSystemTime() {
    var now = new DateTime.now();
    return new DateFormat("H:m:s").format(now);
  }

  void submitIn() async {
    var now = new DateTime.now();
    timeIn.value = DateFormat("HH:mm:ss").format(now);
    final res = await apiRepository.submitAttendance(
      AttendanceSubmitRequest(
        latitude: myLocation.latitude.toString(),
        longitude: myLocation.longitude.toString(),
      ),
    );
    if (res!.data != null) {
      EasyLoading.showSuccess('Berhasil Clock In');
    } else {
      EasyLoading.showError('Gagal Clock In');
    }
  }

  void submitOut() async {
    var now = new DateTime.now();
    timeOut.value = DateFormat("HH:mm:ss").format(now);
    final res = await apiRepository.submitAttendance(
      AttendanceSubmitRequest(
        latitude: myLocation.latitude.toString(),
        longitude: myLocation.longitude.toString(),
      ),
    );
    print(res);
    if (res!.data != null) {
      EasyLoading.showSuccess('Berhasil Clock In');
    } else {
      EasyLoading.showError('Gagal Clock In');
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
        infoWindow: InfoWindow(title: 'The title of the marker')));

    final prefs = Get.find<SharedPreferences>();
    if (prefs.getString('token') != null) {
      prefs.setDouble(StorageConstants.initLatitude, position.latitude);
      prefs.setDouble(StorageConstants.initLongitude, position.longitude);
    }

    EasyLoading.dismiss();
  }

  @override
  void onInit() async {
    super.onInit();
    loadUsersLatLang();
    determinePosition();
    mainTab = MainTab();
    discoverTab = DiscoverTab();
    taskListTab = TaskListTab();
    meTab = MeTab();
    getSchedule();
    validateAttandance();
  }

  loadUsersLatLang() async {
    var prefs = Get.find<SharedPreferences>();
    myLocation = LatLng(prefs.getDouble('initLatitude') ?? 0.0,
        prefs.getDouble('initLongitude') ?? 0.0);
  }

  Future<void> onRefresh() async {
    markers.clear();
    determinePosition();
    getSchedule();
    validateAttandance();
  }

  void getSchedule() async {
    final res = await apiRepository.getUserSchedule();
    if (res!.data != null) {
      userSchedule = res;
      if (userSchedule.data?.schedule?.dataUserAttandance?.checkIn != null) {
        DateTime parseDateIn = DateTime.parse(userSchedule
            .data!.schedule!.dataUserAttandance!.checkIn
            .toString());
        timeIn.value = DateFormat("HH:mm:ss", "id_ID").format(parseDateIn);
      }
      if (userSchedule.data?.schedule?.dataUserAttandance?.checkOut != null) {
        DateTime parseDateOut = DateTime.parse(userSchedule
            .data!.schedule!.dataUserAttandance!.checkOut
            .toString());
        DateTime parseDateIn = DateTime.parse(userSchedule
            .data!.schedule!.dataUserAttandance!.checkIn
            .toString());
        timeOut.value = timeOut.value =
            DateFormat("HH:mm:ss", "id_ID").format(parseDateOut);
        duration.value = _printDuration(parseDateOut.difference(parseDateIn));
        // parseDateOut.difference(parseDateIn).inMinutes.toString();

        // duration.value = Duration(minutes: (betweenHour * 60)).toString();

      }

      markers.add(Marker(
          markerId: MarkerId('branch'),
          position: LatLng(userSchedule.data?.branch?.latitude ?? 0.0,
              userSchedule.data?.branch?.longitude ?? 0.0),
          infoWindow: InfoWindow(title: userSchedule.data?.branch?.name)));
    }
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void validateAttandance() async {
    try {
      final res = await apiRepository.validateAttendance(
          myLocation.latitude, myLocation.longitude);
      print(res);
      if (res?.error == false) {
        isClockIn.value = true;
      } else {
        isClockIn.value = false;
      }
    } catch (e) {
      isClockIn.value = false;
    }
  }

  void switchTab(index) {
    var tab = _getCurrentTab(index);
    currentTab.value = tab;
  }

  int getCurrentIndex(MainTabs tab) {
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

  MainTabs _getCurrentTab(int index) {
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

  void goToLoginPages() {
    Get.toNamed(Routes.LOGIN);
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
}
