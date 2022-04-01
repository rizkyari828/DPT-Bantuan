import 'package:cleaner/modules/cuti/controllers/cuti_add_controller.dart';
import 'package:cleaner/modules/cuti/controllers/cuti_detail_controller.dart';
import 'package:get/get.dart';

import '../controllers/cuti_controller.dart';

class CutiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CutiController>(
      () => CutiController(apiRepository: Get.find()),
    );

    Get.lazyPut<CutiDetailController>(
      () => CutiDetailController(apiRepository: Get.find()),
    );

    Get.lazyPut<CutiAddController>(
      () => CutiAddController(apiRepository: Get.find()),
    );
  }
}
