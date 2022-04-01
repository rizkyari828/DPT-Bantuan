import 'package:cleaner/api/api_repository.dart';
import 'package:cleaner/models/response/reliver/list_reliver_response.dart';
import 'package:cleaner/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReliverController extends GetxController {
  final ApiRepository apiRepository;
  ReliverController({required this.apiRepository});

  var listReliver = <DataListReliver>[].obs;
  RxString groupName = "".obs;
  RxString groupId = "".obs;

  RxInt page = 1.obs;
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
    // getCnC();
  }

  @override
  void onReady() {
    super.onReady();
    getData(page.value);
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

  void getData(page) async {
    final res = await apiRepository.listReliver(page: page);
    listReliver.addAll(res?.data ?? []);
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    listReliver.clear();
    page.value = 1;
    getData(page.value);
    refreshController.refreshCompleted();
  }

  void goToDetailPages({String id = ""}) {
    Get.toNamed(Routes.DETAIL_RELIVER, arguments: id);
  }

  void goToAddPages() {
    Get.toNamed(Routes.ADD_RELIVER);
  }
}
