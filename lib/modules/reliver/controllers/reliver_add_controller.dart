import 'package:cleaner/api/api_repository.dart';
import 'package:cleaner/models/request/reliver/create_reliver_request.dart';
import 'package:cleaner/models/response/branch_response.dart';
import 'package:cleaner/models/response/izin/type_izin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReliverAddController extends GetxController {
  final ApiRepository apiRepository;
  ReliverAddController({required this.apiRepository});
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
  final numberReliver = TextEditingController();
  final noteController = TextEditingController();
  final noteKebutuhanController = TextEditingController();
  final startDateKebutuhanController = TextEditingController();
  final endDateKebutuhanController = TextEditingController();

  RxString groupName = "".obs;
  RxString groupId = "".obs;
  RxString placement = "".obs;
  RxInt nameBranchId = 0.obs;

  String date = "";
  DateTime selectedDate = DateTime.now();
  RxString dateCnC = "".obs;
  var listType = <DataTypeIzin>[].obs;
  var listBranch = <BranchListData>[].obs;

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
    final res = await apiRepository.submitReliver(
      CreateReliverRequest(
        branchId: nameBranchId.value,
        dateNeeded: startDateKebutuhanController.text,
        dateEndNeeded: endDateKebutuhanController.text,
        note: noteController.text,
        needEmployee: int.parse(numberReliver.text),
        dateStartWorkEmployee: startDateKebutuhanController.text,
      ),
    );
    if (res!.error == false) {
      EasyLoading.showSuccess(res.message);
      Get.back();
    } else {
      EasyLoading.showError('Gagal disimpan');
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
    getBranch();
  }

  loadUsers() async {
    var prefs = Get.find<SharedPreferences>();
    groupName.value = prefs.getString('groupName') ?? "";
    groupId.value = prefs.getString('groupId') ?? "";
    placement.value = prefs.getString('placement') ?? "";
  }

  selectDate(BuildContext context, controller) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) selectedDate = selected;
    controller.text =
        DateFormat("yyyy-MM-dd", "id_ID").format(selectedDate).toString();
  }

  void getBranch() async {
    final res = await apiRepository.branchList();
    listBranch.addAll(res?.data ?? []);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
