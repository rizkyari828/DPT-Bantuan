import 'package:cleaner/api/api_repository.dart';
import 'package:cleaner/models/request/cnc/approval_cnc.dart';
import 'package:cleaner/models/request/cnc/goods.dart';
import 'package:cleaner/models/request/cnc/submit_cnc.dart' as item;
import 'package:cleaner/models/response/cnc/category.dart';
import 'package:cleaner/models/response/cnc/list_item.dart';
import 'package:cleaner/models/response/cnc/show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CnCDetailController extends GetxController {
  final ApiRepository apiRepository;
  CnCDetailController({required this.apiRepository});

  final argm = Get.arguments;
  var detail = DetailCnC().obs;
  String date = "";
  DateTime selectedDate = DateTime.now();
  final noRequestController = TextEditingController();
  final noteController = TextEditingController();
  final qtyController = TextEditingController();
  final dateController = TextEditingController();
  final dateCnCController = TextEditingController();
  RxString dateCnC = "".obs;
  RxString dateGoods = "".obs;
  RxString nameItem = "".obs;
  RxString unitTypeName = "".obs;
  RxString groupName = "".obs;
  RxString groupId = "".obs;
  RxInt categoryId = 2.obs;
  var goods = <Goods>[].obs;
  var submitItem = <item.ItemList>[].obs;
  var listItem = <ListItem>[].obs;
  var listAllItem = <ListItem>[].obs;
  var listItemFilter = <ListItem>[].obs;
  var listCategory = <CategoryCnCData>[].obs;

  @override
  void onInit() {
    super.onInit();
    // getDetailCnC();
  }

  @override
  void onReady() {
    super.onReady();
    getDetailCnC();
    loadUsers();
    getCategoryCnC();
    getAllItemCnC();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> onRefresh() async {
    getDetailCnC();
    loadUsers();
    getCategoryCnC();
    getAllItemCnC();
  }

  void getAllItemCnC() async {
    listItem.clear();
    final res = await apiRepository.listAllCnCItem();
    listAllItem.addAll(res?.data ?? []);
  }

  loadUsers() async {
    var prefs = Get.find<SharedPreferences>();
    groupName.value = prefs.getString('groupName') ?? "";
    groupId.value = prefs.getString('groupId') ?? "";
  }

  void getDetailCnC() async {
    final res = await apiRepository.showCnC(argm.toString());
    detail.value = res!.data!;
    noRequestController.text = detail.value.code ?? '';
    noteController.text = detail.value.note ?? '';
    goods.clear();
    for (var data in res.data?.itemList ?? []) {
      goods.add(Goods(
        name: data.item.name,
        qty: data.quantity,
        unitTypeName: data.item.unitTypeName,
      ));

      item.ItemList singleItemSubmit = item.ItemList(
        itemId: data.itemId,
        quantity: int.parse(data.quantity ?? 0),
      );
      submitItem.add(singleItemSubmit);
    }
    // print(submitedItem);
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

  void updateGoods({name}) {
    Goods singleGoods = Goods(
      name: nameItem.value,
      qty: qtyController.text,
      unitTypeName: unitTypeName.value,
    );

    goods[goods.indexWhere((element) => element.name == name)] = singleGoods;

    int _idItemSearch = 0;
    for (var f in listItem) {
      if (f.name.toString() == name) {
        _idItemSearch = f.id ?? 0;
      }
    }

    int _idItem = 0;
    for (var f in listItem) {
      if (f.name.toString() == nameItem.value) {
        _idItem = f.id ?? 0;
      }
    }

    print(submitItem);

    item.ItemList singleItemSubmit = item.ItemList(
      itemId: _idItem,
      quantity: int.parse(qtyController.text),
    );
    submitItem[submitItem.indexWhere(
        (element) => element.itemId == _idItemSearch)] = singleItemSubmit;

    Get.back();
  }

  void deleteGoods({name}) {
    goods.removeWhere((e) => e.name == name);

    int _idItemSearch = 0;
    print(listAllItem);
    for (var f in listAllItem) {
      if (f.name.toString() == name) {
        _idItemSearch = f.id ?? 0;
      }
    }

    print(submitItem);
    submitItem.removeWhere((element) => element.itemId == _idItemSearch);

    print(submitItem);

    // Get.back();
  }

  void getItemCnC(categoryName) async {
    listItem.clear();
    unitTypeName.value = categoryName;
    String _idCategory = "";
    for (var f in listCategory) {
      if (f.name.toString() == categoryName) {
        _idCategory = f.id.toString();
      }
    }
    final res = await apiRepository.listCnCItem(_idCategory);
    listItem.addAll(res?.data ?? []);
  }

  void getCategoryCnC() async {
    final res = await apiRepository.listCnCCategory();
    listCategory.addAll(res?.data ?? []);
  }

  void filterItem(int categoryId) {
    listItemFilter.clear();
    listItemFilter
        .addAll(listItem.where((element) => element.unitTypeId == categoryId));
  }

  void submit() async {
    print(submitItem);

    // final res = await apiRepository.submitCnC(
    //   SubmitCnCRequest(
    //       date: DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),
    //       note: noteController.text,
    //       itemList: submitItem.value),
    // );
    // if (res!.data != null) {
    //   EasyLoading.showSuccess('Berhasil disimpan');
    // } else {
    //   EasyLoading.showError('Gagal disimpan');
    // }
  }

  void approval({
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

      print(_submitedItem);

      final res = await apiRepository.updateApprovalCnC(
        detail.value.id.toString(),
        ApprovalCnCRequest(action: action, itemList: _submitedItem),
      );
      if (res!.error == false) {
        getDetailCnC();
        loadUsers();
        EasyLoading.showSuccess('Berhasil disimpan');
      } else {
        EasyLoading.showError('Gagal disimpan');
      }
      EasyLoading.dismiss();
    }
  }
}
