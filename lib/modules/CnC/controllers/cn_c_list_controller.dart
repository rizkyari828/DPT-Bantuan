import 'package:cleaner/api/api_repository.dart';
import 'package:cleaner/models/response/cnc/list.dart';
import 'package:cleaner/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CnCListController extends GetxController {
  final ApiRepository apiRepository;
  CnCListController({required this.apiRepository});

  var listCnC = <ListCnC>[].obs;
  RxString groupName = "".obs;
  RxString groupId = "".obs;

  RxInt page = 1.obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onLoading() async {
    page.value = page.value + 1;

    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    getCnC(page.value);
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
    getCnC(page.value);
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

  void getCnC(page) async {
    final res = await apiRepository.listCnC(page: page);
    listCnC.addAll(res?.data ?? []);
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    listCnC.clear();
    page.value = 1;
    getCnC(page.value);
    refreshController.refreshCompleted();
  }

  void goToDetailCnCPages({String id = ""}) {
    Get.toNamed(Routes.DETAIL_CNC, arguments: id);
  }

  void goToAddCnCPages() {
    Get.toNamed(Routes.ADD_CNC);
  }
}
