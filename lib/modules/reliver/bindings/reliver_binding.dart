import 'package:cleaner/modules/reliver/controllers/reliver_add_controller.dart';
import 'package:cleaner/modules/reliver/controllers/reliver_detail_controller.dart';
import 'package:get/get.dart';

import '../controllers/reliver_controller.dart';

class ReliverBinding extends Bindings {
  @override
  void dependencies() {
       Get.lazyPut<ReliverController>(
      () => ReliverController(apiRepository: Get.find()),
    );

    Get.lazyPut<ReliverAddController>(
      () => ReliverAddController(apiRepository: Get.find()),
    );

    Get.lazyPut<ReliverDetailController>(
      () => ReliverDetailController(apiRepository: Get.find()),
    );
  }
}
