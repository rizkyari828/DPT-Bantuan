import 'package:cleaner/api/api_repository.dart';
import 'package:cleaner/models/request/attendance/submit_attendance.dart';
import 'package:cleaner/models/request/overtime/submit_overtime_client_request.dart';
import 'package:cleaner/models/request/overtime/submit_request_overtime.dart';
import 'package:cleaner/models/response/branch_response.dart';
import 'package:cleaner/models/response/name_tad_list_response.dart';
import 'package:cleaner/shared/constants/storage.dart';
import 'package:cleaner/shared/utils/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LemburAddController extends GetxController {
  final ApiRepository apiRepository;
  LemburAddController({required this.apiRepository});

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  String date = "";
  DateTime selectedDate = DateTime.now();
  final noteController = TextEditingController();
  RxString groupName = "".obs;
  RxString groupId = "".obs;
  RxString branchId = "".obs;
  RxString placement = "".obs;
  RxBool isClockIn = true.obs;
  RxString timeString = '--:--'.obs;
  RxString timeIn = '--:--'.obs;
  RxString timeOut = '--:--'.obs;
  late LatLng myLocation = LatLng(0, 0);
  var listTad = <BranchTadListData>[].obs;
  var listBranch = <BranchListData>[].obs;
  RxString idTad = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    loadUsers();
    determinePosition();
    getBranch();
  }

  void getBranchTad(String branchId) async {
    listTad.clear();
    final res = await apiRepository.branchNameTad(branchId: branchId);
    listTad.addAll(res?.data ?? []);
    EasyLoading.dismiss();
  }

  void getBranch() async {
    final res = await apiRepository.branchList();
    listBranch.addAll(res?.data ?? []);
  }

  void submitIn() async {
    var now = new DateTime.now();
    timeIn.value = DateFormat("HH:mm:ss").format(now);
  }

  loadUsers() async {
    var prefs = Get.find<SharedPreferences>();
    groupName.value = prefs.getString('groupName') ?? "";
    groupId.value = prefs.getString('groupId') ?? "";
    placement.value = prefs.getString('placement') ?? "";
  }

  void submitOvertime() async {
    final res = await apiRepository.submitOvertime(
      SubmitOvertimeRequest(
        note: noteController.text,
      ),
    );

    if (res!.message == 'Silahkan untuk absen keluar dulu') {
      errorNotFoundClockOut();
    } else if (res.error == false) {
      EasyLoading.showSuccess('Berhasil disimpan');
      Get.back();
    } else {
      EasyLoading.showError('Gagal disimpan');
    }
  }

  void submitOvertimeClient() async {
    final res = await apiRepository.submitOvertimeClient(
      SubmitOvertimeClientRequest(
          note: noteController.text, userId: int.parse(idTad.value)),
    );

    if (res!.message == 'Silahkan untuk absen keluar dulu') {
      errorNotFoundClockOut();
    } else if (res.error == false) {
      EasyLoading.showSuccess('Berhasil disimpan');
      Get.back();
    } else {
      EasyLoading.showError('Gagal disimpan');
    }
  }

  void errorNotFoundClockOut() {
    Get.defaultDialog(
      title: "Informasi",
      content: CommonWidget.bodyText(
        text: "Anda belum melakukan absen keluar",
      ),
      textConfirm: 'Absen keluar',
      textCancel: 'Batal',
      onCancel: () {
        Get.back();
      },
      onConfirm: () {
        submitOut();
        Get.back();
      },
    );
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
      EasyLoading.showSuccess('Berhasil Clock Out');
      Get.back();
    } else {
      EasyLoading.showError('Gagal Clock Out');
      Get.back();
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
        // //dismissDirection: SnackDismissDirection.HORIZONTAL,
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
          // //dismissDirection: SnackDismissDirection.HORIZONTAL,
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
        // //dismissDirection: SnackDismissDirection.HORIZONTAL,
        forwardAnimationCurve: Curves.easeOutBack,
      );
      print(
          "Location permissions are permanently denied, we cannot request permissions.");
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    myLocation = LatLng(position.latitude, position.longitude);

    final prefs = Get.find<SharedPreferences>();
    if (prefs.getString('token') != null) {
      prefs.setDouble(StorageConstants.initLatitude, position.latitude);
      prefs.setDouble(StorageConstants.initLongitude, position.longitude);
    }

    EasyLoading.dismiss();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
