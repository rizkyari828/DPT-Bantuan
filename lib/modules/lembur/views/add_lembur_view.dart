import 'package:cleaner/modules/lembur/controllers/lembur_add_controller.dart';
import 'package:cleaner/shared/shared.dart';
import 'package:cleaner/shared/widgets/button.dart';
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
                              CustomDropDownSearch(
                                listItem: controller.listBranch.map((item) {
                                  return item.name;
                                }).toList(),
                                labelText: "Cabang",
                                onChanged: (value) async {
                                  // controller.nameItem.value = value;
                                  for (var f in controller.listBranch) {
                                    if (f.name == value) {
                                      controller.branchId.value =
                                          f.id.toString();
                                      controller.getBranchTad(f.id.toString());
                                    }
                                  }
                                },
                              ),
                              // Container(
                              //   width: MediaQuery.of(context).size.width,
                              //   height: MediaQuery.of(context).size.height / 11,
                              //   child: Padding(
                              //     padding: const EdgeInsets.only(
                              //         top: 8.0, bottom: 8.0),
                              //     child: DropdownSearch<dynamic>(
                              //       dropdownSearchDecoration: InputDecoration(
                              //         enabledBorder: UnderlineInputBorder(
                              //           borderSide: BorderSide(
                              //               color: ColorConstants.mainColor),
                              //         ),
                              //         labelText: "Cabang",
                              //       ),
                              //       items: controller.listBranch.map((item) {
                              //         return item.name;
                              //       }).toList(),
                              //       maxHeight: 300,
                              //       onChanged: (value) async {
                              //         // controller.nameItem.value = value;
                              //         for (var f in controller.listBranch) {
                              //           if (f.name == value) {
                              //             controller.branchId.value =
                              //                 f.id.toString();
                              //             controller
                              //                 .getBranchTad(f.id.toString());
                              //           }
                              //         }
                              //       },
                              //       showSearchBox: true,
                              //     ),
                              //   ),
                              // ),
                              SizedBox(height: 10.0),
                              CustomDropDownSearch(
                                listItem: controller.listTad.map((item) {
                                  return item.name;
                                }).toList(),
                                labelText: "Nama",
                                onChanged: (value) async {
                                  // controller.nameItem.value = value;
                                  for (var f in controller.listTad) {
                                    if (f.name == value) {
                                      controller.idTad.value = f.id.toString();
                                    }
                                  }
                                },
                              ),
                              // Container(
                              //   width: MediaQuery.of(context).size.width,
                              //   height: MediaQuery.of(context).size.height / 11,
                              //   child: Padding(
                              //     padding: const EdgeInsets.only(
                              //         top: 8.0, bottom: 8.0),
                              //     child: DropdownSearch<dynamic>(
                              //       dropdownSearchDecoration: InputDecoration(
                              //         enabledBorder: UnderlineInputBorder(
                              //           borderSide: BorderSide(
                              //               color: ColorConstants.mainColor),
                              //         ),
                              //         labelText: "Nama",
                              //       ),
                              //       items: controller.listTad.map((item) {
                              //         return item.name;
                              //       }).toList(),
                              //       maxHeight: 300,
                              //       onChanged: (value) async {
                              //         // controller.nameItem.value = value;
                              //         for (var f in controller.listTad) {
                              //           if (f.name == value) {
                              //             controller.idTad.value =
                              //                 f.id.toString();
                              //           }
                              //         }
                              //       },
                              //       showSearchBox: true,
                              //     ),
                              //   ),
                              // ),
                            ],
                          )
                        : Container(),
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
