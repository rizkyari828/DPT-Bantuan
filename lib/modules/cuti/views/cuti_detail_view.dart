import 'package:cleaner/modules/cuti/controllers/cuti_detail_controller.dart';
import 'package:cleaner/shared/shared.dart';
import 'package:cleaner/shared/widgets/approval.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CutiDetailView extends GetView<CutiDetailController> {
  final data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonWidget.appBar(title: 'Detail Cuti'),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidget.cardWithShadow(Column(
                children: [
                  ApprovalFlow.statusApproval(controller.detail.value),
                  SizedBox(height: 20.0),
                  CommonWidget.labelExpanded(
                      label: 'No Request',
                      value: controller.noRequestController.text),
                  SizedBox(height: 10.0),
                  CommonWidget.labelExpanded(
                      label: 'Tanggal Request',
                      value:
                          controller.detail.value.dateRequest.toString() != ''
                              ? DateFormat("EEEE, d MMMM yyyy", "id_ID")
                                  .format(controller.detail.value.dateRequest ??
                                      DateTime.now())
                                  .toString()
                              : ""),
                  SizedBox(height: 10.0),
                  CommonWidget.labelExpanded(
                      label: 'Client',
                      value: controller.detail.value.branchName ?? ''),
                  CommonWidget.labelExpanded(
                      label: 'Tipe Cuti',
                      value: controller.detail.value.leaveTypeName ?? ''),
                  SizedBox(height: 10.0),
                  CommonWidget.labelExpanded(
                      label: 'Tanggal Mulai',
                      value: controller.detail.value.dateStart.toString() != ''
                          ? DateFormat("EEEE, d MMMM yyyy", "id_ID")
                              .format(controller.detail.value.dateStart ??
                                  DateTime.now())
                              .toString()
                          : ""),
                  SizedBox(height: 10.0),
                  CommonWidget.labelExpanded(
                      label: 'Tanggal Selesai',
                      value: controller.detail.value.dateEnd.toString() != ''
                          ? DateFormat("EEEE, d MMMM yyyy", "id_ID")
                              .format(controller.detail.value.dateEnd ??
                                  DateTime.now())
                              .toString()
                          : ""),
                ],
              )),
              SizedBox(height: 20.0),
              CommonWidget.cardWithShadow(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidget.bodyText(text: "Keterangan"),
                  SizedBox(height: 10.0),
                  CommonWidget.bodyText(text: controller.noteController.text),
                  SizedBox(height: 20.0),
                  CommonWidget.bodyText(text: "Catatan Approval"),
                  SizedBox(height: 10.0),
                  controller.groupId.toString() != '5'
                      ? TextAreaField(
                          controller: controller.noteApprovalController,
                        )
                      : CommonWidget.bodyText(
                          text: controller.noteApprovalController.text),
                  SizedBox(height: 20.0),
                  SizedBox(height: 50.0),
                  Obx(() => ApprovalFlow.buttonApproval(controller)),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
