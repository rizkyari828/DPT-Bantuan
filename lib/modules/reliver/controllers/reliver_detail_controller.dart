import 'package:cleaner/api/api_repository.dart';
import 'package:cleaner/models/request/cnc/goods.dart';
import 'package:cleaner/models/request/cnc/submit_cnc.dart' as item;
import 'package:cleaner/models/request/cnc/submit_cnc.dart';
import 'package:cleaner/models/request/reliver/approve_reliver_request.dart';
import 'package:cleaner/models/response/cnc/list_item.dart';
import 'package:cleaner/models/response/reliver/show_reliver_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
  var goods = <Goods>[].obs;
  var submitItem = <item.ItemList>[].obs;
  var listItem = <ListItem>[].obs;

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
    noRequestController.text = detail.value.code ?? '';
    noteController.text = detail.value.note ?? '';
    noteApprovalController.text = detail.value.noteApproval ?? '';
    numberReliver.text = detail.value.needEmployee.toString();
    dateStartWorkController.text = DateFormat("yyyy-MM-dd", "id_ID")
        .format(detail.value.dateStartWorkEmployee ?? DateTime.now())
        .toString();
  }

  void approval({
    action = "reject",
  }) async {
    final res = await apiRepository.updateApprovalReliver(
        detail.value.id.toString(),
        ApproveReliverRequest(
          action: action,
          needAprroveEmployee: int.parse(numberReliver.text),
          dateStartWorkEmployee: dateStartWorkController.text,
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
    dateStartWorkController.text =
        DateFormat("yyyy-MM-dd", "id_ID").format(selectedDate).toString();
  }

  void updateGoods({name}) {
    // goods.removeWhere((e) => e.id == id);
    // goods[goods.indexWhere((element) => element.name == name)] = singleGoods;
  }

  void deleteGoods({name}) {}

  void submitCnC() async {
    final res = await apiRepository.submitCnC(
      SubmitCnCRequest(
          date: DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),
          note: noteController.text,
          itemList: submitItem.value),
    );
    if (res!.data != null) {
      EasyLoading.showSuccess('Berhasil disimpan');
    } else {
      EasyLoading.showError('Gagal disimpan');
    }
  }
}
