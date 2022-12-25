import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:konconeDeDe/api/api.dart';
import 'package:konconeDeDe/models/response/reliver/list_reliver_response.dart';
import 'package:konconeDeDe/models/response/user/users_response.dart';
import 'package:konconeDeDe/modules/home/home.dart';
import 'package:konconeDeDe/routes/app_pages.dart';
import 'package:konconeDeDe/shared/shared.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final ApiRepository apiRepository;
  HomeController({required this.apiRepository});
  var currentTab = MainTabs.home.obs;
  var users = Rxn<UsersResponse>();
  var user = Rxn<Datum>();
  var listEvent = <EventList>[].obs;
  late MainTab mainTab;
  late MeTab meTab;
  DateTime? selectedDate;
  RxString month =
      DateFormat("MMMM yyyy", "id_ID").format(DateTime.now()).toString().obs;
  RxString previousMonth = DateFormat("MMMM yyyy", "id_ID")
      .format(DateTime(
          DateTime.now().year, DateTime.now().month - 1, DateTime.now().day))
      .toString()
      .obs;
  String monthInt = DateFormat("MM", "id_ID").format(DateTime.now()).toString();
  String previousMonthInt = DateFormat("MM", "id_ID")
      .format(DateTime(
          DateTime.now().year, DateTime.now().month - 1, DateTime.now().day))
      .toString();
  RxString dateNow =
      DateFormat("dd MMMM yyyy", "id_ID").format(DateTime.now()).toString().obs;
  final searchNameController = TextEditingController();

  RxString monthSubmit =
      DateFormat("MM", "id_ID").format(DateTime.now()).toString().obs;
  RxString yearSubmit =
      DateFormat("yyyy", "id_ID").format(DateTime.now()).toString().obs;

  RxString name = "".obs;
  RxString nameKomandante = "".obs;
  RxString userId = "".obs;
  RxString idKomandante = "".obs;
  RxString profilePhoto = "".obs;
  RxString username = "".obs;
  RxString token = "".obs;
  RxBool showRateDialog = false.obs;
  RxBool isSearch = false.obs;
  ScrollController scrollController = ScrollController();

  var imageFileList = <XFile>[].obs;

  set _imageFile(XFile? value) {
    imageFileList.addAll((value == null ? null : <XFile>[value])!);
  }

  dynamic pickImageError;
  RxString? retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  late BuildContext context;

  double position = 0;
  RxInt page = 0.obs;

  @override
  void onInit() async {
    super.onInit();

    mainTab = MainTab();
    loadUsers();
    meTab = MeTab();
    getData(page.value);

    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   if (message.data.containsKey('type')) {
    //     if (message.data['type'] == 'izin') {
    //       Get.toNamed(Routes.LEAVE);
    //     } else if (message.data['type'] == 'cuti') {
    //       Get.toNamed(Routes.BENEFIT);
    //     } else if (message.data['type'] == 'overtime') {
    //       Get.toNamed(Routes.PROSPEK);
    //     } else if (message.data['type'] == 'task') {
    //       Get.toNamed(Routes.HOME);
    //     } else {
    //       Get.toNamed(Routes.HOME);
    //     }
    //   }
    // });
  }

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  Future<void> onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    listEvent.clear();
    page.value = 0;
    getData(page.value);
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    page.value = page.value + 1;

    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    getData(page.value);
    refreshController.loadComplete();
  }

  void onSearch(status) {
    isSearch.value = status;
  }

  void goToDetailPages({String id = ""}) {
    Get.toNamed(Routes.DETAIL_EVENT, arguments: id);
  }

  void getData(page) async {
    monthSubmit.value = selectedDate == null
        ? ''
        : DateFormat("MM", "id_ID")
            .format(selectedDate ?? DateTime.now())
            .toString();
    yearSubmit.value = selectedDate == null
        ? ''
        : DateFormat("yyyy", "id_ID")
            .format(selectedDate ?? DateTime.now())
            .toString();
    final res = await apiRepository.listEvent(
        page: page,
        idKomandante: idKomandante.value,
        keyword: searchNameController.text,
        month: monthSubmit.value,
        year: yearSubmit.value);
    listEvent.addAll(res?.data ?? []);
  }

  loadUsers() async {
    var prefs = Get.find<SharedPreferences>();
    name.value = prefs.getString('name') ?? "";
    nameKomandante.value = prefs.getString('nameKomandante') ?? "";
    userId.value = prefs.getString('userId') ?? "";
    profilePhoto.value = prefs.getString('profilePhoto') ?? "";
    username.value = prefs.getString('username') ?? "";
    token.value = prefs.getString('token') ?? "";
    userId.value = prefs.getString('userId') ?? "";
    idKomandante.value = prefs.getString('idKomandante') ?? "";
  }

  void signout() async {
    EasyLoading.show(status: 'loading..');
    await Future.delayed(Duration(milliseconds: 3000));
    var storage = Get.find<SharedPreferences>();
    try {
      if (storage.getString(StorageConstants.token) != null) {
        storage.clear();
        // NavigatorHelper.popLastScreens(popCount: 1);
        goToLoginPages();
        EasyLoading.dismiss();
      } else {
        storage.clear();
        // NavigatorHelper.popLastScreens(popCount: 1);
        goToLoginPages();
        EasyLoading.dismiss();
      }
    } catch (e) {
      storage.clear();
      // NavigatorHelper.popLastScreens(popCount: 1);
      goToLoginPages();
      EasyLoading.dismiss();
    }
  }

  Future<void> onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    imageFileList.clear();
    if (isMultiImage) {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final List<XFile>? pickedFileList = await _picker.pickMultiImage(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );

          imageFileList.addAll(pickedFileList!);
        } catch (e) {
          pickImageError = e;
        }
      });
    } else {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final XFile? pickedFile = await _picker.pickImage(
            source: source,
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );

          _imageFile = pickedFile;
        } catch (e) {
          pickImageError = e;
        }
      });
    }
  }

  Future<void> _displayPickImageDialog(BuildContext context, onPick) async {
    return onPick(200.0, 200.0, 50);
  }

  void switchTab(index) {
    var tab = _getCurrentTab(index);
    currentTab.value = tab;
  }

  int getCurrentIndex(MainTabs tab) {
    switch (tab) {
      case MainTabs.home:
        return 0;
      case MainTabs.me:
        return 1;
      default:
        return 0;
    }
  }

  MainTabs _getCurrentTab(int index) {
    switch (index) {
      case 0:
        return MainTabs.home;
      case 1:
        return MainTabs.me;
      default:
        return MainTabs.home;
    }
  }

  void goToLoginPages() {
    Get.offAllNamed(Routes.SPLASH);
  }

  void goToLeavePages() {
    Get.toNamed(Routes.LEAVE);
  }

  void goToLemburPages(String month, String type, String status,
      {bool needBack = true}) {
    if (needBack) {
      Get.back();
    }
    Get.toNamed(Routes.PROSPEK,
        arguments: {'month': month, 'type': type, 'status': status});
  }

  void goToBenefitPages() {
    Get.toNamed(Routes.BENEFIT);
  }

  void goToRecapPages() {
    Get.toNamed(Routes.RECAP);
  }

  void goToEventPages() {
    Get.toNamed(Routes.EVENT);
  }

  void goToNotificationPages() {
    Get.toNamed(Routes.NOTIFICATION);
  }

  void goToTaskListPages() {
    Get.toNamed(Routes.HOME);
  }

  void goToDetailEventPages({String id = ""}) {
    Get.toNamed(Routes.DETAIL_EVENT, arguments: id);
  }

  void goToScannerPages() {
    Get.toNamed(Routes.QRSCANNER, arguments: null);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
