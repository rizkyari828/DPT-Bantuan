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

  Widget dokumenPhoto(TaskListDetailController controller, String type) {
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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: type == 'before'
                  ? controller.detail.value.beforePhotos.length
                  : controller.detail.value.afterPhotos.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Container(
                      width: 150,
                      height: 150,
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
            SizedBox(height: 10.0),
            controller.detail.value.afterPhotos.isNotEmpty
                ? dokumenPhoto(controller, 'before')
                : Container(),
            CustomImagePicker.cardPickOneBeforeAfterCamera(
                context, controller, 'before'),
            CommonWidget.subtitleText(
                text: "Update : " +
                    DateFormat("EEEE, d MMMM yyyy HH:mm:ss", "id_ID")
                        .format(
                            controller.detail.value.updatedAt ?? DateTime.now())
                        .toString()),
            // Obx(() => ApprovalFlow.buttonApproval(controller)),
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
            SizedBox(height: 10.0),
            controller.detail.value.afterPhotos.isNotEmpty
                ? dokumenPhoto(controller, 'after')
                : Container(),
            CustomImagePicker.cardPickOneBeforeAfterCamera(
                context, controller, 'after'),
            CommonWidget.subtitleText(
                text: "Update : " +
                    DateFormat("EEEE, d MMMM yyyy HH:mm:ss", "id_ID")
                        .format(
                            controller.detail.value.updatedAt ?? DateTime.now())
                        .toString()),
          ],
        ))
      ],
    );
  }

  Widget selesaiStep(context) {
    final sw = SizeConfig().screenWidth;
    final sh = SizeConfig().screenHeight;
    return Column(
      children: [
        SizedBox(height: 20.0),
        CommonWidget.cardWithShadow(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: sw * 0.6,
                    child:
                        ApprovalFlow.statusApproval(controller.detail.value)),
                InkWell(
                  onTap: controller.backToStart,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 50.0,
                            spreadRadius: 3.0,
                            offset: Offset(
                              -10.0,
                              10.0,
                            ),
                          ),
                        ],
                      ),
                      width: sw * 0.12,
                      height: sh * .05,
                      child: Card(
                          elevation: 0,
                          color: Colors.yellow[800],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          )),
                          child: Center(
                              child: Icon(
                            Icons.create,
                          )))),
                )
              ],
            ),
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
            CommonWidget.subtitleText(
                text: "Update : " +
                    DateFormat("EEEE, d MMMM yyyy HH:mm:ss", "id_ID")
                        .format(
                            controller.detail.value.updatedAt ?? DateTime.now())
                        .toString()),
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
