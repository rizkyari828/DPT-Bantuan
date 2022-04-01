import 'package:cleaner/modules/task_list/controllers/task_list_detail_controller.dart';
import 'package:cleaner/shared/shared.dart';
import 'package:cleaner/shared/widgets/approval.dart';
import 'package:cleaner/shared/widgets/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskListDetailView extends GetView<TaskListDetailController> {
  final data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    final sh = SizeConfig().screenHeight;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonWidget.appBar(title: 'Detail Task List'),
      body: Obx(
        () => Container(height: sh, child: stepper(context)),
      ),
    );
  }

  Widget finished() {
    return Column(
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
                value: controller.detail.value.task?.createdAt.toString() != ''
                    ? DateFormat("EEEE, d MMMM yyyy", "id_ID")
                        .format(controller.detail.value.task?.createdAt ??
                            DateTime.now())
                        .toString()
                    : ""),
            SizedBox(height: 10.0),
            CommonWidget.labelExpanded(
                label: 'Client',
                value: controller.detail.value.branch?.name ?? ''),
            // CommonWidget.labelExpanded(
            //     label: 'Tipe Cuti',
            //     value: controller.detail.value.leaveTypeName ?? ''),
            // SizedBox(height: 10.0),
            // CommonWidget.labelExpanded(
            //     label: 'Tanggal Mulai',
            //     value: controller.detail.value.dateStart.toString() != ''
            //         ? DateFormat("EEEE, d MMMM yyyy", "id_ID")
            //             .format(
            //                 controller.detail.value.dateStart ?? DateTime.now())
            //             .toString()
            //         : ""),
            // SizedBox(height: 10.0),
            // CommonWidget.labelExpanded(
            //     label: 'Tanggal Selesai',
            //     value: controller.detail.value.dateEnd.toString() != ''
            //         ? DateFormat("EEEE, d MMMM yyyy", "id_ID")
            //             .format(
            //                 controller.detail.value.dateEnd ?? DateTime.now())
            //             .toString()
            //         : ""),
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
          ],
        )),
        SizedBox(height: 20.0),
        CommonWidget.cardWithShadow(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidget.bodyText(text: "Dokumen"),
            SizedBox(height: 10.0),
            // dokumenPhotoBefore(controller),
            SizedBox(height: 30.0),
            Obx(() => ApprovalFlow.buttonApproval(controller)),
          ],
        ))
      ],
    );
  }

  Widget dokumenPhoto(TaskListDetailController controller, String type) {
    return Container(
      child: Card(
        elevation: 0.1,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Colors.grey, width: 1)),
        child: Container(
          height: 100,
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
                    child: Container(
                      width: 50,
                      height: 50,
                      child: type == 'before'
                          ? Image.network(
                              controller.detail.value.beforePhotos[index] ?? '')
                          : Image.network(
                              controller.detail.value.afterPhotos[index] ?? ''),
                    ));
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget stepper(context) {
    return Stepper(
      elevation: 1,
      // margin: EdgeInsets.all(0),
      type: controller.stepperType.value,
      physics: ScrollPhysics(),
      currentStep: controller.currentStep.value,
      onStepTapped: (step) => controller.tapped(step),
      onStepContinue: controller.continued,
      onStepCancel: controller.cancel,
      steps: <Step>[
        Step(
          title: CommonWidget.bodyText(text: "Rencana"),
          content: rencanaStep(context),
          isActive: controller.currentStep >= 0,
          state: controller.currentStep >= 0
              ? StepState.complete
              : StepState.disabled,
        ),
        Step(
          title: CommonWidget.bodyText(text: "Pengerjaan"),
          content: pengerjaanStep(context),
          isActive: controller.currentStep >= 0,
          state: controller.currentStep >= 1
              ? StepState.complete
              : StepState.disabled,
        ),
        Step(
          title: CommonWidget.bodyText(text: "Selesai"),
          content: selesaiStep(context),
          isActive: controller.currentStep >= 0,
          state: controller.currentStep >= 2
              ? StepState.complete
              : StepState.disabled,
        ),
      ],
    );
  }

  Widget rencanaStep(context) {
    return Column(
      children: [
        CommonWidget.cardWithShadow(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ApprovalFlow.statusApproval(controller.detail.value),
            SizedBox(height: 20.0),
            Card(
              color: Colors.red[200],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidget.bodyText(text: "Perhatian !!!"),
                    CommonWidget.minSubtitleText(
                      text:
                          "Jangan lupa untuk melakukan dokumentasi sebelum dan sesudah melakukan pengerjaan",
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            CommonWidget.bodyText(text: "Keterangan"),
            SizedBox(height: 10.0),
            CommonWidget.subtitleText(text: controller.noteController.text),
          ],
        )),
        SizedBox(height: 20.0),
        CommonWidget.cardWithShadow(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidget.minSubtitleText(
                text:
                    "Minimal melampirkan 1 foto sebelum melakukan pengerjaan"),
            controller.detail.value.beforePhotos.isNotEmpty
                ? dokumenPhoto(controller, 'before')
                : CustomImagePicker.cardPickOneBeforeAfterCamera(
                    context, controller, 'before'),
            Obx(() => ApprovalFlow.buttonApproval(controller)),
          ],
        ))
      ],
    );
  }

  Widget pengerjaanStep(context) {
    return Column(
      children: [
        CommonWidget.cardWithShadow(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ApprovalFlow.statusApproval(controller.detail.value),
            SizedBox(height: 20.0),
            Card(
              color: Colors.red[200],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidget.bodyText(text: "Perhatian !!!"),
                    CommonWidget.minSubtitleText(
                      text:
                          "Jangan lupa untuk melakukan dokumentasi sebelum dan sesudah melakukan pengerjaan",
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            CommonWidget.bodyText(text: "Keterangan"),
            SizedBox(height: 10.0),
            TextAreaField(
              controller: controller.noteTadController,
            ),
            // CommonWidget.subtitleText(text: controller.noteController.text),
          ],
        )),
        SizedBox(height: 20.0),
        CommonWidget.cardWithShadow(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidget.minSubtitleText(
                text:
                    "Minimal melampirkan 1 foto sesudah melakukan pengerjaan"),
            controller.detail.value.afterPhotos.isNotEmpty
                ? dokumenPhoto(controller, 'after')
                : CustomImagePicker.cardPickOneBeforeAfterCamera(
                    context, controller, 'after'),
            Obx(() => ApprovalFlow.buttonApproval(controller)),
          ],
        ))
      ],
    );
  }

  Widget selesaiStep(context) {
    return Column(
      children: [
        SizedBox(height: 20.0),
        CommonWidget.cardWithShadow(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ApprovalFlow.statusApproval(controller.detail.value),
            SizedBox(height: 20.0),
            CommonWidget.bodyText(
                text:
                    "Task List ${controller.detail.value.task?.taskType?.name} (${controller.detail.value.startTime} - ${controller.detail.value.endTime})"),
            SizedBox(height: 10.0),
            CommonWidget.subtitleText(
                text: '${controller.detail.value.task?.name}'),
            SizedBox(height: 10.0),
            CommonWidget.bodyText(text: "Sebelum"),
            dokumenPhoto(controller, 'before'),
            SizedBox(height: 10.0),
            CommonWidget.bodyText(text: "Sesudah"),
            dokumenPhoto(controller, 'after'),
            SizedBox(height: 10.0),
          ],
        )),
        SizedBox(height: 20.0),
        CommonWidget.cardWithShadow(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidget.bodyText(text: "Keterangan Pekerjaan"),
            SizedBox(height: 10.0),
            CommonWidget.subtitleText(text: '${controller.detail.value.note}'),
            SizedBox(height: 10.0),
            CommonWidget.bodyText(text: "Catatan Pekerjaan"),
            SizedBox(height: 10.0),
            CommonWidget.subtitleText(
                text: '${controller.detail.value.noteTad}'),
          ],
        )),
      ],
    );
  }
}
