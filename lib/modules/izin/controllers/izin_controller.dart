import 'dart:convert';

import 'package:cleaner/api/api_repository.dart';
import 'package:cleaner/models/request/attendance/submit_attendance.dart';
import 'package:cleaner/models/request/izin/submit_izin_request.dart';
import 'package:cleaner/models/response/izin/type_izin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' as Io;

class IzinController extends GetxController {
  final ApiRepository apiRepository;
  IzinController({required this.apiRepository});
  var imageFileList = <XFile>[].obs;

  set _imageFile(XFile? value) {
    imageFileList.addAll((value == null ? null : <XFile>[value])!);
  }

  dynamic pickImageError;
  RxString? retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final noteController = TextEditingController();

  RxString groupName = "".obs;
  RxString groupId = "".obs;
  RxString placement = "".obs;
  RxString nameItem = "".obs;

  String date = "";
  DateTime selectedDate = DateTime.now();
  RxString dateCnC = "".obs;
  var listType = <DataTypeIzin>[].obs;

  Future<void> onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    if (isMultiImage) {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final List<XFile>? pickedFileList = await _picker.pickMultiImage(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );

          imageFileList.addAll(pickedFileList!);
        } catch (e) {
          pickImageError = e;
        }
      });
    } else {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final XFile? pickedFile = await _picker.pickImage(
            source: source,
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );

          _imageFile = pickedFile;
        } catch (e) {
          pickImageError = e;
        }
      });
    }
  }

  void submit() async {
    List<String> _afterBase64 = [];

    for (var itemBefore in imageFileList) {
      var mimeType = lookupMimeType(itemBefore.path);
      var bytesBefore = await Io.File(itemBefore.path).readAsBytes();
      String img64 = 'data:' +
          mimeType.toString() +
          ';base64,' +
          base64Encode(bytesBefore);
      _afterBase64.add(img64);
    }

    // print(_afterBase64);
    final res = await apiRepository.submitIzin(
      SubmitIzinRequest(
          dateStart: startDateController.text,
          dateEnd: endDateController.text,
          note: noteController.text,
          leaveTypeId: nameItem.value,
          base64Documents: _afterBase64),
    );
    if (res!.error == false) {
      EasyLoading.showSuccess('Berhasil disimpan');
      Get.back();
    } else {
      EasyLoading.showError('Gagal disimpan');
      EasyLoading.dismiss();
    }
  }

  Future<void> _displayPickImageDialog(BuildContext context, onPick) async {
    return onPick(200.0, 200.0, 50);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    loadUsers();
    getType();
  }

  loadUsers() async {
    var prefs = Get.find<SharedPreferences>();
    groupName.value = prefs.getString('groupName') ?? "";
    groupId.value = prefs.getString('groupId') ?? "";
    placement.value = prefs.getString('placement') ?? "";
  }

  selectDateStart(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) selectedDate = selected;
    startDateController.text =
        DateFormat("yyyy-MM-dd", "id_ID").format(selectedDate).toString();
  }

  selectDateEnd(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) selectedDate = selected;
    endDateController.text =
        DateFormat("yyyy-MM-dd", "id_ID").format(selectedDate).toString();
  }

  void getType() async {
    final res = await apiRepository.typeIzin();
    listType.addAll(res?.data ?? []);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
