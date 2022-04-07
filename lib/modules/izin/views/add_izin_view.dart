import 'package:cleaner/modules/izin/controllers/izin_controller.dart';
import 'package:cleaner/shared/constants/colors.dart';
import 'package:cleaner/shared/utils/utils.dart';
import 'package:cleaner/shared/widgets/button.dart';
import 'package:cleaner/shared/widgets/image_picker.dart';
import 'package:cleaner/shared/widgets/input_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddIzinView extends GetView<IzinController> {
  const AddIzinView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sw = SizeConfig().screenWidth;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonWidget.appBar(title: 'Tambah Izin'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidget.labelExpanded(
                        label: 'Tanggal Pengajuan',
                        value: DateFormat("EEEE, d MMMM yyyy", "id_ID")
                            .format(DateTime.now())
                            .toString()),
                    CommonWidget.labelExpanded(
                        label: 'Client', value: controller.placement.value),
                    SizedBox(height: 20.0),
                    CustomDropDownSearch(
                      listItem: controller.listType.map((item) {
                        return item.name;
                      }).toList(),
                      labelText: "Type Izin",
                      onChanged: (value) async {
                        // controller.nameItem.value = value;
                        for (var f in controller.listType) {
                          if (f.name == value) {
                            controller.nameItem.value = f.id.toString();
                          }
                        }
                      },
                    ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   height: MediaQuery.of(context).size.height / 11,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    //     child: DropdownSearch<dynamic>(
                    //       dropdownSearchDecoration: InputDecoration(
                    //         enabledBorder: UnderlineInputBorder(
                    //           borderSide:
                    //               BorderSide(color: ColorConstants.mainColor),
                    //         ),
                    //         labelText: "Type Izin",
                    //       ),
                    //       items: controller.listType.map((item) {
                    //         return item.name;
                    //       }).toList(),
                    //       maxHeight: 300,
                    //       onChanged: (value) async {
                    //         // controller.nameItem.value = value;
                    //         for (var f in controller.listType) {
                    //           if (f.name == value) {
                    //             controller.nameItem.value = f.id.toString();
                    //           }
                    //         }
                    //       },
                    //       showSearchBox: true,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          child: InputInputField(
                            isSuffixIcon: true,
                            suffixIcon: Icon(Icons.calendar_today_rounded),
                            controller: controller.startDateController,
                            labelText: "Tanggal",
                            onSuffixPressed: () {
                              controller.selectDateStart(context);
                            },
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Expanded(
                          child: InputInputField(
                            isSuffixIcon: true,
                            suffixIcon: Icon(Icons.calendar_today_rounded),
                            controller: controller.endDateController,
                            labelText: "Tanggal Selesai",
                            onSuffixPressed: () {
                              controller.selectDateEnd(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
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
                    CommonWidget.bodyText(text: "Upload Dokumen*"),
                    SizedBox(height: 10.0),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 16.0),
                    //   child: FloatingActionButton(
                    //     onPressed: () {
                    //       controller.onImageButtonPressed(
                    //         ImageSource.gallery,
                    //         context: context,
                    //         isMultiImage: true,
                    //       );
                    //     },
                    //     heroTag: 'image1',
                    //     tooltip: 'Pick Multiple Image from gallery',
                    //     child: const Icon(Icons.photo_library),
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Obx(() =>
                          CustomImagePicker.previewGridImages(controller)),
                    ),
                    InkWell(
                      onTap: () {
                        controller.onImageButtonPressed(ImageSource.camera,
                            context: context);
                      },
                      child: DottedBorder(
                        radius: Radius.circular(100.0),
                        color: Colors.grey,
                        dashPattern: [8, 4],
                        strokeWidth: 1,
                        child: Container(
                          height: 50,
                          width: sw,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                                size: 30,
                              ),
                              SizedBox(width: 10.0),
                              CommonWidget.bodyText(
                                  text: "Ambil Photo", color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    CommonWidget.captionText(
                        text: "Lampiran yang diizinkan PDF, PNG, JPG, JPEG"),
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
          ),
        ));
  }
}
