import 'package:cleaner/modules/lembur/controllers/lembur_controller.dart';
import 'package:cleaner/shared/constants/constants.dart';
import 'package:cleaner/shared/widgets/custom_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LemburView extends GetView<LemburController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'Pengajuan Lembur',
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
            Obx(() => controller.groupId.toString() == '5' ||
                    controller.groupId.toString() == '3'
                ? IconButton(
                    onPressed: controller.goToAddPages,
                    tooltip: 'Tambah',
                    icon: Icon(Icons.add_box_rounded, size: 20),
                  )
                : Container())
          ],
        ),
        body: Obx(() => _getItems(controller)));
  }

  SmartRefresher _getItems(LemburController controller) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoading: controller.onLoading,
      child: ListView.builder(
        itemCount: controller.listOvertime.length,
        itemBuilder: (context, i) => InkWell(
          onTap: () {
            controller.goToDetailPages(
                id: controller.listOvertime[i].id.toString());
          },
          child: CustomExpandedCardView(
            firstParagraf: controller.listOvertime[i].code ?? '',
            secondParagrafLabel: "Nama",
            secondParagrafValue:
                controller.listOvertime[i].userTad?.name.toString() ?? '',
            thirdParagrafLabel: "Pengajuan",
            thirdParagrafValue:
                '${DateFormat("EEEE, d MMMM yyyy", "id_ID").format(controller.listOvertime[i].dateRequest ?? DateTime.now())}',
            forthParagraf: controller.listOvertime[i].branchName.toString(),
            approval:
                controller.listOvertime[i].statusLabel == 'Waiting for approval'
                    ? 'Waiting'
                    : controller.listOvertime[i].statusLabel ?? '',
          ),
        ),
      ),
    );
  }
}
