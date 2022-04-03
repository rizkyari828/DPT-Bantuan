import 'package:cleaner/modules/task_list/controllers/task_list_controller.dart';
import 'package:cleaner/shared/widgets/approval.dart';
import 'package:cleaner/shared/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../shared/shared.dart';

class TaskListTab extends GetView<TaskListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'Task List Hari Ini',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20,
              fontFamily: 'Poppins',
            ),
          ),
          backgroundColor: ColorConstants.mainColor,
          elevation: 0.0,
          actions: [
            Obx(() => ApprovalFlow.addButtonApproval(
                controller: controller,
                onPressed: controller.goToAddPages,
                showId: '4'))
          ],
          automaticallyImplyLeading: false,
        ),
        body: Obx(() => controller.groupId.value == '5'
            ? _getItemsTad(controller)
            : _getItems(controller)));
  }

  SmartRefresher _getItems(TaskListController controller) {
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
              controller.goToDetailKorlapPages(
                  taskId: controller.list[i].id.toString(),
                  typeId: controller.list[i].task!.taskType!.id.toString(),
                  action: 'show');
            },
            child: CustomExpandedCardView(
              firstParagraf: controller.list[i].task?.name ?? '',
              secondParagrafLabel: 'Mulai ',
              secondParagrafValue: controller.list[i].startTime.toString() +
                  ' - ' +
                  controller.list[i].endTime.toString(),
              thirdParagrafLabel: 'Type ',
              thirdParagrafValue: controller.list[i].task?.taskType?.name ?? '',
              forthParagraf:
                  '${DateFormat("EEEE, d MMMM yyyy", "id_ID").format(controller.list[i].task?.createdAt ?? DateTime.now())}',
              updateDelete: true,
              onPressedEdit: () {
                controller.goToDetailKorlapPages(
                  taskId: controller.list[i].id.toString(),
                  typeId: controller.list[i].task!.taskType!.id.toString(),
                  action: 'edit',
                );
              },
              onPressedDelete: () {
                controller.alertDelete(
                    taskId: controller.list[i].id.toString(),
                    typeId: controller.list[i].task!.taskType!.id.toString());
              },
            )),
      ),
    );
  }

  SmartRefresher _getItemsTad(TaskListController controller) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoading: controller.onLoading,
      child: ListView.builder(
        itemCount: controller.listTad.length,
        itemBuilder: (context, i) => InkWell(
          onTap: () {
            controller.goToDetailPages(
              taskId: controller.listTad[i].id.toString(),
              typeId: controller.listTad[i].task!.taskType!.id.toString(),
            );
          },
          child: CustomExpandedCardView(
            firstParagraf: controller.listTad[i].task?.name ?? '',
            secondParagrafLabel: 'Mulai ',
            secondParagrafValue: controller.listTad[i].startTime.toString() +
                controller.listTad[i].endTime.toString(),
            thirdParagrafLabel: 'Type ',
            thirdParagrafValue:
                controller.listTad[i].task?.taskType?.name ?? '',
            forthParagraf:
                '${DateFormat("EEEE, d MMMM yyyy", "id_ID").format(controller.listTad[i].task?.taskType?.createdAt ?? DateTime.now())}',
            approval:
                controller.listTad[i].statusLabel == 'Waiting for approval'
                    ? 'Waiting'
                    : controller.listTad[i].statusLabel ?? '',
          ),
        ),
      ),
    );
  }
}
