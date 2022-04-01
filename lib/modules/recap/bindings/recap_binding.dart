import 'package:get/get.dart';

import '../controllers/recap_controller.dart';

class RecapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecapController>(
      () => RecapController(apiRepository: Get.find()),
    );
  }
}
