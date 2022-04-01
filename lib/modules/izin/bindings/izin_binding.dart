import 'package:cleaner/modules/izin/controllers/izin_detail_controller.dart';
import 'package:cleaner/modules/izin/controllers/izin_list_controller.dart';
import 'package:get/get.dart';

import '../controllers/izin_controller.dart';

class IzinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IzinController>(
      () => IzinController(apiRepository: Get.find()),
    );

    Get.lazyPut<IzinListController>(
      () => IzinListController(apiRepository: Get.find()),
    );

    Get.lazyPut<IzinDetailController>(
      () => IzinDetailController(apiRepository: Get.find()),
    );
  }
}
