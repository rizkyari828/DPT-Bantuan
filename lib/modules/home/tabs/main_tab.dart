import 'package:flutter/material.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:konconeDeDe/modules/home/home.dart';
import 'package:konconeDeDe/shared/constants/colors.dart';
import 'package:konconeDeDe/shared/utils/common_widget.dart';
import 'package:konconeDeDe/shared/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:konconeDeDe/shared/widgets/custom_card.dart';

class MainTab extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    double scaleWidth = MediaQuery.of(context).size.width / 360;
    controller.context = context;
    return Scaffold(
      backgroundColor: ColorConstants.lightScaffoldBackgroundColor,
      body: Obx(() => _buildGridView(scaleWidth, context)),
      // floatingActionButton: Container(
      //   margin: EdgeInsets.only(left: sw * .08),
      //   child: CustomButton(
      //     buttonColor: Colors.green,
      //     buttonText: 'BUKA QR SCANNER',
      //     width: sw,
      //     onPressed: () {
      //       controller.goToScannerPages();
      //     },
      //   ),
      // ),
    );
  }

  Widget _buildGridView(scaleWidth, context) {
    final sw = SizeConfig().screenWidth;
    final sh = SizeConfig().screenHeight;
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: sw * .04, right: sw * .04),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: sh / 12,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(controller.profilePhoto.value),
                        ),
                        title: Text(
                          controller.name.value,
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        subtitle: CommonWidget.subtitleText(
                          text: controller.username.value,
                          color: Colors.black87,
                        ),
                        // trailing: InkWell(
                        //     onTap: controller.goToNotificationPages,
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //         color: ColorConstants.mainColor,
                        //         borderRadius: BorderRadius.circular(10.0),
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.grey.withOpacity(0.3),
                        //             blurRadius: 15.0,
                        //             spreadRadius: 1.0,
                        //             offset: Offset(
                        //               -10.0,
                        //               10.0,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Icon(Icons.notifications,
                        //             color: ColorConstants.white, size: 27),
                        //       ),
                        //     )),
                      ),
                    ),
                    CommonWidget.rowHeight(height: sh * 0.03),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0, left: 10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: CommonWidget.minHeadText(text: 'Program')),
                    ),
                    Row(
                      children: [
                        Container(
                          width: sh * 0.3,
                          // height: 40,
                          decoration: BoxDecoration(
                              color: ColorConstants.backgroundTextField,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                              letterSpacing: 0.15,
                              fontFamily: 'Poppins',
                            ),
                            controller: controller.searchNameController,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 10, top: sh * 0.014),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  controller.onSearch(false);
                                  controller.listEvent.clear();
                                  controller.searchNameController.clear();
                                  controller.selectedDate = null;
                                  controller.getData(0);
                                },
                              ),
                              hintText: 'Search...',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 13,
                                letterSpacing: 0.15,
                                fontFamily: 'Poppins',
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            child: InkWell(
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
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: ColorConstants.mainColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 15.0,
                                        spreadRadius: 1.0,
                                        offset: Offset(
                                          -10.0,
                                          10.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.calendar_month_rounded,
                                        size: 20, color: ColorConstants.white),
                                  ),
                                ))),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            width: sw * 0.13,
                            child: InkWell(
                                onTap: () {
                                  controller.listEvent.clear();
                                  controller.getData(1);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue[700],
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 15.0,
                                        spreadRadius: 1.0,
                                        offset: Offset(
                                          -10.0,
                                          10.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CommonWidget.subtitleText(
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.bold,
                                      text: 'CARI',
                                      color: Colors.white70,
                                    ),
                                  ),
                                ))),
                      ],
                    )
                  ],
                ),
              ),
              Container(height: sh * 0.7, child: _getItems(controller))
            ],
          ),
        ],
      ),
    );
  }

  SmartRefresher _getItems(HomeController controller) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoading: controller.onLoading,
      child: ListView.builder(
        itemCount: controller.listEvent.length,
        itemBuilder: (context, i) => InkWell(
          onTap: () {
            controller.goToDetailPages(
                id: controller.listEvent[i].id.toString());
          },
          child: CustomExpandedImageCardView(
              title: controller.listEvent[i].judul ?? '',
              // date:
              //     '${DateFormat("MMMM dd, yyyy", "en_EN").format(controller.listEvent[i].tanggalPelaksanaan ?? DateTime.now())}',
              description: "${controller.listEvent[i].kota}",
              image: '',
              // location: controller.listEvent[i].keterangan ?? '',
              timeStart:
                  '${DateFormat("MMMM dd, yyyy", "en_EN").format(controller.listEvent[i].start ?? DateTime.now())}',
              timeEnd:
                  '${DateFormat("MMMM dd, yyyy", "en_EN").format(controller.listEvent[i].end ?? DateTime.now())}'
              // tipe: controller.listReliver[i].leaveTypeName ?? '',
              ),
        ),
      ),
    );
  }
}
