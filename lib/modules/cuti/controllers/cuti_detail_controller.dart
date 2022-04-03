import 'package:cleaner/api/api_repository.dart';
import 'package:cleaner/models/request/cnc/approval_cnc.dart';
import 'package:cleaner/models/request/cnc/goods.dart';
import 'package:cleaner/models/request/cnc/submit_cnc.dart' as item;
import 'package:cleaner/models/request/cnc/submit_cnc.dart';
import 'package:cleaner/models/request/cuti/update_approval_request.dart';
import 'package:cleaner/models/response/cnc/list_item.dart';
import 'package:cleaner/models/response/cuti/show_cuti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CutiDetailController extends GetxController {
  final ApiRepository apiRepository;
  CutiDetailController({required this.apiRepository});

  final argm = Get.arguments;
  var detail = DataCuti().obs;
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
  RxString unitTypeName = "".obs;
  RxString groupName = "".obs;
  RxString groupId = "".obs;
  var goods = <Goods>[].obs;
  var submitItem = <item.ItemList>[].obs;
  var listItem = <ListItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    // getDetailCuti();
  }

  @override
  void onReady() {
    super.onReady();
    getDetailCuti();
    loadUsers();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> onRefresh() async {
    getDetailCuti();
    loadUsers();
  }

  loadUsers() async {
    var prefs = Get.find<SharedPreferences>();
    groupName.value = prefs.getString('groupName') ?? "";
    groupId.value = prefs.getString('groupId') ?? "";
  }

  void getDetailCuti() async {
    final res = await apiRepository.showCuti(argm.toString());
    detail.value = res!.data!;
    noRequestController.text = detail.value.code ?? '';
    noteController.text = detail.value.note ?? '';
    noteApprovalController.text = detail.value.noteApproval ?? '';
    goods.clear();
  }

  void approval({
    action = "reject",
  }) async {
    final res = await apiRepository.updateApprovalCuti(
        detail.value.id.toString(),
        UpdateApprovalCutiRequest(
          action: action,
          noteApproval: noteApprovalController.text,
        ));
    if (res!.error == false) {
      EasyLoading.showSuccess('Berhasil disimpan');
      getDetailCuti();
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

  selectDateGoods(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) selectedDate = selected;
    dateGoods.value = selectedDate.toString();
  }

  void dateSubmit() {
    dateCnC.value = dateCnCController.text;
  }

  void submiteGoods() {
    Goods singleGoods = Goods(
      name: nameItem.value,
      qty: qtyController.text,
      unitTypeName: unitTypeName.value,
    );
    goods.add(singleGoods);

    int _idItem = 0;
    for (var f in listItem) {
      if (f.name.toString() == nameItem.value) {
        _idItem = f.id ?? 0;
      }
    }

    item.ItemList singleItemSubmit = item.ItemList(
      itemId: _idItem,
      quantity: int.parse(qtyController.text),
    );
    submitItem.add(singleItemSubmit);

    print(submitItem);

    Get.back();
  }

  void deleteGoods({name}) {
    goods.removeWhere((e) => e.name == name);

    int _idItemSearch = 0;
    for (var f in listItem) {
      if (f.name.toString() == name) {
        _idItemSearch = f.id ?? 0;
      }
    }

    submitItem.removeWhere((element) => element.itemId == _idItemSearch);

    print(submitItem);

    // Get.back();
  }

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
        getDetailCuti();
        loadUsers();
        EasyLoading.showSuccess('Berhasil disimpan');
      } else {
        EasyLoading.showError('Gagal disimpan');
      }
    }
  }
}
