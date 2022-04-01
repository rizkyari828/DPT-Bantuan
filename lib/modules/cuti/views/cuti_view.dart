import 'package:cleaner/modules/cuti/controllers/cuti_controller.dart';
import 'package:cleaner/shared/constants/constants.dart';
import 'package:cleaner/shared/widgets/approval.dart';
import 'package:cleaner/shared/widgets/custom_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CutiView extends GetView<CutiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'Pengajuan Cuti',
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

  SmartRefresher _getItems(CutiController controller) {
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
          child: CustomExpandedCardView(
            firstParagraf: controller.listCuti[i].code ?? '',
            secondParagrafLabel: "Pengajuan",
            secondParagrafValue:
                '${DateFormat("EEEE, d MMMM yyyy", "id_ID").format(controller.listCuti[i].dateRequest ?? DateTime.now())}',
            thirdParagrafLabel: "Tipe",
            thirdParagrafValue: controller.listCuti[i].leaveTypeName.toString(),
            forthParagraf:
                '${DateFormat("d MMMM yyyy", "id_ID").format(controller.listCuti[i].dateStart ?? DateTime.now())} - ${DateFormat("d MMMM yyyy", "id_ID").format(controller.listCuti[i].dateEnd ?? DateTime.now())}',
            approval:
                controller.listCuti[i].statusLabel == 'Waiting for approval'
                    ? 'Waiting'
                    : controller.listCuti[i].statusLabel ?? '',
          ),
        ),
      ),
    );
  }
}
