import 'package:cleaner/modules/task_list/controllers/korlap/tad/task_list_tad_korlap_detail_controller.dart';
import 'package:cleaner/modules/task_list/controllers/korlap/tad/task_list_tad_korlap_list_controller.dart';
import 'package:cleaner/modules/task_list/controllers/korlap/task_list_detail_korlap_controller.dart';
import 'package:cleaner/modules/task_list/controllers/task_list_add_controller.dart';
import 'package:cleaner/modules/task_list/controllers/task_list_detail_controller.dart';
import 'package:get/get.dart';

import '../controllers/task_list_controller.dart';

class TaskListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskListController>(
      () => TaskListController(apiRepository: Get.find()),
    );

    Get.lazyPut<TaskListAddController>(
      () => TaskListAddController(apiRepository: Get.find()),
    );

    Get.lazyPut<TaskListDetailController>(
      () => TaskListDetailController(apiRepository: Get.find()),
    );

    Get.lazyPut<TaskListDetailKorlapController>(
      () => TaskListDetailKorlapController(apiRepository: Get.find()),
    );

    Get.lazyPut<ListTaskListTadKorlapController>(
      () => ListTaskListTadKorlapController(apiRepository: Get.find()),
    );

    Get.lazyPut<DetailTaskListTadKorlapController>(
      () => DetailTaskListTadKorlapController(apiRepository: Get.find()),
    );
  }
}
