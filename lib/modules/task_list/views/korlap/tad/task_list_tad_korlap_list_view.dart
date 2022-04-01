import 'package:cleaner/modules/task_list/controllers/korlap/tad/task_list_tad_korlap_list_controller.dart';
import 'package:cleaner/shared/constants/constants.dart';
import 'package:cleaner/shared/widgets/custom_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListTaskListTadKorlapView
    extends GetView<ListTaskListTadKorlapController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'Task List TAD',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20,
              fontFamily: 'Poppins',
            ),
          ),
          backgroundColor: ColorConstants.mainColor,
          elevation: 0.0,
        ),
        body: Obx(() => _getItems(controller)));
  }

  SmartRefresher _getItems(ListTaskListTadKorlapController controller) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoading: controller.onLoading,
      child: ListView.builder(
        itemCount: controller.list.length,
        itemBuilder: (context, i) => InkWell(
          onTap: () {
            controller.goToDetailPages(id: controller.list[i].id.toString());
          },
          child: CustomExpandedCardView(
            firstParagraf: controller.list[i].task?.name ?? '',
            secondParagrafLabel: 'Mulai ',
            secondParagrafValue: controller.list[i].startTime.toString() +
                controller.list[i].endTime.toString(),
            thirdParagrafLabel: 'Type ',
            thirdParagrafValue: controller.list[i].task?.taskType?.name ?? '',
            forthParagraf:
                '${DateFormat("EEEE, d MMMM yyyy", "id_ID").format(controller.list[i].task?.taskType?.createdAt ?? DateTime.now())}',
            approval: controller.list[i].statusLabel == 'Waiting for approval'
                ? 'Waiting'
                : controller.list[i].statusLabel ?? '',
          ),
        ),
      ),
    );
  }
}
