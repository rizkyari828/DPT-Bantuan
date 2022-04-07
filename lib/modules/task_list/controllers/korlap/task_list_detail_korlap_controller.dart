import 'package:cleaner/api/api_repository.dart';
import 'package:cleaner/models/request/taskList/create_task_list_general_khusus.dart';
import 'package:cleaner/models/request/taskList/create_task_list_khusus.dart';
import 'package:cleaner/models/response/branch_response.dart';
import 'package:cleaner/models/response/name_tad_list_response.dart';
import 'package:cleaner/models/response/taskList/master/task_name_response.dart';
import 'package:cleaner/models/response/taskList/master/task_type_response.dart';
import 'package:cleaner/models/response/taskList/show_task_list_khusus_response.dart';
import 'package:cleaner/models/response/taskList/show_task_list_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskListDetailKorlapController extends GetxController {
  final ApiRepository apiRepository;
  TaskListDetailKorlapController({required this.apiRepository});

  final argm = Get.arguments;
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
  var startDateController = TextEditingController();
  var endDateController = TextEditingController();
  final noteController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  RxString groupName = "".obs;
  RxString groupId = "".obs;
  RxString placement = "".obs;
  RxString nameType = "".obs;
  RxString idType = "".obs;
  RxString idNameTask = "".obs;
  RxString nameTask = "".obs;
  RxString idBranch = "".obs;
  RxString nameBranch = "".obs;
  RxString idTad = "".obs;
  RxString nameTad = "".obs;

  String date = "";
  DateTime selectedDate = DateTime.now();
  RxString dateCnC = "".obs;
  var listType = <TypeTaskData>[].obs;
  var listTaskName = <TaskNameData>[].obs;
  var listTad = <BranchTadListData>[].obs;
  var listBranch = <BranchListData>[].obs;
  var detail = DataShowTaskList().obs;
  var detailKhusus = ShowTaskListKhusus().obs;

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

  void edit() async {
    if (idType.value == '1') {
      final res = await apiRepository.editTaskListGeneral(
          CreateTaskListGeneralRequest(
              typeTaskId: int.parse(idType.value),
              taskId: int.parse(idNameTask.value),
              note: noteController.text,
              startTime: startTimeController.text,
              endTime: endTimeController.text,
              branchId: int.parse(idBranch.value)),
          detail.value.id.toString(),
          idType.value);

      if (res!.error == false) {
        EasyLoading.showSuccess('Berhasil disimpan');
        Get.back();
      } else {
        EasyLoading.showError('Gagal disimpan');
      }
    } else {
      final res = await apiRepository.editTaskListKhusus(
          CreateTaskListKhususRequest(
              typeTaskId: int.parse(idType.value),
              taskId: int.parse(idNameTask.value),
              note: noteController.text,
              startTime: startTimeController.text,
              endTime: endTimeController.text,
              date: startDateController.text,
              userId: int.parse(idTad.value)),
          detailKhusus.value.id.toString(),
          idType.value);

      if (res!.error == false) {
        EasyLoading.showSuccess('Berhasil disimpan');
        Get.back();
      } else {
        EasyLoading.showError('Gagal disimpan');
      }
    }
  }

  void submit() async {
    if (idType.value == '1') {
      final res = await apiRepository.submitTaskListGeneral(
          CreateTaskListGeneralRequest(
              typeTaskId: int.parse(idType.value),
              taskId: int.parse(idNameTask.value),
              note: noteController.text,
              startTime: startTimeController.text,
              endTime: endTimeController.text,
              branchId: int.parse(idBranch.value)));

      if (res!.error == false) {
        EasyLoading.showSuccess('Berhasil disimpan');
      } else {
        EasyLoading.showError('Gagal disimpan');
      }
    } else {
      final res = await apiRepository.submitTaskListKhusus(
        CreateTaskListKhususRequest(
            typeTaskId: int.parse(idType.value),
            taskId: int.parse(idNameTask.value),
            note: noteController.text,
            startTime: startTimeController.text,
            endTime: endTimeController.text,
            date: startDateController.text,
            userId: int.parse(idTad.value)),
      );

      if (res!.error == false) {
        EasyLoading.showSuccess('Berhasil disimpan');
      } else {
        EasyLoading.showError('Gagal disimpan');
      }
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
    getDetail();
    getType();
    getTaskName();
    getBranch();
  }

  void getDetail() async {
    print('type id' + argm['typeId']);
    if (argm['typeId'] == '2') {
      final res = await apiRepository.showTaskListKhusus(
          argm['taskId'], argm['typeId']);
      print(res!.data!);
      detailKhusus.value = res.data!;
      idType.value = detailKhusus.value.task?.taskTypeId.toString() ?? '';
      nameType.value = detailKhusus.value.task?.taskType?.name ?? '';
      noteController.text = detailKhusus.value.note ?? '';
      idBranch.value = detailKhusus.value.branchId.toString();
      nameBranch.value = detailKhusus.value.branch?.name.toString() ?? '';
      idTad.value = detailKhusus.value.userTad?.id.toString() ?? '';
      nameTad.value = detailKhusus.value.userTad?.name.toString() ?? '';
      startTimeController.text = detailKhusus.value.startTime ?? '';
      endTimeController.text = detailKhusus.value.endTime ?? '';
      idNameTask.value = detailKhusus.value.taskId.toString();
      nameTask.value = detailKhusus.value.task?.name.toString() ?? '';
      startDateController.text = DateFormat("yyyy-MM-dd", "id_ID")
          .format(detailKhusus.value.timestamp ?? DateTime.now())
          .toString();
    } else {
      final res =
          await apiRepository.showTaskList(argm['taskId'], argm['typeId']);
      print(res!.data!);
      detail.value = res.data!;
      idType.value = detail.value.task?.taskTypeId.toString() ?? '';
      nameType.value = detail.value.task?.taskType?.name ?? '';
      noteController.text = detail.value.note ?? '';
      idBranch.value = detail.value.branchId.toString();
      nameBranch.value = detail.value.branch?.name.toString() ?? '';
      // idTad.value = detail.value.id.toString();
      // nameTad.value = detail.value.id.toString();
      startTimeController.text = detail.value.startTime ?? '';
      endTimeController.text = detail.value.endTime ?? '';
      idNameTask.value = detail.value.taskId.toString();
      nameTask.value = detail.value.task?.name.toString() ?? '';
      startDateController.text = DateFormat("yyyy-MM-dd", "id_ID")
          .format(detail.value.task?.createdAt ?? DateTime.now())
          .toString();
    }

    getBranchTad(idBranch.value);
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
    final res = await apiRepository.typeTaskList();
    listType.addAll(res?.data ?? []);
  }

  void getTaskName() async {
    final res = await apiRepository.nameTaskList();
    listTaskName.addAll(res?.data ?? []);
  }

  void getBranchTad(String branchId) async {
    final res = await apiRepository.branchNameTad(branchId: branchId);
    listTad.addAll(res?.data ?? []);
    EasyLoading.dismiss();
  }

  void getBranch() async {
    final res = await apiRepository.branchList();
    listBranch.addAll(res?.data ?? []);
  }

  Future<void> selectTime(BuildContext context, controller) async {
    final TimeOfDay? pickedS = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedS != null && pickedS != selectedTime) selectedTime = pickedS;
    controller.text =
        pickedS!.hour.toString() + ":" + pickedS.minute.toString();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
