import 'package:cleaner/modules/CnC/controllers/cn_c_detail_controller.dart';
import 'package:cleaner/shared/shared.dart';
import 'package:cleaner/shared/widgets/approval.dart';
import 'package:cleaner/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dotted_border/dotted_border.dart';

class CnCShowView extends GetView<CnCDetailController> {
  final data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    final sw = SizeConfig().screenWidth;
    final sh = SizeConfig().screenHeight;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonWidget.appBar(title: 'Detail CnC'),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Obx(
              () => Column(
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
                      value: controller.detail.value.date.toString() != ''
                          ? DateFormat("EEEE, d MMMM yyyy", "id_ID")
                              .format(controller.detail.value.date ??
                                  DateTime.now())
                              .toString()
                          : ""),
                  SizedBox(height: 10.0),
                  CommonWidget.labelExpanded(
                      label: 'Client',
                      value: controller.detail.value.branchName ?? ''),
                  SizedBox(height: 20.0),
                  CommonWidget.bodyText(text: "Keterangan"),
                  SizedBox(height: 10.0),
                  controller.groupId.toString() == '5'
                      ? Card(
                          elevation: 0.1,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(color: Colors.grey, width: 1)),
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: TextField(
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  letterSpacing: 0.5,
                                  fontFamily: 'Poppins'),
                              controller: controller.noteController,
                              maxLines: 8,
                              decoration: InputDecoration.collapsed(
                                  hintText: "Enter your text here"),
                            ),
                          ))
                      : CommonWidget.bodyText(
                          text: controller.noteController.text),
                  SizedBox(height: 20.0),
                  CommonWidget.bodyText(text: 'List Item'),
                  Column(
                    children: [
                      SizedBox(height: 10.0),
                      Container(
                          height: 100,
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: ListView.builder(
                            itemCount: controller.goods.length,
                            itemBuilder: (context, i) => InkWell(
                                onTap: () async {
                                  controller.qtyController.text =
                                      controller.goods[i].qty.toString();
                                  controller.unitTypeName.value = controller
                                      .goods[i].unitTypeName
                                      .toString();
                                  controller.nameItem.value =
                                      controller.goods[i].name.toString();
                                  controller.getItemCnC(controller
                                      .goods[i].unitTypeName
                                      .toString());
                                  detailSheetBar(
                                      controller: controller,
                                      name: controller.goods[i].name.toString(),
                                      qty: controller.goods[i].qty.toString(),
                                      date: controller.dateGoods.value);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: CommonWidget.bodyText(
                                          text: (i + 1).toString() +
                                              ". " +
                                              controller.goods[i].name,
                                          color: Colors.blue),
                                    ),
                                    Expanded(
                                      child: CommonWidget.bodyText(
                                          text: controller.goods[i].qty +
                                              ' ' +
                                              controller.goods[i].unitTypeName),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child:
                                            ApprovalFlow.deleteButtonApproval(
                                                controller: controller,
                                                name: controller.goods[i].name),
                                      ),
                                    )
                                  ],
                                )),
                          ))
                    ],
                  ),
                  controller.groupId.toString() != '3'
                      ? DottedBorder(
                          radius: Radius.circular(100.0),
                          color: Colors.grey,
                          dashPattern: [8, 4],
                          strokeWidth: 1,
                          child: Container(
                            height: 50,
                            width: sw,
                            child: addSheetBar(context),
                          ),
                        )
                      : Container(),
                  SizedBox(height: 50.0),
                  Obx(() => ApprovalFlow.buttonApproval(controller))
                ],
              ),
            )),
      ),
    );
  }

  Widget addSheetBar(BuildContext context) {
    final sw = SizeConfig().screenWidth;
    final sh = SizeConfig().screenHeight;
    return Container(
      width: sw,
      child: InkWell(
        onTap: () {
          controller.qtyController.text = '';
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
                                    labelText: "Kategori Barang",
                                  ),
                                  items: controller.listCategory.map((item) {
                                    return item.name;
                                  }).toList(),
                                  maxHeight: 300,
                                  onChanged: (value) async {
                                    controller.getItemCnC(value);
                                  },
                                  showSearchBox: true,
                                ),
                              ),
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
                                keyboardType: TextInputType.number,
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

  static Future detailSheetBar(
      {CnCDetailController? controller,
      String name = "",
      String qty = "",
      String date = ""}) {
    final sw = SizeConfig().screenWidth;
    final sh = SizeConfig().screenHeight;
    return Get.bottomSheet(
        Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Obx(() => Column(
                      children: [
                        SizedBox(height: 10.0),
                        Container(
                          width: sw,
                          height: sh / 11,
                          child: DropdownSearch<dynamic>(
                            enabled: false,
                            selectedItem: controller?.unitTypeName.value,
                            dropdownSearchDecoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorConstants.mainColor),
                              ),
                              labelText: "Kategori Barang",
                            ),
                            items: controller?.listCategory.map((item) {
                              return item.name;
                            }).toList(),
                            maxHeight: 300,
                            onChanged: (value) async {
                              controller?.getItemCnC(value);
                            },
                            showSearchBox: true,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          width: sw,
                          height: sh / 11,
                          child: DropdownSearch<dynamic>(
                            enabled: false,
                            selectedItem: controller?.nameItem.value,
                            dropdownSearchDecoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorConstants.mainColor),
                              ),
                              labelText: "Nama Barang",
                            ),
                            items: controller!.listItem.map((item) {
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
                          keyboardType: TextInputType.number,
                          controller: controller.qtyController,
                          placeholder: qty,
                          labelText: "Qty",
                        ),
                        SizedBox(height: 20.0),
                        CustomButton(
                          buttonText: 'SIMPAN',
                          width: sw,
                          onPressed: () {
                            controller.updateGoods(name: name);
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
  }
}
