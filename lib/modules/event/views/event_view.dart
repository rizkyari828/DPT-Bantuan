import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';
import 'package:konconeDeDe/modules/event/controllers/event_controller.dart';
import 'package:konconeDeDe/shared/constants/constants.dart';
import 'package:konconeDeDe/shared/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EventView extends GetView<EventController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          iconTheme: IconThemeData(color: Colors.black87),
          title: Obx(() => controller.isSearch.value
              ? Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: ColorConstants.backgroundTextField,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    onSubmitted: (value) {
                      controller.getData(1);
                    },
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                      letterSpacing: 0.15,
                      fontFamily: 'Poppins',
                    ),
                    controller: controller.searchNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          controller.onSearch(false);
                          // controller.searchNameController.clear();
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
                )
              : Text(
                  'Campaign',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                  ),
                )),
          backgroundColor: ColorConstants.lightScaffoldBackgroundColor,
          elevation: 0.0,
          actions: [
            Obx(() => controller.isSearch.value == false
                ? Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          controller.onSearch(true);
                        },
                        tooltip: 'Search',
                        icon: Icon(Icons.search_rounded, size: 20),
                      ),
                      IconButton(
                        onPressed: () {
                          showMonthPicker(
                            context: context,
                            firstDate: DateTime(DateTime.now().year - 1, 5),
                            lastDate: DateTime(DateTime.now().year + 1, 9),
                            initialDate:
                                controller.selectedDate ?? DateTime.now(),
                          ).then((date) {
                            if (date != null) {
                              controller.selectedDate = date;
                              controller.month.value =
                                  DateFormat("MMMM yyyy", "id_ID")
                                      .format(date)
                                      .toString();
                              controller.listEvent.clear();
                              controller.getData(1);
                            }
                          });
                        },
                        tooltip: 'Pilih Bulan',
                        icon: Icon(Icons.calendar_month_rounded, size: 20),
                      ),
                    ],
                  )
                : Container())
          ],
        ),
        body: Obx(() => _getItems(controller)));
  }

  SmartRefresher _getItems(EventController controller) {
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
            description: controller.listEvent[i].area ?? '',
            image: '',
            location: controller.listEvent[i].keterangan ?? '',
            // time:
            //     '${DateFormat("MMMM dd, yyyy", "en_EN").format(controller.listEvent[i].start ?? DateTime.now())} - ${DateFormat("MMMM dd, yyyy", "en_EN").format(controller.listEvent[i].end ?? DateTime.now())}',
            // tipe: controller.listReliver[i].leaveTypeName ?? '',
          ),
        ),
      ),
    );
  }
}
