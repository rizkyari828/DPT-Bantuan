import 'dart:convert';
import 'package:cleaner/modules/lembur/controllers/lembur_detail_controller.dart';
import 'package:cleaner/shared/shared.dart';
import 'package:cleaner/shared/widgets/approval.dart';
import 'package:cleaner/shared/widgets/button.dart';
import 'package:cleaner/shared/widgets/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cleaner/models/request/overtime/set_done_overtime_request.dart'
    as setdone;
import 'package:intl/intl.dart';

class LemburDetailView extends GetView<LemburDetailController> {
  final data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final sw = SizeConfig().screenWidth;
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: CommonWidget.appBar(title: 'Detail Lembur'),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidget.cardWithShadow(Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ApprovalFlow.statusApproval(controller.detail.value),
                  SizedBox(height: 20.0),
                  CommonWidget.labelExpanded(
                      label: 'No Request',
                      value: controller.noRequestController.text),
                  SizedBox(height: 10.0),
                  CommonWidget.labelExpanded(
                      label: 'Tanggal',
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
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          CommonWidget.subtitleText(
                            text: "Jam Mulai",
                          ),
                          SizedBox(height: 8),
                          CommonWidget.bodyText(
                            text: DateFormat("HH:mm:ss", "id_ID").format(
                                controller.detail.value.startTime ??
                                    DateTime.now()),
                            color: ColorConstants.mainColor,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CommonWidget.subtitleText(
                            text: "Jam Selesai",
                          ),
                          SizedBox(height: 8),
                          CommonWidget.bodyText(
                            text: DateFormat("HH:mm:ss", "id_ID").format(
                                controller.detail.value.endTime ??
                                    DateTime.now()),
                            color: ColorConstants.mainColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  controller.groupId.toString() != '5'
                      ? CustomDropDownSearch(
                          selectedItem: controller.actualTimeController.text,
                          listItem: controller.arrayFive.map((item) {
                            return item.toString();
                          }).toList(),
                          labelText: "Actual Timee (Jam)",
                          onChanged: (value) async {
                            controller.actualTimeController.text = value;
                          },
                        )
                      // Container(
                      //     width: MediaQuery.of(context).size.width,
                      //     height: MediaQuery.of(context).size.height / 11,
                      //     child: Padding(
                      //       padding:
                      //           const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      //       child: DropdownSearch<dynamic>(
                      //         selectedItem:
                      //             controller.actualTimeController.text,
                      //         dropdownSearchDecoration: InputDecoration(
                      //           enabledBorder: UnderlineInputBorder(
                      //             borderSide: BorderSide(
                      //                 color: ColorConstants.mainColor),
                      //           ),
                      //           labelText: "Actual Timee (Jam)",
                      //         ),
                      //         items: controller.arrayFive.map((item) {
                      //           return item.toString();
                      //         }).toList(),
                      //         maxHeight: 300,
                      //         onChanged: (value) async {
                      //           controller.actualTimeController.text = value;
                      //         },
                      //         showSearchBox: true,
                      //       ),
                      //     ),
                      //   )
                      : CommonWidget.labelExpanded(
                          label: 'Actual Time (Jam)',
                          value: controller.actualTimeController.text),
                ],
              )),
              SizedBox(height: 20.0),
              CommonWidget.cardWithShadow(Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidget.bodyText(
                      text: "Keterangan" + controller.groupId.value),
                  SizedBox(height: 10.0),
                  CommonWidget.bodyText(text: controller.noteController.text),
                  SizedBox(height: 10.0),
                  CommonWidget.bodyText(text: "Catatan Approval"),
                  SizedBox(height: 10.0),
                  controller.groupId.toString() != '5'
                      ? TextAreaField(
                          controller: controller.approvalController,
                        )
                      : CommonWidget.bodyText(
                          text: controller.approvalController.text),
                ],
              )),
              SizedBox(height: 20.0),
              Obx(() => CommonWidget.cardWithShadow(
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonWidget.bodyText(text: "Dokumen"),
                        SizedBox(height: 10.0),
                        controller.detail.value.statusLabel == 'Created'
                            ? Column(
                                children: [
                                  DottedBorder(
                                    radius: Radius.circular(100.0),
                                    color: Colors.grey,
                                    dashPattern: [8, 4],
                                    strokeWidth: 1,
                                    child: Container(
                                      height: 50,
                                      width: sw,
                                      child: addSheetBar(context, 1),
                                    ),
                                  ),
                                  DottedBorder(
                                    radius: Radius.circular(100.0),
                                    color: Colors.grey,
                                    dashPattern: [8, 4],
                                    strokeWidth: 1,
                                    child: Container(
                                      height: 50,
                                      width: sw,
                                      child: addSheetBar(context, 2),
                                    ),
                                  ),
                                  DottedBorder(
                                    radius: Radius.circular(100.0),
                                    color: Colors.grey,
                                    dashPattern: [8, 4],
                                    strokeWidth: 1,
                                    child: Container(
                                      height: 50,
                                      width: sw,
                                      child: addSheetBar(context, 3),
                                    ),
                                  ),
                                  DottedBorder(
                                    radius: Radius.circular(100.0),
                                    color: Colors.grey,
                                    dashPattern: [8, 4],
                                    strokeWidth: 1,
                                    child: Container(
                                      height: 50,
                                      width: sw,
                                      child: addSheetBar(context, 4),
                                    ),
                                  ),
                                  DottedBorder(
                                    radius: Radius.circular(100.0),
                                    color: Colors.grey,
                                    dashPattern: [8, 4],
                                    strokeWidth: 1,
                                    child: Container(
                                      height: 50,
                                      width: sw,
                                      child: addSheetBar(context, 5),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        controller.detail.value.statusLabel == 'Created'
                            ? Column(
                                children: [
                                  controller.isFilledDokumentRoom1.value
                                      ? dokumenSetDonePhoto(
                                          controller.dokumentRoom1.value)
                                      : Container(),
                                  controller.isFilledDokumentRoom2.value
                                      ? dokumenSetDonePhoto(
                                          controller.dokumentRoom2.value)
                                      : Container(),
                                  controller.isFilledDokumentRoom3.value
                                      ? dokumenSetDonePhoto(
                                          controller.dokumentRoom3.value)
                                      : Container(),
                                  controller.isFilledDokumentRoom4.value
                                      ? dokumenSetDonePhoto(
                                          controller.dokumentRoom4.value)
                                      : Container(),
                                  controller.isFilledDokumentRoom5.value
                                      ? dokumenSetDonePhoto(
                                          controller.dokumentRoom5.value)
                                      : Container(),
                                ],
                              )
                            : dokumenPhoto(controller),
                        SizedBox(height: 20.0),
                        Obx(() => ApprovalFlow.buttonApproval(controller))
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget dokumenPhoto(LemburDetailController controller) {
    final sw = SizeConfig().screenWidth;
    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: controller.detail.value.overtimeRoomPhotos?.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Card(
              elevation: 0.1,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.grey, width: 1)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidget.labelExpanded(
                        label: 'Nama Ruangan',
                        value: controller
                                .detail.value.overtimeRoomPhotos?[index].name ??
                            ''),
                    SizedBox(height: 10.0),
                    CommonWidget.subtitleText(text: "Before"),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Container(
                          height: 100,
                          width: sw - 80,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller
                                .detail
                                .value
                                .overtimeRoomPhotos?[index]
                                .beforePhotos
                                ?.length,
                            itemBuilder: (context, indexBefore) {
                              String beforePhotos = controller
                                      .detail
                                      .value
                                      .overtimeRoomPhotos?[index]
                                      .beforePhotos?[indexBefore]
                                      .toString() ??
                                  '';
                              return Container(
                                width: 150,
                                height: 150,
                                child: Image.network(
                                  beforePhotos,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    CommonWidget.subtitleText(text: "After"),
                    Row(
                      children: [
                        Container(
                          height: 100,
                          width: sw - 80,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.detail.value
                                .overtimeRoomPhotos?[index].afterPhotos?.length,
                            itemBuilder: (context, indexAfter) {
                              String beforePhotos = controller
                                      .detail
                                      .value
                                      .overtimeRoomPhotos?[index]
                                      .afterPhotos?[indexAfter]
                                      .toString() ??
                                  '';
                              return Container(
                                height: 150,
                                width: 150,
                                child: Image.network(
                                  beforePhotos,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget dokumenSetDonePhoto(setdone.OvertimeRoomPhoto dokumenRoom) {
    return Container(
      height: 320,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Card(
          elevation: 0.1,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(color: Colors.grey, width: 1)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonWidget.bodyText(text: dokumenRoom.name ?? ''),
                CommonWidget.subtitleText(text: 'Before'),
                dokumenRoom.base64BeforePhotos?.length != 0
                    ? Container(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: dokumenRoom.base64BeforePhotos?.length,
                          itemBuilder: (context, index) {
                            String _separatedBase64 = dokumenRoom
                                .base64BeforePhotos![index]
                                .split(',')
                                .last;
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 50,
                                width: 50,
                                child: Image.memory(
                                    base64Decode(_separatedBase64)),
                              ),
                            );
                          },
                        ),
                      )
                    : CommonWidget.subtitleText(text: 'Tidak ada foto'),
                CommonWidget.subtitleText(text: 'After'),
                dokumenRoom.base64AfterPhotos?.length != 0
                    ? Container(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: dokumenRoom.base64AfterPhotos?.length,
                          itemBuilder: (context, index) {
                            String _separatedBase64 = dokumenRoom
                                .base64AfterPhotos![index]
                                .split(',')
                                .last;
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 50,
                                width: 50,
                                child: Image.memory(
                                    base64Decode(_separatedBase64)),
                              ),
                            );
                          },
                        ),
                      )
                    : CommonWidget.subtitleText(text: 'Tidak ada foto'),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget dokumenSetDonePhoto(dokumenRoom) {
  //   final sw = SizeConfig().screenWidth;
  //   final sh = SizeConfig().screenHeight;
  //   return Container(
  //     height: 300,
  //     child: ListView.builder(
  //       itemCount: dokumenRoom.value.length,
  //       itemBuilder: (context, index) {
  //         return Padding(
  //           padding: const EdgeInsets.only(top: 20.0),
  //           child: Card(
  //             elevation: 0.1,
  //             color: Colors.white,
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(15.0),
  //                 side: BorderSide(color: Colors.grey, width: 1)),
  //             child: Padding(
  //               padding: const EdgeInsets.all(10.0),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   CommonWidget.bodyText(
  //                       text: dokumenRoom.value[index].name ?? ''),
  //                   CommonWidget.subtitleText(text: 'Before'),
  //                   Container(
  //                     height: 100,
  //                     child: ListView.builder(
  //                       scrollDirection: Axis.horizontal,
  //                       itemCount:
  //                           dokumenRoom.value[index].base64BeforePhotos?.length,
  //                       itemBuilder: (context, index) {
  //                         String _separatedBase64 = dokumenRoom
  //                             .value[index].base64BeforePhotos![index]
  //                             .split(',')
  //                             .last;
  //                         return Padding(
  //                           padding: const EdgeInsets.all(10.0),
  //                           child: Container(
  //                             height: 50,
  //                             width: 50,
  //                             child:
  //                                 Image.memory(base64Decode(_separatedBase64)),
  //                           ),
  //                         );
  //                       },
  //                     ),
  //                   ),
  //                   CommonWidget.subtitleText(text: 'After'),
  //                   Container(
  //                     height: 100,
  //                     child: ListView.builder(
  //                       scrollDirection: Axis.horizontal,
  //                       itemCount:
  //                           dokumenRoom.value[index].base64AfterPhotos?.length,
  //                       itemBuilder: (context, index) {
  //                         String _separatedBase64 = dokumenRoom
  //                             .value[index].base64AfterPhotos![index]
  //                             .split(',')
  //                             .last;
  //                         return Padding(
  //                           padding: const EdgeInsets.all(10.0),
  //                           child: Container(
  //                             height: 50,
  //                             width: 50,
  //                             child:
  //                                 Image.memory(base64Decode(_separatedBase64)),
  //                           ),
  //                         );
  //                       },
  //                     ),
  //                   ),
  //                   SizedBox(height: 10.0),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget showPhotoBase64(photo) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 50,
        width: 50,
        child: Text(photo),
        // Image.memory(base64Decode(photo)),
      ),
    );
  }

  Widget addSheetBar(BuildContext context, int list) {
    final sw = SizeConfig().screenWidth;
    return Container(
      width: sw,
      child: InkWell(
        onTap: () {
          Get.bottomSheet(
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Obx(() => Column(
                        children: [
                          SizedBox(height: 10.0),
                          InputInputField(
                            controller: controller.namaRoomController,
                            labelText: "Nama Room",
                          ),
                          controller.isFilled.value == false
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10.0, top: 10.0),
                                  child: CommonWidget.captionText(
                                      text: 'tidak boleh kosong',
                                      color: Colors.red),
                                )
                              : SizedBox(),
                          SizedBox(height: 10.0),
                          CustomImagePicker.cardBeforeAfterPickCamera(
                              context, controller, list),
                          CustomButton(
                            buttonText: 'SIMPAN',
                            width: sw,
                            onPressed: () {
                              // controller.clearImage();
                              controller.checkValidation(list);
                            },
                          ),
                        ],
                      )),
                ),
              ),
              elevation: 20.0,
              enableDrag: false,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              )));
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle_outline_rounded,
                color: Colors.grey,
                size: 30,
              ),
              SizedBox(width: 10.0),
              CommonWidget.bodyText(text: 'Tambah Room', color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
