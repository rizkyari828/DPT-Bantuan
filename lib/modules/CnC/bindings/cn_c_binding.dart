import 'package:cleaner/modules/CnC/controllers/cn_c_detail_controller.dart';
import 'package:cleaner/modules/CnC/controllers/cn_c_list_controller.dart';
import 'package:get/get.dart';

import '../controllers/cn_c_controller.dart';

class CnCBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CnCController>(
      () => CnCController(apiRepository: Get.find()),
    );

    Get.lazyPut<CnCListController>(
      () => CnCListController(apiRepository: Get.find()),
    );

    Get.lazyPut<CnCDetailController>(
      () => CnCDetailController(apiRepository: Get.find()),
    );
  }
}
