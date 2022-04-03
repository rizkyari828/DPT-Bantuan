import 'dart:convert';
import 'dart:io' as Io;

import 'package:cleaner/api/api_repository.dart';
import 'package:cleaner/models/request/overtime/set_done_overtime_request.dart'
    as setdone;
import 'package:cleaner/models/request/overtime/update_approval_overtime_request.dart';
import 'package:cleaner/models/response/overtime/show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mime/mime.dart';

class LemburDetailController extends GetxController {
  final ApiRepository apiRepository;
  LemburDetailController({required this.apiRepository});

  final argm = Get.arguments;
  var detail = DataDetailOvertime().obs;
  var arrayFive = <double>[
    0.5,
    1.0,
    1.5,
    2.0,
    2.5,
    3.0,
    3.5,
    4.0,
    4.5,
    5.0,
    5.5,
    6.0,
    6.5,
    7.0,
    7.5,
    8.0,
    8.5
  ].obs;
  String date = "";
  DateTime selectedDate = DateTime.now();
  final noRequestController = TextEditingController();
  final noteController = TextEditingController();
  final approvalController = TextEditingController();
  final namaRoomController = TextEditingController();
  final actualTimeController = TextEditingController();
  RxString nameItem = "".obs;
  RxString groupName = "".obs;
  RxString groupId = "".obs;
  var imageFileBefore = <XFile>[].obs;
  var imageFileListAfter = <XFile>[].obs;
  var _beforeBase641 = <String>[].obs;
  var _beforeBase642 = <String>[].obs;
  var _beforeBase643 = <String>[].obs;
  var _beforeBase644 = <String>[].obs;
  var _beforeBase645 = <String>[].obs;
  var _afterBase641 = <String>[].obs;
  var _afterBase642 = <String>[].obs;
  var _afterBase643 = <String>[].obs;
  var _afterBase644 = <String>[].obs;
  var _afterBase645 = <String>[].obs;
  var dokumentRoom1 = setdone.OvertimeRoomPhoto().obs;
  var dokumentRoom2 = setdone.OvertimeRoomPhoto().obs;
  var dokumentRoom3 = setdone.OvertimeRoomPhoto().obs;
  var dokumentRoom4 = setdone.OvertimeRoomPhoto().obs;
  var dokumentRoom5 = setdone.OvertimeRoomPhoto().obs;
  RxBool isFilledDokumentRoom1 = false.obs;
  RxBool isFilledDokumentRoom2 = false.obs;
  RxBool isFilledDokumentRoom3 = false.obs;
  RxBool isFilledDokumentRoom4 = false.obs;
  RxBool isFilledDokumentRoom5 = false.obs;
  // var dokumentRoom2 = <setdone.OvertimeRoomPhoto>[].obs;

  set _imageFileAfter(XFile? value) {
    imageFileListAfter.addAll((value == null ? null : <XFile>[value])!);
  }

  set _imageFileBefore(XFile? value) {
    imageFileBefore.addAll((value == null ? null : <XFile>[value])!);
  }

