import 'package:cleaner/modules/task_list/controllers/korlap/task_list_detail_korlap_controller.dart';
import 'package:cleaner/shared/constants/colors.dart';
import 'package:cleaner/shared/utils/utils.dart';
import 'package:cleaner/shared/widgets/button.dart';
import 'package:cleaner/shared/widgets/input_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskListDetailKorlapView extends GetView<TaskListDetailKorlapController> {
  final data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonWidget.appBar(
            title: data['action'] == 'show'
                ? 'Detail' + ' Task List'
                : 'Edit' + ' Task List'),
        body: SingleChildScrollView(
          child: Obx(
              () => data['action'] == 'show' ? show(context) : edit(context)),
        ));
  }

  Widget edit(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidget.cardWithShadow(Column(
          children: [
            CommonWidget.labelExpanded(
                label: 'Tanggal Pengajuann',
                value: DateFormat("EEEE, d MMMM yyyy", "id_ID")
                    .format(DateTime.now())
                    .toString()),
            SizedBox(height: 10.0),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 11,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: DropdownSearch<dynamic>(
                  selectedItem: controller.nameType.value,
                  dropdownSearchDecoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorConstants.mainColor),
                    ),
                    labelText: "Jenis Task List",
                  ),
                  items: controller.listType.map((item) {
                    return item.name;
                  }).toList(),
                  maxHeight: 300,
                  onChanged: (value) async {
                    // controller.nameItem.value = value;
                    for (var f in controller.listType) {
                      if (f.name == value) {
                        controller.idType.value = f.id.toString();
                        controller.getTaskName();
                      }
                    }
                  },
                  showSearchBox: true,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 11,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: DropdownSearch<dynamic>(
                  selectedItem: controller.nameBranch.value,
                  dropdownSearchDecoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorConstants.mainColor),
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
                        controller.idBranch.value = f.id.toString();
                        controller.getBranchTad(f.id.toString());
                      }
                    }
                  },
                  showSearchBox: true,
                ),
              ),
            ),
            controller.idType.value == '2'
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 11,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: DropdownSearch<dynamic>(
                        selectedItem: controller.nameTad.value,
                        dropdownSearchDecoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorConstants.mainColor),
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
                              controller.idTad.value = f.id.toString();
                            }
                          }
                        },
                        showSearchBox: true,
                      ),
                    ),
                  )
                : Container(),
            SizedBox(height: 10.0),
            InputInputField(
              isSuffixIcon: true,
              suffixIcon: Icon(Icons.calendar_today_rounded),
              controller: controller.startDateController,
              labelText: "Tanggal",
              onSuffixPressed: () {
                controller.selectDateStart(context);
              },
            ),
            SizedBox(height: 10.0),
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
                  selectedItem: controller.nameTask.value,
                  dropdownSearchDecoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorConstants.mainColor),
                    ),
                    labelText: "Judul Task List",
                  ),
                  items: controller.listTaskName.map((item) {
                    return item.name;
                  }).toList(),
                  maxHeight: 300,
                  onChanged: (value) async {
                    // controller.nameItem.value = value;
                    for (var f in controller.listTaskName) {
                      if (f.name == value) {
                        controller.idNameTask.value = f.id.toString();
                      }
                    }
                  },
                  showSearchBox: true,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            CommonWidget.widgetExpanded(
              left: CommonWidget.bodyText(text: "Waktu Mulai"),
              right: InputInputField(
                isSuffixIcon: true,
                suffixIcon: Icon(Icons.calendar_today_rounded),
                controller: controller.startTimeController,
                labelText: "Waktu",
                onSuffixPressed: () {
                  controller.selectTime(
                      context, controller.startTimeController);
                },
              ),
            ),
            SizedBox(width: 20.0),
            CommonWidget.widgetExpanded(
              left: CommonWidget.bodyText(text: "Waktu Selesai"),
              right: InputInputField(
                isSuffixIcon: true,
                suffixIcon: Icon(Icons.calendar_today_rounded),
                controller: controller.endTimeController,
                labelText: "Waktu",
                onSuffixPressed: () {
                  controller.selectTime(context, controller.endTimeController);
                },
              ),
            ),
            SizedBox(height: 10.0),
            CommonWidget.bodyText(text: "Keterangan"),
            SizedBox(height: 10.0),
            Card(
                elevation: 0.1,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side:
                        BorderSide(color: ColorConstants.mainColor, width: 1)),
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
                controller.edit();
              },
            ),
          ],
        )),
      ],
    );
  }

  Widget show(context) {
    if (controller.startDateController.text == '') {
      return Container(child: Text(controller.nameType.value));
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget.cardWithShadow(Column(
            children: [
              CommonWidget.labelExpanded(
                  label: 'Tanggal', value: controller.startDateController.text),
              SizedBox(height: 10.0),
              CommonWidget.labelExpanded(
                  label: 'Jenis Task List',
                  value: controller.idType.value == '1' ? 'General' : 'Khusus'),
              SizedBox(height: 10.0),
              controller.idType.value == '2'
                  ? CommonWidget.labelExpanded(
                      label: 'Nama', value: controller.nameTad.value)
                  : SizedBox(height: 0),
              // SizedBox(height: 10.0),
              // CommonWidget.labelExpanded(
              //     label: 'Job Posisi',
              //     value: controller.detail.value.branch?.companyName),
              SizedBox(height: 10.0),
              CommonWidget.labelExpanded(
                  label: 'Cabang', value: controller.nameBranch.value),
              // SizedBox(height: 10.0),
              // CommonWidget.labelExpanded(
              //     label: 'Penempatan',
              //     value: controller.detail.value.branch?.companyName),
              SizedBox(height: 10.0),
            ],
          )),
          SizedBox(height: 20.0),
          CommonWidget.cardWithShadow(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidget.labelExpanded(
                  label: 'Judul Task List', value: controller.nameTask.value),
              SizedBox(height: 10.0),
              CommonWidget.labelExpanded(
                  label: 'Mulai', value: controller.startTimeController.text),
              SizedBox(height: 10.0),
              CommonWidget.labelExpanded(
                  label: 'Selesai', value: controller.endTimeController.text),
              SizedBox(height: 10.0),
              CommonWidget.bodyText(text: "Keterangan"),
              SizedBox(height: 10.0),
              CommonWidget.bodyText(text: controller.noteController.text),
              SizedBox(height: 10.0),
            ],
          )),
        ],
      );
    }
  }
}
