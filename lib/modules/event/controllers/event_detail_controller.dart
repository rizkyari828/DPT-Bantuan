import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:konconeDeDe/api/api_repository.dart';
import 'package:konconeDeDe/models/response/reliver/show_reliver_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konconeDeDe/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReliverDetailController extends GetxController {
  final ApiRepository apiRepository;
  ReliverDetailController({required this.apiRepository});

  final argm = Get.arguments;
  var detail = DataShowReliver().obs;
  String date = "";
  DateTime selectedDate = DateTime.now();
  final noRequestController = TextEditingController();
  final noteController = TextEditingController();
  final noteApprovalController = TextEditingController();
  final qtyController = TextEditingController();
  final dateStartWorkController = TextEditingController();
  final TextEditingController numberReliver = TextEditingController();
  RxString groupName = "".obs;
  RxString groupId = "".obs;

  Barcode? result;
  RxString stringQr = "".obs;

  var qrKey = GlobalKey(debugLabel: 'QR').obs;
  QRViewController? qrViewController;
  RxBool scanning = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getDetail();
    loadUsers();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> onRefresh() async {
    getDetail();
    loadUsers();
  }

  loadUsers() async {
    var prefs = Get.find<SharedPreferences>();
    groupName.value = prefs.getString('groupName') ?? "";
    groupId.value = prefs.getString('groupId') ?? "";
  }

  void getDetail() async {
    final res = await apiRepository.showReliver(argm.toString());
    print(res!.data!);
    detail.value = res.data!;
  }

  void goToScannerPages() {
    Get.toNamed(Routes.QRSCANNER, arguments: detail.value);
  }

  void goToPenerimaPages() {
    Get.toNamed(Routes.PENERIMA, arguments: detail.value);
  }

  void setQRViewController(QRViewController? controller) {
    qrViewController = controller;
    update();
  }

  void setScanning(dynamic value) {
    scanning.value = value;
  }
}
