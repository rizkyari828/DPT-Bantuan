import 'package:cleaner/api/api_repository.dart';
import 'package:cleaner/models/response/izin/list_izin.dart';
import 'package:cleaner/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IzinListController extends GetxController {
  final ApiRepository apiRepository;
  IzinListController({required this.apiRepository});

  var listIzin = <DataIzin>[].obs;
  RxString groupName = "".obs;
  RxString groupId = "".obs;

  RxInt page = 1.obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onLoading() async {
    page.value = page.value + 1;

    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    getIzin(page.value);
    refreshController.loadComplete();
  }

  @override
  void onInit() {
    super.onInit();
    // getCnC();
  }

  @override
  void onReady() {
    super.onReady();
    getIzin(page.value);
    loadUsers();
  }

  loadUsers() async {
    var prefs = Get.find<SharedPreferences>();
    groupName.value = prefs.getString('groupName') ?? "";
    groupId.value = prefs.getString('groupId') ?? "";
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getIzin(page) async {
    final res = await apiRepository.listIzin(page: page);
    listIzin.addAll(res?.data ?? []);
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    listIzin.clear();
    page.value = 1;
    getIzin(page.value);
    refreshController.refreshCompleted();
  }

  void goToDetailPages({String id = ""}) {
    Get.toNamed(Routes.DETAIL_IZIN, arguments: id);
  }

  void goToAddPages() {
    Get.toNamed(Routes.ADD_IZIN);
  }
}
