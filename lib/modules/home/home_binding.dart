import 'package:cleaner/modules/home/attendance/attendance_controller.dart';
import 'package:cleaner/modules/task_list/controllers/task_list_controller.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
        () => HomeController(apiRepository: Get.find()));
    Get.lazyPut<AttendanceController>(
        () => AttendanceController(apiRepository: Get.find()));
    Get.lazyPut<TaskListController>(
        () => TaskListController(apiRepository: Get.find()));
  }
}
