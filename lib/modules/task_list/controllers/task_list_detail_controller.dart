import 'dart:convert';

import 'package:cleaner/api/api_repository.dart';
import 'package:cleaner/models/request/cnc/goods.dart';
import 'package:cleaner/models/request/cnc/submit_cnc.dart' as item;
import 'package:cleaner/models/request/izin/update_approval_request.dart';
import 'package:cleaner/models/request/taskList/update_task_list_tad_before_request.dart';
import 'package:cleaner/models/request/taskList/update_task_tad.dart';
import 'package:cleaner/models/response/cnc/list_item.dart';
import 'package:cleaner/models/response/taskList/tad/show_task_list_tad_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' as Io;

class TaskListDetailController extends GetxController {
  final ApiRepository apiRepository;
  TaskListDetailController({required this.apiRepository});

  final argm = Get.arguments;
  var detail = ShowTaskTadData().obs;
  String date = "";
  DateTime selectedDate = DateTime.now();
  final noRequestController = TextEditingController();
  final noteController = TextEditingController();
  final noteTadController = TextEditingController();
  final noteApprovalController = TextEditingController();
  final qtyController = TextEditingController();
  final dateController = TextEditingController();
  final dateCnCController = TextEditingController();
  RxString dateCnC = "".obs;
  RxString dateGoods = "".obs;
  RxString nameItem = "".obs;
  RxString groupName = "".obs;
  RxString groupId = "".obs;
  var goods = <Goods>[].obs;
  var submitItem = <item.ItemList>[].obs;
  var listItem = <ListItem>[].obs;

  RxInt currentStep = 0.obs;
  var stepperType = StepperType.horizontal.obs;

  var imageFileListBefore = <XFile>[].obs;
  var imageFileListAfter = <XFile>[].obs;

  set _imageFileBefore(XFile? value) {
    imageFileListBefore.addAll((value == null ? null : <XFile>[value])!);
  }

  set _imageFileAfter(XFile? value) {
    imageFileListAfter.addAll((value == null ? null : <XFile>[value])!);
  }

  dynamic pickImageError;
  RxString? retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // getDetail();
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

  Future<void> onImageButtonPressed(String type, ImageSource source,
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

          if (type == 'before') {
            imageFileListBefore.addAll(pickedFileList!);
          } else {
            imageFileListAfter.addAll(pickedFileList!);
          }
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

          if (type == 'before') {
            _imageFileBefore = pickedFile;
          } else {
            _imageFileAfter = pickedFile;
          }
        } catch (e) {
          pickImageError = e;
        }
      });
    }
  }

  Future<void> _displayPickImageDialog(BuildContext context, onPick) async {
    return onPick(200.0, 200.0, 50);
  }

  loadUsers() async {
    var prefs = Get.find<SharedPreferences>();
    groupName.value = prefs.getString('groupName') ?? "";
    groupId.value = prefs.getString('groupId') ?? "";
  }

  void getDetail() async {
    print(argm['taskId']);
    final res =
        await apiRepository.showTaskListTad(argm['taskId'], argm['typeId']);
    print(res!.data!);
    detail.value = res.data!;
    if (detail.value.beforePhotos.isEmpty) {
      currentStep.value = 0;
    } else if (detail.value.afterPhotos.isNotEmpty) {
      currentStep.value = 2;
    } else if (detail.value.beforePhotos.isNotEmpty) {
      currentStep.value = 1;
    } else {
      currentStep.value = 0;
    }
    // noRequestController.text = detail.value.code ?? '';
    noteController.text = detail.value.note ?? '';
    noteTadController.text = detail.value.noteTad ?? '';
    // noteApprovalController.text = detail.value.noteApproval ?? '';
  }

  void approval({
    action = "reject",
  }) async {
    final res = await apiRepository.updateApprovalIzin(
        detail.value.id.toString(),
        UpdateApprovalIzinRequest(
          action: action,
          noteApproval: noteApprovalController.text,
        ));
    if (res!.error == false) {
      EasyLoading.showSuccess('Berhasil disimpan');
      getDetail();
      loadUsers();
    } else {
      EasyLoading.showError('Gagal disimpan');
    }
  }

  selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) selectedDate = selected;
    dateCnC.value = selectedDate.toString();
  }

  void dateSubmit() {
    dateCnC.value = dateCnCController.text;
  }

  switchStepsType() {
    stepperType.value == StepperType.vertical
        ? stepperType.value = StepperType.horizontal
        : stepperType.value = StepperType.vertical;
  }

  tapped(int step) {
    currentStep.value = step;
  }

  continued() {
    print(currentStep.value);
    if (currentStep.value == 0) {
      print(detail.value.beforePhotos);
      if (detail.value.beforePhotos.isEmpty) {
        // EasyLoading.show(status: 'loading..');
        submitDokuments('before');
      } else {
        EasyLoading.dismiss();
        currentStep.value < 2 ? currentStep.value += 1 : currentStep.value = 0;
      }
    } else if (currentStep.value == 1) {
      if (detail.value.afterPhotos.isEmpty) {
        // EasyLoading.show(status: 'loading..');
        submitDokuments('after');
        getDetail();
      } else {
        EasyLoading.dismiss();
        currentStep.value < 2 ? currentStep.value += 1 : currentStep.value = 0;
      }
    } else {
      Get.back();
    }
  }

  cancel() {
    currentStep.value > 0 ? currentStep.value -= 1 : currentStep.value = 0;
  }

  void submitDokuments(String type) async {
    List<String> _afterBase64 = [];
    List<String> _beforeBase64 = [];

    if (type == 'before') {
      print(imageFileListBefore);
      for (var itemBefore in imageFileListBefore) {
        var mimeType = lookupMimeType(itemBefore.path);
        var bytesBefore = await Io.File(itemBefore.path).readAsBytes();
        String img64 = 'data:' +
            mimeType.toString() +
            ';base64,' +
            base64Encode(bytesBefore);
        _beforeBase64.add(img64);
      }

      final res = await apiRepository.updateTaskListBeforeTad(
        argm['taskId'],
        argm['typeId'],
        UpdateTaskListTadBeforeRequest(base64BeforePhotos: _beforeBase64),
      );

      if (res?.error == false) {
        EasyLoading.showSuccess('Berhasil disimpan');
        currentStep.value < 2 ? currentStep.value += 1 : currentStep.value = 0;
      } else {
        EasyLoading.showError('Gagal disimpan');
      }
    } else {
      for (var itemAfter in imageFileListAfter) {
        var mimeType = lookupMimeType(itemAfter.path);
        var bytesAfter = await Io.File(itemAfter.path).readAsBytes();
        String img64 = 'data:' +
            mimeType.toString() +
            ';base64,' +
            base64Encode(bytesAfter);
        _afterBase64.add(img64);
      }

      // print(_afterBase64);
      final res = await apiRepository.updateTaskListAfterTad(
        argm['taskId'],
        argm['typeId'],
        UpdateTaskListTadRequest(
            base64AfterPhotos: _afterBase64, noteTad: noteTadController.text),
      );

      print(res);

      if (res?.error == false) {
        EasyLoading.showSuccess('Berhasil disimpan');
        getDetail();
        currentStep.value < 2 ? currentStep.value += 1 : currentStep.value = 0;
      } else {
        EasyLoading.showError('Gagal disimpan');
        EasyLoading.dismiss();
      }
    }
  }

  // void goToDetailCnCPages() {
  //   Get.toNamed(Routes.DETAIL_CNC);
  // }
}
