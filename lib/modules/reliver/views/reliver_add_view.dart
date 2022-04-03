import 'package:cleaner/modules/reliver/controllers/reliver_add_controller.dart';
import 'package:cleaner/shared/constants/colors.dart';
import 'package:cleaner/shared/utils/utils.dart';
import 'package:cleaner/shared/widgets/button.dart';
import 'package:cleaner/shared/widgets/input_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReliverAddView extends GetView<ReliverAddController> {
  const ReliverAddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonWidget.appBar(title: 'Kebutuhan Reliver'),
        body: SingleChildScrollView(
          child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidget.cardWithShadow(Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.0),
                      CommonWidget.minHeadText(text: "Kebutuhan"),
                      SizedBox(height: 10.0),
                      CommonWidget.labelExpanded(
                          label: 'Tanggal Pengajuan',
                          value: DateFormat("EEEE, d MMMM yyyy", "id_ID")
                              .format(DateTime.now())
                              .toString()),
                      SizedBox(height: 10.0),
                      CommonWidget.labelExpanded(
                          label: 'Client', value: controller.placement.value),
                      SizedBox(height: 10.0),
                      CommonWidget.widgetExpanded(
                        left: CommonWidget.bodyText(text: "Tanggal Kebutuhan"),
                        right: InputInputField(
                          isSuffixIcon: true,
                          suffixIcon: Icon(Icons.calendar_today_rounded),
                          controller: controller.startDateKebutuhanController,
                          labelText: "Tanggal",
                          onSuffixPressed: () {
                            controller.selectDate(context,
                                controller.startDateKebutuhanController);
                          },
                        ),
                      ),
                      SizedBox(height: 10.0),
                      CommonWidget.widgetExpanded(
                        left: CommonWidget.bodyText(
                            text: "Tanggal Selesai Kebutuhan"),
                        right: InputInputField(
                          isSuffixIcon: true,
                          suffixIcon: Icon(Icons.calendar_today_rounded),
                          controller: controller.endDateKebutuhanController,
                          labelText: "Tanggal",
                          onSuffixPressed: () {
                            controller.selectDate(
                                context, controller.endDateKebutuhanController);
                          },
                        ),
                      ),
                      SizedBox(height: 10.0),
                      // CommonWidget.bodyText(text: "Keterangan"),
                      // SizedBox(height: 10.0),
                      // Card(
                      //     elevation: 0.1,
                      //     color: Colors.white,
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(15.0),
                      //         side: BorderSide(
                      //             color: ColorConstants.mainColor, width: 1)),
                      //     child: Padding(
                      //       padding: EdgeInsets.all(8.0),
                      //       child: TextField(
                      //         controller: controller.noteKebutuhanController,
                      //         maxLines: 8,
                      //         decoration: InputDecoration.collapsed(
                      //             hintText: "Enter your text here"),
                      //       ),
                      //     )),
                    ],
                  )),
                  SizedBox(height: 20.0),
                  CommonWidget.cardWithShadow(Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 11,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: DropdownSearch<dynamic>(
                            dropdownSearchDecoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorConstants.mainColor),
                              ),
                              labelText: "Cabang Client",
                            ),
                            items: controller.listBranch.map((item) {
                              return item.name;
                            }).toList(),
                            maxHeight: 300,
                            onChanged: (value) async {
                              // controller.nameItem.value = value;
                              for (var f in controller.listBranch) {
                                if (f.name == value) {
                                  controller.nameBranchId.value = f.id ?? 0;
                                }
                              }
                            },
                            showSearchBox: true,
                          ),
                        ),
                      ),
                      // CommonWidget.widgetExpanded(
                      //   left: Container(
                      //     width: MediaQuery.of(context).size.width,
                      //     height: MediaQuery.of(context).size.height / 11,
                      //     child: Padding(
                      //       padding:
                      //           const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      //       child: DropdownSearch<dynamic>(
                      //         dropdownSearchDecoration: InputDecoration(
                      //           enabledBorder: UnderlineInputBorder(
                      //             borderSide: BorderSide(
                      //                 color: ColorConstants.mainColor),
                      //           ),
                      //           labelText: "Nama Client",
                      //         ),
                      //         items: controller.listType.map((item) {
                      //           return item.name;
                      //         }).toList(),
                      //         maxHeight: 300,
                      //         onChanged: (value) async {
                      //           // controller.nameItem.value = value;
                      //           for (var f in controller.listType) {
                      //             if (f.name == value) {
                      //               controller.nameItem.value = f.id.toString();
                      //             }
                      //           }
                      //         },
                      //         showSearchBox: true,
                      //       ),
                      //     ),
                      //   ),
                      //   right: Container(
                      //     width: MediaQuery.of(context).size.width,
                      //     height: MediaQuery.of(context).size.height / 11,
                      //     child: Padding(
                      //       padding:
                      //           const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      //       child: DropdownSearch<dynamic>(
                      //         dropdownSearchDecoration: InputDecoration(
                      //           enabledBorder: UnderlineInputBorder(
                      //             borderSide: BorderSide(
                      //                 color: ColorConstants.mainColor),
                      //           ),
                      //           labelText: "Cabang Client",
                      //         ),
                      //         items: controller.listType.map((item) {
                      //           return item.name;
                      //         }).toList(),
                      //         maxHeight: 300,
                      //         onChanged: (value) async {
                      //           // controller.nameItem.value = value;
                      //           for (var f in controller.listType) {
                      //             if (f.name == value) {
                      //               controller.nameItem.value = f.id.toString();
                      //             }
                      //           }
                      //         },
                      //         showSearchBox: true,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 10.0),
                      InputInputField(
                        keyboardType: TextInputType.number,
                        controller: controller.numberReliver,
                        labelText: "Jumlah Karyawan",
                      ),
                      // CommonWidget.widgetExpanded(
                      //   left: InputInputField(
                      //     keyboardType: TextInputType.number,
                      //     controller: controller.numberReliver,
                      //     labelText: "Jumlah Karyawan",
                      //   ),
                      //   right: InputInputField(
                      //     isSuffixIcon: true,
                      //     suffixIcon: Icon(Icons.calendar_today_rounded),
                      //     controller: controller.startDateController,
                      //     labelText: "Tanggal Bekerja",
                      //     onSuffixPressed: () {
                      //       controller.selectDate(
                      //           context, controller.startDateController);
                      //     },
                      //   ),
                      // ),
                      SizedBox(height: 10.0),
                      CommonWidget.bodyText(text: "Keterangan"),
                      SizedBox(height: 10.0),
                      Card(
                          elevation: 0.1,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(
                                  color: ColorConstants.mainColor, width: 1)),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              controller: controller.noteController,
                              maxLines: 8,
                              decoration: InputDecoration.collapsed(
                                  hintText: "Enter your text here"),
                            ),
                          )),
                      SizedBox(height: 30.0),
                      CustomButton(
                        buttonText: 'SIMPAN',
                        width: MediaQuery.of(context).size.width,
                        onPressed: () {
                          controller.submit();
                        },
                      ),
                    ],
                  )),
                ],
              )),
        ));
  }
}