  dynamic pickImageError;
  RxString? retrieveDataError;
  RxBool isFilled = true.obs;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // getDetailOvertime();
  }

  @override
  void onReady() {
    super.onReady();
    getDetailOvertime();
    loadUsers();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> onRefresh() async {
    getDetailOvertime();
    loadUsers();
  }

  Future<void> onImageButtonPressed(ImageSource source,
      {BuildContext? context,
      bool isMultiImage = false,
      int list = 1,
      required String type}) async {
    print(list);
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
            imageFileBefore.addAll(pickedFileList!);
            for (var itemBefore in pickedFileList) {
              String img64 = await encodeBase64(itemBefore.path);
              if (list == 1) {
                _beforeBase641.add(img64);
              } else if (list == 2) {
                _beforeBase642.add(img64);
              } else if (list == 3) {
                _beforeBase643.add(img64);
              } else if (list == 4) {
                _beforeBase644.add(img64);
              } else if (list == 5) {
                _beforeBase645.add(img64);
              }
            }
          } else {
            imageFileListAfter.addAll(pickedFileList!);
            for (var itemAfter in imageFileListAfter) {
              String img64 = await encodeBase64(itemAfter.path);
              if (list == 1) {
                _afterBase641.add(img64);
              } else if (list == 2) {
                _afterBase642.add(img64);
              } else if (list == 3) {
                _afterBase642.add(img64);
              } else if (list == 4) {
                _afterBase642.add(img64);
              } else if (list == 5) {
                _afterBase642.add(img64);
              }
            }
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
            String img64 = await encodeBase64(pickedFile);
            if (list == 1) {
              _beforeBase641.add(img64);
            } else if (list == 2) {
              _beforeBase642.add(img64);
            } else if (list == 3) {
              _beforeBase643.add(img64);
            } else if (list == 4) {
              _beforeBase644.add(img64);
            } else if (list == 5) {
              _beforeBase645.add(img64);
            }
          } else {
            _imageFileAfter = pickedFile;
            String img64 = await encodeBase64(pickedFile);
            if (list == 1) {
              _afterBase641.add(img64);
            } else if (list == 2) {
              _afterBase642.add(img64);
            } else if (list == 3) {
              _afterBase642.add(img64);
            } else if (list == 4) {
              _afterBase642.add(img64);
            } else if (list == 5) {
              _afterBase642.add(img64);
            }
          }
        } catch (e) {
          pickImageError = e;
        }
      });
    }
  }

  Future<String> encodeBase64(pickedFile) async {
    var mimeType = lookupMimeType(pickedFile!.path);
    var bytes = await Io.File(pickedFile.path).readAsBytes();
    String img64 =
        'data:' + mimeType.toString() + ';base64,' + base64Encode(bytes);
    return img64;
  }

  Future<void> _displayPickImageDialog(BuildContext context, onPick) async {
    return onPick(200.0, 200.0, 50);
  }

  void submit() async {
    EasyLoading.show(status: 'loading..');
    var dokumentRoom = <setdone.OvertimeRoomPhoto>[].obs;

    if (isFilledDokumentRoom1.value) {
      dokumentRoom.add(dokumentRoom1.value);
    }
    if (isFilledDokumentRoom2.value) {
      dokumentRoom.add(dokumentRoom2.value);
    }
    if (isFilledDokumentRoom3.value) {
      dokumentRoom.add(dokumentRoom3.value);
    }
    if (isFilledDokumentRoom4.value) {
      dokumentRoom.add(dokumentRoom4.value);
    }
    if (isFilledDokumentRoom5.value) {
      dokumentRoom.add(dokumentRoom5.value);
    }
    final res = await apiRepository.setDoneOvertime(argm,
        setdone.SetDoneOvertimeRequest(overtimeRoomPhotos: dokumentRoom.value));
    if (res!.error == false) {
      EasyLoading.showSuccess('Berhasil disimpan');
      Get.back();
      EasyLoading.dismiss();
    } else {
      EasyLoading.showError('Gagal disimpan');
      EasyLoading.dismiss();
    }
  }

  void approval({
    action = "reject",
  }) async {
    print("total" + actualTimeController.text);
    final res = await apiRepository.updateApprovalOvertime(
      detail.value.id.toString(),
      UpdateApprovalOvertimeRequest(
          action: action,
          noteApproval: approvalController.value.text,
          actualTime: double.parse(actualTimeController.value.text)),
    );
    if (res!.error == false) {
      getDetailOvertime();
      loadUsers();
      EasyLoading.showSuccess('Berhasil disimpan');
    } else {
      EasyLoading.showError('Gagal disimpan');
    }
  }

  loadUsers() async {
    var prefs = Get.find<SharedPreferences>();
    groupName.value = prefs.getString('groupName') ?? "";
    groupId.value = prefs.getString('groupId') ?? "";
  }

  void getDetailOvertime() async {
    final res = await apiRepository.showOvertime(argm.toString());
    detail.value = res!.data!;
    noRequestController.text = detail.value.code ?? '';
    noteController.text = detail.value.note ?? '';
    actualTimeController.text = detail.value.actualTime ?? '';
    // print(submitedItem);
  }

  void checkValidation(int list) {
    if (namaRoomController.text == '') {
      isFilled.value = false;
    } else {
      isFilled.value = true;
      submitRoom(list);
    }
  }

  void submitRoom(int list) async {
    print('list' + list.toString());
    // clearImage();
    if (list == 1) {
      List<String> _beforeBase64Plus1 = [];
      List<String> _afterBase64Plus1 = [];
      for (var itemBefore in _beforeBase641) {
        _beforeBase64Plus1.add(itemBefore);
      }

      for (var itemAfter in _afterBase641) {
        _afterBase64Plus1.add(itemAfter);
      }

      dokumentRoom1.value = setdone.OvertimeRoomPhoto(
          name: namaRoomController.text,
          base64BeforePhotos: _beforeBase64Plus1,
          base64AfterPhotos: _afterBase64Plus1);

      isFilledDokumentRoom1.value = true;
    } else if (list == 2) {
      List<String> _beforeBase64Plus2 = [];
      List<String> _afterBase64Plus2 = [];
      for (var itemBefore in _beforeBase642) {
        _beforeBase64Plus2.add(itemBefore);
      }

      for (var itemAfter in _afterBase642) {
        _afterBase64Plus2.add(itemAfter);
      }

      dokumentRoom2.value = setdone.OvertimeRoomPhoto(
          name: namaRoomController.text,
          base64BeforePhotos: _beforeBase64Plus2,
          base64AfterPhotos: _afterBase64Plus2);

      isFilledDokumentRoom2.value = true;
    } else if (list == 3) {
      List<String> _beforeBase64Plus3 = [];
      List<String> _afterBase64Plus3 = [];
      for (var itemBefore in _beforeBase643) {
        _beforeBase64Plus3.add(itemBefore);
      }

      for (var itemAfter in _afterBase643) {
        _afterBase64Plus3.add(itemAfter);
      }

      dokumentRoom3.value = setdone.OvertimeRoomPhoto(
          name: namaRoomController.text,
          base64BeforePhotos: _beforeBase64Plus3,
          base64AfterPhotos: _afterBase64Plus3);

      isFilledDokumentRoom3.value = true;
    } else if (list == 4) {
      List<String> _beforeBase64Plus4 = [];
      List<String> _afterBase64Plus4 = [];
      for (var itemBefore in _beforeBase644) {
        _beforeBase64Plus4.add(itemBefore);
      }

      for (var itemAfter in _afterBase644) {
        _afterBase64Plus4.add(itemAfter);
      }

      dokumentRoom4.value = setdone.OvertimeRoomPhoto(
          name: namaRoomController.text,
          base64BeforePhotos: _beforeBase64Plus4,
          base64AfterPhotos: _afterBase64Plus4);

      isFilledDokumentRoom4.value = true;
    } else if (list == 5) {
      List<String> _beforeBase64Plus5 = [];
      List<String> _afterBase64Plus5 = [];
      for (var itemBefore in _beforeBase645) {
        _beforeBase64Plus5.add(itemBefore);
      }

      for (var itemAfter in _afterBase645) {
        _afterBase64Plus5.add(itemAfter);
      }

      dokumentRoom5.value = setdone.OvertimeRoomPhoto(
          name: namaRoomController.text,
          base64BeforePhotos: _beforeBase64Plus5,
          base64AfterPhotos: _afterBase64Plus5);

      isFilledDokumentRoom5.value = true;
    }

    clearImage();
    namaRoomController.text = '';
    Get.back();
  }

  void clearImage() {
    imageFileBefore.clear();
    imageFileListAfter.clear();
    _beforeBase641.clear();
    _afterBase641.clear();
    _beforeBase642.clear();
    _afterBase642.clear();
  }
}
