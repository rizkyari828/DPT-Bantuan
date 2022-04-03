import 'package:cleaner/modules/lembur/controllers/lembur_add_controller.dart';
import 'package:cleaner/shared/shared.dart';
import 'package:cleaner/shared/widgets/button.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LemburAddView extends GetView<LemburAddController> {
  // final CnCController controller = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonWidget.appBar(title: 'Tambah Lembur'),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidget.labelExpanded(
                        label: 'Tanggal',
                        value: DateFormat("EEEE, d MMMM yyyy", "id_ID")
                            .format(DateTime.now())
                            .toString()),
                    controller.groupId.value == '3'
                        ? Column(
                            children: [
                              SizedBox(height: 10.0),
                              CommonWidget.labelExpanded(
                                  label: 'Client',
                                  value: controller.placement.value),
                              SizedBox(height: 10.0),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 11,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8.0),
                                  child: DropdownSearch<dynamic>(
                                    dropdownSearchDecoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorConstants.mainColor),
                                      ),
                                      labelText: "Cabang",
                                    ),
                                    items: controller.listBranch.map((item) {
                                      return item.name;
                                    }).toList(),
                                    maxHeight: 300,
                                    onChanged: (value) async {
                                      // controller.nameItem.value = value;
                                      for (var f in controller.listBranch) {
                                        if (f.name == value) {
                                          controller.branchId.value =
                                              f.id.toString();
                                          controller
                                              .getBranchTad(f.id.toString());
                                        }
                                      }
                                    },
                                    showSearchBox: true,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 11,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8.0),
                                  child: DropdownSearch<dynamic>(
                                    dropdownSearchDecoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorConstants.mainColor),
                                      ),
                                      labelText: "Nama",
                                    ),
                                    items: controller.listTad.map((item) {
                                      return item.name;
                                    }).toList(),
                                    maxHeight: 300,
                                    onChanged: (value) async {
                                      // controller.nameItem.value = value;
                                      for (var f in controller.listTad) {
                                        if (f.name == value) {
                                          controller.idTad.value =
                                              f.id.toString();
                                        }
                                      }
                                    },
                                    showSearchBox: true,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(height: 20.0),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Column(
                    //       children: [
                    //         CommonWidget.subtitleText(
                    //           text: "Jam Mulai",
                    //         ),
                    //         SizedBox(height: 8),
                    //         controller.timeIn.value == "--:--"
                    //             ? TimerBuilder.periodic(Duration(seconds: 1),
                    //                 builder: (context) {
                    //                 return CustomButton(
                    //                     isDisabled:
                    //                         controller.isClockIn.value == true
                    //                             ? false
                    //                             : true,
                    //                     borderColor: ColorConstants.mainColor,
                    //                     buttonColor: Colors.white,
                    //                     buttonTextColor:
                    //                         ColorConstants.mainColor,
                    //                     height: sh * .04,
                    //                     buttonText:
                    //                         DateFormat("HH:mm:ss", "id_ID")
                    //                             .format(DateTime.now()),
                    //                     width: sw * .3,
                    //                     onPressed:
                    //                         controller.errorNotFoundClockOut);
                    //               })
                    //             : CommonWidget.bodyText(
                    //                 text: controller.timeIn.value,
                    //                 color: ColorConstants.mainColor,
                    //               ),
                    //       ],
                    //     ),
                    //     Column(
                    //       children: [
                    //         CommonWidget.subtitleText(
                    //           text: "Jam Selesai",
                    //         ),
                    //         SizedBox(height: 8),
                    //         controller.timeOut.value == "--:--"
                    //             ? TimerBuilder.periodic(Duration(seconds: 1),
                    //                 builder: (context) {
                    //                 return CustomButton(
                    //                     isDisabled:
                    //                         controller.isClockIn.value == true
                    //                             ? false
                    //                             : true,
                    //                     borderColor: ColorConstants.mainColor,
                    //                     buttonColor: Colors.white,
                    //                     buttonTextColor:
                    //                         ColorConstants.mainColor,
                    //                     height: sh * .04,
                    //                     buttonText:
                    //                         DateFormat("HH:mm:ss", "id_ID")
                    //                             .format(DateTime.now()),
                    //                     width: sw * .3,
                    //                     onPressed: controller.submitOut);
                    //               })
                    //             : CommonWidget.bodyText(
                    //                 text: controller.timeOut.value,
                    //                 color: ColorConstants.mainColor,
                    //               ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    // MaterialButton(
                    //   onPressed: () => controller.selectDate(context),
                    //   child: Text('Select date'),
                    // ),
                    SizedBox(height: 20.0),
                    CommonWidget.bodyText(text: "Keterangan"),
                    SizedBox(height: 10.0),
                    TextAreaField(
                      controller: controller.noteController,
                    ),
                    SizedBox(height: 30.0),
                    CustomButton(
                      buttonText: 'SIMPAN',
                      width: MediaQuery.of(context).size.width,
                      onPressed: () {
                        if (controller.groupId.value == '3') {
                          controller.submitOvertimeClient();
                        } else {
                          controller.submitOvertime();
                        }
                      },
                    ),
                  ],
                ),
              )),
        ));
  }
}
