import 'package:cleaner/modules/lembur/controllers/lembur_add_controller.dart';
import 'package:cleaner/modules/lembur/controllers/lembur_detail_controller.dart';
import 'package:get/get.dart';

import '../controllers/lembur_controller.dart';

class LemburBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LemburController>(
      () => LemburController(apiRepository: Get.find()),
    );

     Get.lazyPut<LemburDetailController>(
      () => LemburDetailController(apiRepository: Get.find()),
    );

    Get.lazyPut<LemburAddController>(
      () => LemburAddController(apiRepository: Get.find()),
    );
  }
}
