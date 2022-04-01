import 'package:cleaner/modules/izin/controllers/izin_detail_controller.dart';
import 'package:cleaner/shared/shared.dart';
import 'package:cleaner/shared/widgets/approval.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class IzinDetailView extends GetView<IzinDetailController> {
  final data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    final sw = SizeConfig().screenWidth;
    final sh = SizeConfig().screenHeight;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonWidget.appBar(title: 'Detail Izin'),
      body: Obx(() => controller.detail.value.dateRequest != null
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidget.cardWithShadow(Column(
                    children: [
                      ApprovalFlow.statusApproval(controller.detail.value),
                      SizedBox(height: 20.0),
                      CommonWidget.labelExpanded(
                          label: 'No Request',
                          value: controller.noRequestController.text +
                              controller.detail.value.id.toString()),
                      SizedBox(height: 10.0),
                      CommonWidget.labelExpanded(
                          label: 'Tanggal Request',
                          value: controller.detail.value.dateRequest
                                      .toString() !=
                                  ''
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
                          value: controller.detail.value.dateStart.toString() !=
                                  ''
                              ? DateFormat("EEEE, d MMMM yyyy", "id_ID")
                                  .format(controller.detail.value.dateStart ??
                                      DateTime.now())
                                  .toString()
                              : ""),
                      SizedBox(height: 10.0),
                      CommonWidget.labelExpanded(
                          label: 'Tanggal Selesai',
                          value:
                              controller.detail.value.dateEnd.toString() != ''
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
                      CommonWidget.bodyText(
                          text: controller.noteController.text),
                      SizedBox(height: 20.0),
                      CommonWidget.bodyText(text: "Catatan Approval"),
                      SizedBox(height: 10.0),
                      controller.groupId.toString() != '5'
                          ? TextAreaField(
                              controller: controller.noteApprovalController,
                            )
                          : CommonWidget.bodyText(
                              text: controller.noteApprovalController.text),
                    ],
                  )),
                  SizedBox(height: 20.0),
                  CommonWidget.cardWithShadow(Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonWidget.bodyText(text: "Dokumen"),
                      SizedBox(height: 10.0),
                      dokumenPhoto(controller),
                      SizedBox(height: 30.0),
                      Obx(() => ApprovalFlow.buttonApproval(controller)),
                    ],
                  ))
                ],
              ),
            )
          : Container()),
    );
  }

  Widget dokumenPhoto(IzinDetailController controller) {
    final sw = SizeConfig().screenWidth;
    final sh = SizeConfig().screenHeight;
    return Container(
      child: Card(
        elevation: 0.1,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Colors.grey, width: 1)),
        child: Container(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.count(
                key: UniqueKey(),
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 10.0,
                shrinkWrap: true,
                children: List.generate(
                  controller.detail.value.documents!.length,
                  (index) {
                    return Semantics(
                      onTap: () {
                        // FullScreenImage();
                      },
                      label: 'image_picker_example_picked_image',
                      child: Image.network(
                          controller.detail.value.documents?[index] ?? ''),
                    );
                  },
                )),
          ),
        ),
      ),
    );
  }
}
