import 'package:cleaner/api/api_repository.dart';
import 'package:cleaner/models/response/taskList/tad/task_list_tad_response.dart';
import 'package:cleaner/models/response/taskList/task_list_response.dart';
import 'package:cleaner/routes/app_pages.dart';
import 'package:cleaner/shared/shared.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskListController extends GetxController {
  final ApiRepository apiRepository;
  TaskListController({required this.apiRepository});

  var list = <TaskListData>[].obs;
  var listTad = <TaskListTadData>[].obs;
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
    loadUsers();
    getData(page.value);
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
    print(groupId.value);
    if (groupId.value == '5') {
      final res = await apiRepository.taskListTad(page: page);
      listTad.addAll(res?.data ?? []);
    } else {
      final res = await apiRepository.taskList(page: page);
      list.addAll(res?.data ?? []);
    }
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    list.clear();
    listTad.clear();
    page.value = 1;
    getData(page.value);
    refreshController.refreshCompleted();
  }

  void goToDetailPages({String taskId = "", String typeId = ''}) {
    Get.toNamed(Routes.TASK_LIST_DETAIL,
        arguments: {'taskId': taskId, 'typeId': typeId});
  }

  void goToDetailKorlapPages(
      {String taskId = "", String typeId = '', String action = 'show'}) {
    Get.toNamed(Routes.TASK_LIST_KORLAP_DETAIL,
        arguments: {'taskId': taskId, 'typeId': typeId, 'action': action});
  }

  void delete({String taskId = "", String typeId = ''}) async {
    final res = await apiRepository.deleteTaskList(taskId, typeId);
    if (res!.error == false) {
      EasyLoading.showSuccess(res.message.toString());
      onRefresh();
      Get.back();
    } else {
      EasyLoading.showError('Gagal disimpan');
      Get.back();
    }
  }

  void goToAddPages() {
    Get.toNamed(Routes.TASK_LIST_ADD);
  }

  void alertDelete({String taskId = "", String typeId = ''}) {
    Get.defaultDialog(
      title: "Konfirmasi",
      content: CommonWidget.bodyText(
        text: "Apakah anda yakin ingin menghapus data ini?",
      ),
      textConfirm: 'Hapus',
      textCancel: 'Batal',
      onCancel: () {},
      onConfirm: () {
        delete(taskId: taskId, typeId: typeId);
      },
    );
  }
}
