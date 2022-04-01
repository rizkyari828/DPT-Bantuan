import 'package:cleaner/modules/izin/controllers/izin_detail_controller.dart';
import 'package:cleaner/modules/reliver/controllers/reliver_detail_controller.dart';
import 'package:cleaner/shared/shared.dart';
import 'package:cleaner/shared/widgets/approval.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReliverDetailView extends GetView<ReliverDetailController> {
  final data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    final sw = SizeConfig().screenWidth;
    final sh = SizeConfig().screenHeight;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonWidget.appBar(title: 'Detail Reliver'),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
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
                      label: 'No Request',
                      value: controller.noRequestController.text +
                          controller.detail.value.id.toString()),
                  SizedBox(height: 10.0),
                  CommonWidget.labelExpanded(
                      label: 'Tanggal Pengajuan',
                      value:
                          controller.detail.value.dateRequest.toString() != ''
                              ? DateFormat("EEEE, d MMMM yyyy", "id_ID")
                                  .format(controller.detail.value.dateRequest ??
                                      DateTime.now())
                                  .toString()
                              : ""),
                  // SizedBox(height: 10.0),
                  // CommonWidget.labelExpanded(
                  //     label: 'Karyawan',
                  //     value: controller.detail.value.branchName ?? ''),
                  SizedBox(height: 10.0),
                  CommonWidget.labelExpanded(
                      label: 'Client',
                      value: controller.detail.value.branch?.name ?? ''),
                  SizedBox(height: 10.0),
                  CommonWidget.labelExpanded(
                      label: 'Tanggal Mulai',
                      value: controller.detail.value.dateNeeded.toString() != ''
                          ? DateFormat("EEEE, d MMMM yyyy", "id_ID")
                              .format(controller.detail.value.dateNeeded ??
                                  DateTime.now())
                              .toString()
                          : ""),
                  SizedBox(height: 10.0),
                  CommonWidget.labelExpanded(
                      label: 'Tanggal Selesai',
                      value: controller.detail.value.dateEndNeeded.toString() !=
                              ''
                          ? DateFormat("EEEE, d MMMM yyyy", "id_ID")
                              .format(controller.detail.value.dateEndNeeded ??
                                  DateTime.now())
                              .toString()
                          : ""),
                  SizedBox(height: 10.0),
                  CommonWidget.bodyText(text: "Keterangan"),
                  SizedBox(height: 10.0),
                  CommonWidget.bodyText(text: controller.noteController.text),
                ],
              )),
              SizedBox(height: 20.0),
              CommonWidget.cardWithShadow(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidget.minHeadText(text: "Reliver"),
                  SizedBox(height: 20.0),
                  CommonWidget.widgetExpanded(
                    left: CommonWidget.bodyText(text: "Jumlah Kebutuhan"),
                    right: InputInputField(
                      keyboardType: TextInputType.number,
                      controller: controller.numberReliver,
                      labelText: "Jumlah Kebutuhan",
                    ),
                  ),
                  SizedBox(height: 10.0),
                  CommonWidget.widgetExpanded(
                    left: CommonWidget.bodyText(text: "Tanggal Bekerja"),
                    right: InputInputField(
                      isSuffixIcon: true,
                      suffixIcon: Icon(Icons.calendar_today_rounded),
                      controller: controller.dateStartWorkController,
                      labelText: "Tanggal Bekerja",
                      onSuffixPressed: () {
                        controller.selectDate(context);
                      },
                    ),
                  ),
                  SizedBox(height: 10.0),
                  CommonWidget.bodyText(text: "Catatan Approval"),
                  SizedBox(height: 10.0),
                  controller.groupId.toString() != '5'
                      ? TextAreaField(
                          controller: controller.noteApprovalController,
                        )
                      : CommonWidget.bodyText(
                          text: controller.noteApprovalController.text),
                  SizedBox(height: 30.0),
                  Obx(() => ApprovalFlow.buttonApproval(controller)),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
