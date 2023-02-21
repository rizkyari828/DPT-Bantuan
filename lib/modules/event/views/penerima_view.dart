import 'package:konconeDeDe/modules/event/controllers/event_controller.dart';
import 'package:konconeDeDe/shared/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:konconeDeDe/shared/constants/colors.dart';
import 'package:konconeDeDe/shared/utils/common_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RecapView extends GetView<EventController> {
  final data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    final sw = SizeConfig().screenWidth;
    final sh = SizeConfig().screenHeight;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'List Penerima',
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
                        color: Colors.red.shade50,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonWidget.subtitleText(text: 'Program'),
                                  CommonWidget.minHeadText(
                                      text:
                                          controller.detail.value.judul ?? ''),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
                  Container(
                    color: Colors.red.shade200,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: sw * .15,
                                child: CommonWidget.minSubtitleText(
                                    text: 'Tanggal',
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: sw * .01,
                            ),
                            Container(
                                width: sw * .2,
                                child: CommonWidget.minSubtitleText(
                                    text: 'Nama', fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: sw * .01,
                            ),
                            Container(
                                width: sw * .15,
                                child: CommonWidget.minSubtitleText(
                                    text: 'NIK', fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Obx(() =>
                      Container(height: sh * 0.7, child: _getItems(controller)))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SmartRefresher _getItems(EventController controller) {
    // final sh = SizeConfig().screenHeight;
    final sw = SizeConfig().screenWidth;
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoading: controller.onLoading,
      child: ListView.builder(
        itemCount: controller.listPenerima.length,
        itemBuilder: (context, i) => Container(
          margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: sw * .15,
                    child: CommonWidget.minSubtitleText(
                        text: DateFormat("dd/MM/yyyy", "id_ID")
                            .format(controller.listPenerima[i].createDate ??
                                DateTime.now())
                            .toString()),
                  ),
                  SizedBox(
                    width: sw * .01,
                  ),
                  Container(
                    width: sw * .2,
                    child: CommonWidget.minSubtitleText(
                        text: controller.listPenerima[i].nama ?? ''),
                  ),
                  SizedBox(
                    width: sw * .01,
                  ),
                  Container(
                    width: sw * .15,
                    child: CommonWidget.minSubtitleText(
                        text: controller.listPenerima[i].ktp ?? ''),
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
        ),
      ),
    );
  }
}
