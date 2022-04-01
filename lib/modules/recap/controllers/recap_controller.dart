import 'package:cleaner/api/api_repository.dart';
import 'package:cleaner/models/response/recap_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class RecapController extends GetxController
    with StateMixin<List<RecapHistoryResponse>> {
  final ApiRepository apiRepository;
  RecapController({required this.apiRepository});
  DateTime? initialDate;
  // List<DataHistory> _historyData = [];
  var historyData = <DataHistory>[].obs;
  DateTime? selectedDate;
  RxString month =
      DateFormat("MMMM yyyy", "id_ID").format(DateTime.now()).toString().obs;
  RxString monthSubmit =
      DateFormat("MM", "id_ID").format(DateTime.now()).toString().obs;
  // RxList<DataHistory> historyData = (List<DataHistory>.of([])).obs;
  // get historyData => this._historyData;
  // List<TableRow> priceTableRows = [];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    // getData();
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  @override
  void onClose() {
    historyData.value = [];
  }

  void getData() async {
    historyData.clear();
    monthSubmit.value = DateFormat("MM", "id_ID")
        .format(selectedDate ?? DateTime.now())
        .toString();
    final res = await apiRepository.getRecapHistory(monthSubmit);
    for (var data in res!.data ?? []) {
      historyData.add(data);
    }
    print(historyData);
  }
}
