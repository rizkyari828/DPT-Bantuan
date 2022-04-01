import 'package:cleaner/api/api_repository.dart';
import 'package:cleaner/models/response/overtime/list.dart';
import 'package:cleaner/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LemburController extends GetxController {
  final ApiRepository apiRepository;
  LemburController({required this.apiRepository});

  var listOvertime = <DataOvertime>[].obs;
  RxString groupName = "".obs;
  RxString groupId = "".obs;

  RxInt page = 1.obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onLoading() async {
    page.value = page.value + 1;

    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    getOvertime(page.value);
    refreshController.loadComplete();
  }

  @override
  void onInit() {
    super.onInit();
    // getOvertime();
  }

  @override
  void onReady() {
    super.onReady();
    getOvertime(page.value);
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

  void getOvertime(page) async {
    final res = await apiRepository.listOvertime(page: page);
    listOvertime.addAll(res?.data ?? []);
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    listOvertime.clear();
    page.value = 1;
    getOvertime(page.value);
    refreshController.refreshCompleted();
  }

  void goToDetailPages({String id = ""}) {
    Get.toNamed(Routes.DETAIL_LEMBUR, arguments: id);
  }

  void goToAddPages() {
    Get.toNamed(Routes.ADD_LEMBUR);
  }
}
