import 'package:cleaner/modules/cuti/controllers/cuti_detail_controller.dart';
import 'package:cleaner/shared/shared.dart';
import 'package:cleaner/shared/widgets/approval.dart';
import 'package:cleaner/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';

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

  Widget addSheetBar(BuildContext context) {
    final sw = SizeConfig().screenWidth;
    return Container(
      width: sw,
      child: InkWell(
        onTap: () {
          Get.bottomSheet(
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Obx(() => Column(
                            children: [
                              SizedBox(height: 10.0),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 11,
                                child: DropdownSearch<dynamic>(
                                  dropdownSearchDecoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorConstants.mainColor),
                                    ),
                                    labelText: "Nama Barang",
                                  ),
                                  items: controller.listItem.map((item) {
                                    return item.name;
                                  }).toList(),
                                  maxHeight: 300,
                                  onChanged: (value) async {
                                    controller.nameItem.value = value;
                                  },
                                  showSearchBox: true,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              InputInputField(
                                controller: controller.qtyController,
                                labelText: "Qty",
                              ),
                              SizedBox(height: 20.0),
                              CustomButton(
                                buttonText: 'SIMPAN',
                                width: sw,
                                onPressed: () {
                                  controller.submiteGoods();
                                },
                              ),
                            ],
                          )),
                    )
                  ],
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
              CommonWidget.bodyText(text: 'Tambah Item', color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
