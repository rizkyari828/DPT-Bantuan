import 'package:cleaner/modules/cuti/controllers/cuti_controller.dart';
import 'package:cleaner/modules/izin/controllers/izin_list_controller.dart';
import 'package:cleaner/shared/constants/constants.dart';
import 'package:cleaner/shared/widgets/approval.dart';
import 'package:cleaner/shared/widgets/custom_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class IzinView extends GetView<IzinListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'Pengajuan Izin',
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
                controller: controller, onPressed: controller.goToAddPages))
          ],
        ),
        body: Obx(() => _getItems(controller)));
  }

  SmartRefresher _getItems(IzinListController controller) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoading: controller.onLoading,
      child: ListView.builder(
        itemCount: controller.listIzin.length,
        itemBuilder: (context, i) => InkWell(
          onTap: () {
            controller.goToDetailPages(
                id: controller.listIzin[i].id.toString());
          },
          child: CustomExpandedCardView(
            firstParagraf: controller.listIzin[i].code ?? '',
            secondParagrafLabel: "Pengajuan",
            secondParagrafValue:
                '${DateFormat("EEEE, d MMMM yyyy", "id_ID").format(controller.listIzin[i].dateRequest ?? DateTime.now())}',
            thirdParagrafLabel: "Tipe",
            thirdParagrafValue: controller.listIzin[i].leaveTypeName.toString(),
            forthParagraf:
                '${DateFormat("d MMMM yyyy", "id_ID").format(controller.listIzin[i].dateStart ?? DateTime.now())} - ${DateFormat("d MMMM yyyy", "id_ID").format(controller.listIzin[i].dateEnd ?? DateTime.now())}',
            approval:
                controller.listIzin[i].statusLabel == 'Waiting for approval'
                    ? 'Waiting'
                    : controller.listIzin[i].statusLabel ?? '',
          ),
        ),
      ),
    );
  }
}
