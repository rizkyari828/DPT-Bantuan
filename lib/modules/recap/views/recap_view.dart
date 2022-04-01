import 'package:cleaner/shared/utils/size_config.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cleaner/shared/constants/colors.dart';
import 'package:cleaner/shared/utils/common_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/recap_controller.dart';

class RecapView extends GetView<RecapController> {
  @override
  Widget build(BuildContext context) {
    final sw = SizeConfig().screenWidth;
    final sh = SizeConfig().screenHeight;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Rekap',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
            fontFamily: 'Poppins',
          ),
        ),
        elevation: 0,
        backgroundColor: ColorConstants.mainColor,
      ),
      body: Column(
        children: [
          // CustomContinuesAppBar(
          //     type: "large", textLabel: "Profile", textSubtitle: "Januari"),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 20.0,
                    spreadRadius: 4.0,
                    offset: Offset(
                      -10.0,
                      10.0,
                    ),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Container(
                        color: Colors.blue.shade50,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonWidget.subtitleText(text: 'Absen'),
                                  CommonWidget.minHeadText(
                                      text: controller.month.value),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  showMonthPicker(
                                    context: context,
                                    firstDate:
                                        DateTime(DateTime.now().year - 1, 5),
                                    lastDate:
                                        DateTime(DateTime.now().year + 1, 9),
                                    initialDate: controller.selectedDate ??
                                        DateTime.now(),
                                  ).then((date) {
                                    if (date != null) {
                                      controller.selectedDate = date;
                                      controller.month.value =
                                          DateFormat("MMMM yyyy", "id_ID")
                                              .format(date)
                                              .toString();
                                      controller.getData();
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: new BoxDecoration(
                                    color: ColorConstants.mainColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 20.0,
                                        spreadRadius: 4.0,
                                        offset: Offset(
                                          -10.0,
                                          10.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Icon(
                                      Icons.calendar_today_rounded,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Container(
                    color: Colors.blue.shade200,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: sw * .13,
                                child: CommonWidget.minSubtitleText(
                                    text: 'Hari', fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: sw * .01,
                            ),
                            Container(
                                width: sw * .2,
                                child: CommonWidget.minSubtitleText(
                                    text: 'Tanggal',
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: sw * .01,
                            ),
                            Container(
                                width: sw * .12,
                                child: CommonWidget.minSubtitleText(
                                    text: 'Masuk',
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: sw * .01,
                            ),
                            Container(
                                width: sw * .13,
                                child: CommonWidget.minSubtitleText(
                                    text: 'Pulang',
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: sw * .01,
                            ),
                            Container(
                                width: sw * .12,
                                child: CommonWidget.minSubtitleText(
                                    text: 'Durasi',
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Obx(() => Container(
                        height: sh * .70,
                        child: ListView.builder(
                            itemCount: controller.historyData.length,
                            itemBuilder: (context, i) => Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5.0,
                                      left: 10.0,
                                      right: 10.0,
                                      top: 5.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: sw * .13,
                                            child: CommonWidget.minSubtitleText(
                                                text:
                                                    DateFormat("EEEE", "id_ID")
                                                        .format(controller
                                                                .historyData[i]
                                                                .dateCheckIn ??
                                                            DateTime.now())
                                                        .toString()),
                                          ),
                                          SizedBox(
                                            width: sw * .01,
                                          ),
                                          Container(
                                            width: sw * .2,
                                            child: CommonWidget.minSubtitleText(
                                                text: DateFormat(
                                                        "dd/MM/yyyy", "id_ID")
                                                    .format(controller
                                                            .historyData[i]
                                                            .dateCheckIn ??
                                                        DateTime.now())
                                                    .toString()),
                                          ),
                                          SizedBox(
                                            width: sw * .01,
                                          ),
                                          Container(
                                            width: sw * .12,
                                            child: CommonWidget.minSubtitleText(
                                                text: controller
                                                            .historyData[i]
                                                            .dataUserAttandance
                                                            ?.checkIn ==
                                                        null
                                                    ? "--:--"
                                                    : DateFormat(
                                                            "HH:mm", "id_ID")
                                                        .format(controller
                                                                .historyData[i]
                                                                .dataUserAttandance
                                                                ?.checkIn ??
                                                            DateTime.now())
                                                        .toString()),
                                          ),
                                          SizedBox(
                                            width: sw * .01,
                                          ),
                                          Container(
                                            width: sw * .12,
                                            child: CommonWidget.minSubtitleText(
                                                text: controller
                                                            .historyData[i]
                                                            .dataUserAttandance
                                                            ?.checkOut ==
                                                        null
                                                    ? "--:--"
                                                    : DateFormat(
                                                            "HH:mm", "id_ID")
                                                        .format(controller
                                                                .historyData[i]
                                                                .dataUserAttandance
                                                                ?.checkOut ??
                                                            DateTime.now())
                                                        .toString()),
                                          ),
                                          SizedBox(
                                            width: sw * .01,
                                          ),
                                          Container(
                                            width: sw * .12,
                                            child: CommonWidget.minSubtitleText(
                                                text: _printDuration((controller
                                                            .historyData[i]
                                                            .dataUserAttandance
                                                            ?.checkOut ??
                                                        DateTime.now())
                                                    .difference(controller
                                                            .historyData[i]
                                                            .dataUserAttandance
                                                            ?.checkIn ??
                                                        DateTime.now()))),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: sw * .02,
                                      ),
                                      Divider(
                                        color: ColorConstants.borderColor,
                                      ),
                                    ],
                                  ),
                                )),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes";
  }
}
