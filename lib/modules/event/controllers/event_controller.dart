import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:konconeDeDe/api/api_repository.dart';
import 'package:konconeDeDe/models/response/penerima_list_response.dart';
import 'package:konconeDeDe/models/response/reliver/list_reliver_response.dart';
import 'package:konconeDeDe/models/response/reliver/show_reliver_response.dart';
import 'package:konconeDeDe/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventController extends GetxController {
  final argm = Get.arguments;
  var detail = DataShowReliver().obs;

  final ApiRepository apiRepository;
  EventController({required this.apiRepository});

  var listEvent = <EventList>[].obs;
  var listPenerima = <Penerima>[].obs;
  RxString groupName = "".obs;
  RxString groupId = "".obs;
  final searchNameController = TextEditingController();
  RxInt page = 0.obs;
  DateTime? selectedDate;
  RxString month =
      DateFormat("MMMM yyyy", "id_ID").format(DateTime.now()).toString().obs;
  RxBool isSearch = false.obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onLoading() async {
    page.value = page.value + 1;

    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    getData(page.value);
    refreshController.loadComplete();
  }

  @override
  void onInit() {
    super.onInit();
    detail.value = argm['detail'];
  }

  @override
  void onReady() {
    super.onReady();
    loadUsers();
    getData(page.value);
  }

  loadUsers() async {
    var prefs = Get.find<SharedPreferences>();
    groupName.value = prefs.getString('groupName') ?? "";
    groupId.value = prefs.getString('groupId') ?? "";
  }

  void onSearch(status) {
    isSearch.value = status;
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getData(page) async {
    final res = await apiRepository.listPenerima(
        page: page, idCampaignProses: argm['id'] ?? '');
    listPenerima.addAll(res?.data ?? []);
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    listPenerima.clear();
    page.value = 0;
    getData(page.value);
    refreshController.refreshCompleted();
  }

  void goToDetailPages({String id = ""}) {
    Get.toNamed(Routes.DETAIL_EVENT, arguments: id);
  }
}
