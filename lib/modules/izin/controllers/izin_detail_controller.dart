import 'package:cleaner/api/api_repository.dart';
import 'package:cleaner/models/request/cnc/approval_cnc.dart';
import 'package:cleaner/models/request/cnc/goods.dart';
import 'package:cleaner/models/request/cnc/submit_cnc.dart' as item;
import 'package:cleaner/models/request/cnc/submit_cnc.dart';
import 'package:cleaner/models/request/izin/update_approval_request.dart';
import 'package:cleaner/models/response/cnc/list_item.dart';
import 'package:cleaner/models/response/cnc/show.dart';
import 'package:cleaner/models/response/izin/show_izin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IzinDetailController extends GetxController {
  final ApiRepository apiRepository;
  IzinDetailController({required this.apiRepository});

  final argm = Get.arguments;
  var detail = DataIzin().obs;
  String date = "";
  DateTime selectedDate = DateTime.now();
  final noRequestController = TextEditingController();
  final noteController = TextEditingController();
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

  @override
  void onInit() {
    super.onInit();
    // getDetailIzin();
  }

  @override
  void onReady() {
    super.onReady();
    getDetailIzin();
    loadUsers();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> onRefresh() async {
    getDetailIzin();
    // getItemCnC();
    loadUsers();
  }

  loadUsers() async {
    var prefs = Get.find<SharedPreferences>();
    groupName.value = prefs.getString('groupName') ?? "";
    groupId.value = prefs.getString('groupId') ?? "";
  }

  void getDetailIzin() async {
    final res = await apiRepository.showIzin(argm.toString());
    print(res!.data!);
    detail.value = res.data!;
    noRequestController.text = detail.value.code ?? '';
    noteController.text = detail.value.note ?? '';
    noteApprovalController.text = detail.value.noteApproval ?? '';
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
      getDetailIzin();
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

  void approvalCnC({
    action = "reject",
  }) async {
    if (submitItem.value.length == 0) {
      EasyLoading.showError('Tidak ada item yang di submit');
      return;
    } else {
      List<ItemListApproval> _submitedItem = [];
      for (var data in submitItem.value) {
        _submitedItem.add(ItemListApproval(
          itemId: data.itemId,
          quantity: data.quantity ?? 0,
        ));
      }

      final res = await apiRepository.updateApprovalCnC(
        detail.value.id.toString(),
        ApprovalCnCRequest(action: action, itemList: _submitedItem),
      );
      if (res!.error == false) {
        getDetailIzin();
        loadUsers();
        EasyLoading.showSuccess('Berhasil disimpan');
      } else {
        EasyLoading.showError('Gagal disimpan');
      }
    }
  }
}
