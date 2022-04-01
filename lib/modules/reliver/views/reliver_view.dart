import 'package:cleaner/modules/cuti/controllers/cuti_controller.dart';
import 'package:cleaner/modules/izin/controllers/izin_list_controller.dart';
import 'package:cleaner/modules/reliver/controllers/reliver_controller.dart';
import 'package:cleaner/shared/constants/constants.dart';
import 'package:cleaner/shared/widgets/approval.dart';
import 'package:cleaner/shared/widgets/custom_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ReliverView extends GetView<ReliverController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'Pengajuan Reliver',
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
                controller: controller,
                onPressed: controller.goToAddPages,
                showId: '3'))
          ],
        ),
        body: Obx(() => _getItems(controller)));
  }

  SmartRefresher _getItems(ReliverController controller) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoading: controller.onLoading,
      child: ListView.builder(
        itemCount: controller.listReliver.length,
        itemBuilder: (context, i) => InkWell(
          onTap: () {
            controller.goToDetailPages(
                id: controller.listReliver[i].id.toString());
          },
          child: CustomExpandedCardView(
            firstParagraf: controller.listReliver[i].code ?? '',
            secondParagrafLabel: 'Pengajuan',
            secondParagrafValue:
                '${DateFormat("EEEE, d MMMM yyyy", "id_ID").format(controller.listReliver[i].dateRequest ?? DateTime.now())}',
            forthParagraf:
                '${DateFormat("d MMMM yyyy", "id_ID").format(controller.listReliver[i].dateNeeded ?? DateTime.now())} - ${DateFormat("d MMMM yyyy", "id_ID").format(controller.listReliver[i].dateEndNeeded ?? DateTime.now())}',
            // tipe: controller.listReliver[i].leaveTypeName ?? '',
            approval: controller.listReliver[i].status == '1'
                ? 'Waiting'
                : controller.listReliver[i].statusLabel ?? '',
          ),
        ),
      ),
    );
  }
}
