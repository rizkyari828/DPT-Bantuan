import 'package:konconeDeDe/modules/event/controllers/event_detail_controller.dart';
import 'package:get/get.dart';
import 'package:konconeDeDe/modules/event/controllers/qr_code_controller.dart';

import '../controllers/event_controller.dart';

class EventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventController>(
      () => EventController(apiRepository: Get.find()),
    );

    Get.lazyPut<ReliverDetailController>(
      () => ReliverDetailController(apiRepository: Get.find()),
    );

    Get.lazyPut<QRCodeController>(
      () => QRCodeController(apiRepository: Get.find()),
    );
  }
}
