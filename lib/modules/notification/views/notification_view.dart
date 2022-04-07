import 'package:cleaner/modules/notification/controllers/notification_controller.dart';
import 'package:cleaner/shared/constants/constants.dart';
import 'package:cleaner/shared/widgets/approval.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationView extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'Notifikasi',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20,
              fontFamily: 'Poppins',
            ),
          ),
          backgroundColor: ColorConstants.mainColor,
          elevation: 0.0,
          actions: [
            Obx(() => ApprovalFlow.addButtonApproval(
                controller: controller, onPressed: controller.goToAddCutiPages))
          ],
        ),
        body: Obx(() => _getItems(controller)));
  }

  SmartRefresher _getItems(NotificationController controller) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoading: controller.onLoading,
      child: ListView.builder(
        itemCount: controller.listCuti.length,
        itemBuilder: (context, i) => InkWell(
          onTap: () {
            controller.goToDetailCutiPages(
                id: controller.listCuti[i].id.toString());
          },
          child: Container(
            margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
            // height: 110,
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
            child: ListTile(
              title: Text(controller.listCuti[i].code ?? ''),
              subtitle: Text(
                  '${DateFormat("EEEE, d MMMM yyyy", "id_ID").format(controller.listCuti[i].dateRequest ?? DateTime.now())}'),
            ),
          ),
        ),
      ),
    );
  }
}
