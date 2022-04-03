import 'package:cleaner/shared/widgets/approval.dart';
import 'package:flutter/material.dart';
import 'package:cleaner/models/response/user/users_response.dart';
import 'package:cleaner/modules/home/home.dart';
import 'package:cleaner/shared/constants/colors.dart';
import 'package:cleaner/shared/utils/common_widget.dart';
import 'package:cleaner/shared/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class MainTab extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    double scaleWidth = MediaQuery.of(context).size.width / 360;
    controller.context = context;
    return Scaffold(
      backgroundColor: ColorConstants.mainColor,
      body: Obx(() => RefreshIndicator(
            child: _buildGridView(scaleWidth, context),
            onRefresh: () => controller.onRefresh(),
          )),
    );
  }

  Widget _buildGridView(scaleWidth, context) {
    final sw = SizeConfig().screenWidth;
    final sh = SizeConfig().screenHeight;
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: sh * 0.27,
            ),
            width: sw,
            height: sh - sh / 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
              // borderRadius: BorderRadius.circular(15),
              color: Colors.red,
            ),
            child: Card(
              elevation: 1,
              color: ColorConstants.lightScaffoldBackgroundColor,
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.only(
              //       topRight: Radius.circular(30),
              //       topLeft: Radius.circular(30),
              //     ),
              //     side: BorderSide(
              //         color: ColorConstants.borderColor, width: 1))
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: sh / 12,
              left: 10.0,
              right: 10.0,
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(controller.profilePhoto.value),
              ),
              title: Text(
                controller.name.value,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: 'Poppins',
                ),
              ),
              subtitle: CommonWidget.subtitleText(
                  text: controller.simId.value, color: Colors.white),
            ),
          ),
          CommonWidget.rowHeight(),
          Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0, top: sh * .20),
            child: Column(
              children: [
                _graphMenu(context),
                CommonWidget.rowHeight(),
                Container(child: _statusTaskBar()),
                CommonWidget.rowHeight(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _cardMenu(Icons.batch_prediction_rounded, "Informasi",
                        controller.goToInformationPages, Colors.blueGrey),
                    CommonWidget.rowWidth(width: 15),
                    _cardMenu(Icons.work_off_rounded, "Izin",
                        controller.goToIzinPages, Colors.blue),
                    CommonWidget.rowWidth(width: 15),
                    _cardMenu(Icons.airplane_ticket_rounded, "Cuti",
                        controller.goToCutiPages, Colors.indigo),
                    CommonWidget.rowWidth(width: 15),
                    _cardMenu(Icons.alarm_add_rounded, "Lembur",
                        controller.goToLemburPages, Colors.purple),
                  ],
                ),
                CommonWidget.rowHeight(),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _cardMenu(Icons.bar_chart_rounded, "Rekap",
                        controller.goToRecapPages, Colors.pink),
                    CommonWidget.rowWidth(width: 15),
                    _cardMenu(Icons.build_rounded, "CnC",
                        controller.goToCnCPages, Colors.deepOrange),
                    ApprovalFlow.hideWidget(
                      controller.groupId,
                      CommonWidget.rowWidth(width: 15),
                    ),
                    ApprovalFlow.hideWidget(
                        controller.groupId,
                        _cardMenu(Icons.hail_outlined, "Reliver",
                            controller.goToReliverPages, Colors.teal)),
                    ApprovalFlow.hideWidget(
                      controller.groupId,
                      CommonWidget.rowWidth(width: 15),
                    ),
                    ApprovalFlow.hideWidget(
                        controller.groupId,
                        _cardMenu(Icons.list, "TASK TAD",
                            controller.goToListTadKorlapPages, Colors.lime))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _graphMenu(context) {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(children: [
              CommonWidget.bodyText(text: controller.month.value),
              new Spacer(),
              InkWell(
                onTap: () {
                  showMonthPicker(
                    context: context,
                    firstDate: DateTime(DateTime.now().year - 1, 5),
                    lastDate: DateTime(DateTime.now().year + 1, 9),
                    initialDate: controller.selectedDate ?? DateTime.now(),
                  ).then((date) {
                    if (date != null) {
                      controller.selectedDate = date;
                      controller.month.value = DateFormat("MMMM yyyy", "id_ID")
                          .format(date)
                          .toString();
                      // controller.getData();
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
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.calendar_today_rounded,
                      color: Colors.white,
                      size: 15.0,
                    ),
                  ),
                ),
              ),
            ]),
            CommonWidget.rowHeight(height: 8),
            // Divider(),
            CommonWidget.rowHeight(height: 8),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonWidget.subtitleText(text: "Kehadiran"),
                        ListTile(
                          leading: Text(
                            "100%",
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 30,
                                fontFamily: 'Poppins'),
                          ),
                          title: CommonWidget.captionText(
                              text: "Kehadiran 7 Hari"),
                          subtitle:
                              CommonWidget.captionText(text: "Alfa 0 Hari"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonWidget.subtitleText(text: "Jam Kerja"),
                        ListTile(
                          leading: Text(
                            "50.0",
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 30,
                                fontFamily: 'Poppins'),
                          ),
                          title: CommonWidget.captionText(
                              text: "Terlambat 1 Kali"),
                          subtitle:
                              CommonWidget.captionText(text: "Durasi 0 Menit"),
                        ),
                      ],
                    ),
                  ),
                ])
          ],
        ),
      ),
    );
  }

  Widget _statusTaskBar() {
    return Container(
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
      height: SizeConfig().screenHeight / 11,
      child: ListTile(
        leading: Icon(
          Icons.check_circle_outline,
          size: 40,
          color: Colors.grey,
        ),
        title: CommonWidget.subtitleText(
            text: "Ayo selesaikan task harianmu", color: Colors.black87),
        subtitle: LinearProgressIndicator(
          minHeight: 10,
          value: 0.5,
          semanticsLabel: 'Linear progress indicator',
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.black87,
          size: 30,
        ),
        isThreeLine: true,
      ),
    );
  }

  Widget _cardMenu(icon, title, onPressed, colorCircle) {
    return Expanded(
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
        width: SizeConfig().screenWidth * .20,
        height: SizeConfig().screenHeight * .12,
        child: InkWell(
          onTap: () {
            onPressed();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Container(
                    decoration: new BoxDecoration(
                      color: colorCircle,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: SizeConfig().screenWidth * .06,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  CommonWidget.captionText(text: title),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Datum>? get data {
    return controller.users.value == null ? [] : controller.users.value!.data;
  }
}
