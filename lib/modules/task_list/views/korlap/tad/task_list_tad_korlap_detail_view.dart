import 'package:cleaner/modules/task_list/controllers/korlap/tad/task_list_tad_korlap_detail_controller.dart';
import 'package:cleaner/shared/shared.dart';
import 'package:cleaner/shared/widgets/approval.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskListTadKorlapDetailView
    extends GetView<DetailTaskListTadKorlapController> {
  final data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonWidget.appBar(title: 'Detail Task List TAD'),
      body: SingleChildScrollView(
        child: Obx(
          () => controller.detail.value.id == null
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidget.cardWithShadow(Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ApprovalFlow.statusApproval(controller.detail.value),
                        SizedBox(height: 20.0),
                        CommonWidget.minHeadText(text: "Kebutuhan"),
                        SizedBox(height: 20.0),
                        CommonWidget.labelExpanded(
                            label: 'Waktu Mulai',
                            value: controller.detail.value.startTime),
                        SizedBox(height: 10.0),
                        CommonWidget.labelExpanded(
                            label: 'Waktu Selesai',
                            value: controller.detail.value.endTime),
                        SizedBox(height: 10.0),
                        CommonWidget.labelExpanded(
                            label: 'Client',
                            value: controller.detail.value.branch?.name ?? ''),
                        SizedBox(height: 10.0),
                        CommonWidget.labelExpanded(
                            label: 'Penempatan',
                            value:
                                controller.detail.value.branch?.building ?? ''),
                        SizedBox(height: 10.0),
                      ],
                    )),
                    SizedBox(height: 20.0),
                    CommonWidget.cardWithShadow(Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonWidget.minHeadText(
                            text:
                                "Task ${controller.detail.value.task?.taskType?.name}"),
                        SizedBox(height: 20.0),
                        CommonWidget.labelExpanded(
                            label: 'Nama Task',
                            value: controller.detail.value.task?.name),
                        SizedBox(height: 10.0),
                        CommonWidget.bodyText(text: "Sebelum"),
                        controller.detail.value.beforePhotos.isNotEmpty
                            ? dokumenPhoto(controller, 'before')
                            : CommonWidget.subtitleText(
                                text: "Belum ada dokumen"),
                        SizedBox(height: 10.0),
                        CommonWidget.bodyText(text: "Sesudah"),
                        controller.detail.value.afterPhotos.isNotEmpty
                            ? dokumenPhoto(controller, 'after')
                            : CommonWidget.subtitleText(
                                text: "Belum ada dokumen"),
                        SizedBox(height: 10.0),
                      ],
                    )),
                  ],
                ),
        ),
      ),
    );
  }

  Widget dokumenPhoto(
      DetailTaskListTadKorlapController controller, String type) {
    return Container(
      child: Card(
        elevation: 0.1,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Colors.grey, width: 1)),
        child: Container(
          height: 220,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: type == 'before'
                  ? controller.detail.value.beforePhotos.length
                  : controller.detail.value.afterPhotos.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Column(
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          child: type == 'before'
                              ? Image.network(controller
                                      .detail.value.beforePhotos[index] ??
                                  '')
                              : Image.network(
                                  controller.detail.value.afterPhotos[index] ??
                                      ''),
                        ),
                      ],
                    ));
              },
            ),
          ),
        ),
      ),
    );
  }
}
