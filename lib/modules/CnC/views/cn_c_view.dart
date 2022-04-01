import 'package:cleaner/modules/CnC/controllers/cn_c_list_controller.dart';
import 'package:cleaner/shared/constants/constants.dart';
import 'package:cleaner/shared/widgets/approval.dart';
import 'package:cleaner/shared/widgets/custom_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CnCView extends GetView<CnCListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'CnC',
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
                controller: controller, onPressed: controller.goToAddCnCPages))
          ],
        ),
        body: Obx(() => _getItems(controller)));
  }

  SmartRefresher _getItems(CnCListController controller) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoading: controller.onLoading,
      child: ListView.builder(
        itemCount: controller.listCnC.length,
        itemBuilder: (context, i) => InkWell(
          onTap: () {
            controller.goToDetailCnCPages(
                id: controller.listCnC[i].id.toString());
          },
          child: CustomExpandedCardView(
            firstParagraf: controller.listCnC[i].code ?? '',
            secondParagrafLabel: "Pengajuan",
            secondParagrafValue:
                '${DateFormat("EEEE, d MMMM yyyy", "id_ID").format(controller.listCnC[i].date ?? DateTime.now())}',
            thirdParagrafLabel: "Client",
            thirdParagrafValue: controller.listCnC[i].branchName.toString(),
            approval:
                controller.listCnC[i].statusLabel == 'Waiting for approval'
                    ? 'Waiting'
                    : controller.listCnC[i].statusLabel ?? '',
          ),
        ),
      ),
    );
  }
}
