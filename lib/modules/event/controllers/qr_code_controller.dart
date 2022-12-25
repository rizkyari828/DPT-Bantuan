import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:konconeDeDe/api/api_repository.dart';
import 'package:konconeDeDe/models/request/reliver/create_reliver_request.dart';
import 'package:konconeDeDe/models/response/reliver/show_reliver_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRCodeController extends GetxController {
  final ApiRepository apiRepository;
  QRCodeController({required this.apiRepository});

  final argm = Get.arguments;
  RxString groupName = "".obs;
  RxString groupId = "".obs;
  RxString userId = "".obs;
  RxString stringQr = "".obs;

  var qrKey = GlobalKey(debugLabel: 'QR').obs;
  QRViewController? qrViewController;
  RxBool scanning = false.obs;

  MobileScannerController _cameraController = MobileScannerController();
  MobileScannerController get cameraController => _cameraController;
  int scanCount = 0;
  bool isSuccessScan = false;
  bool _isFlashOn = false;
  bool get isFlashOn => _isFlashOn;
  bool _isExpanded = false;
  bool get isExpanded => _isExpanded;

  var detail = DataShowReliver().obs;

  void toggleFlash() {
    _cameraController.toggleTorch();
    _isFlashOn = !isFlashOn;
  }

  void toggleCamera() {
    _cameraController.switchCamera();
  }

  void onSuccessScan(String? result) {
    stringQr.value = result ?? '';
    print(result);
  }

  void onExpandButtonClicked() {
    _isExpanded = !_isExpanded;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    loadUsers();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> onRefresh() async {
    loadUsers();
  }

  loadUsers() async {
    var prefs = Get.find<SharedPreferences>();
    groupName.value = prefs.getString('groupName') ?? "";
    groupId.value = prefs.getString('groupId') ?? "";
    userId.value = prefs.getString('userId') ?? "";
  }

  void submit() async {
    detail.value = argm;
    String dateNow =
        DateFormat("yyyy-MM-dd", "id_ID").format(DateTime.now()).toString();
    final res = await apiRepository.submitQr(CreateReliverRequest(
        tahun: DateFormat("yyyy", "id_ID").format(DateTime.now()).toString(),
        bulan: DateFormat("MM", "id_ID").format(DateTime.now()).toString(),
        idCampaignProses: detail.value.id,
        createDate: dateNow,
        qrNumber: stringQr.value,
        idCampaign: detail.value.idCampaign,
        createBy: userId.value));
    if (res!.error == false) {
      EasyLoading.showSuccess('Berhasil disimpan');
      EasyLoading.dismiss();
    } else {
      EasyLoading.showError('Gagal disimpan');
      EasyLoading.dismiss();
    }
  }

  void onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    print('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  Future<bool> onWillPop() {
    Get.back();
    return Future.value(false);
  }
}
