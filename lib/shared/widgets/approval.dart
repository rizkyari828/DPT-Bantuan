import 'dart:io';

import 'package:cleaner/modules/reliver/controllers/reliver_detail_controller.dart';
import 'package:cleaner/routes/app_pages.dart';
import 'package:cleaner/shared/utils/common_widget.dart';
import 'package:cleaner/shared/utils/size_config.dart';
import 'package:cleaner/shared/widgets/button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApprovalFlow {
  static Widget buttonApprovalCnC(controller) {
    final sw = SizeConfig().screenWidth;
    final sh = SizeConfig().screenHeight;
    return Container(
      child: controller.detail.value.statusLabel == 'Waiting for approval'
          ? controller.groupId.toString() == '5'
              ? controller.detail.value.statusLabel == 'Waiting for approval'
                  ? Container(
                      child: CustomButton(
                        buttonText: 'SIMPAN',
                        width: sw,
                        onPressed: () {
                          controller.submit();
                        },
                      ),
                    )
                  : Container()
              : Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        buttonColor: Colors.red,
                        buttonText: 'REJECT',
                        width: sw / 2.5,
                        onPressed: () {
                          controller.approval(action: 'reject');
                        },
                      ),
                      CustomButton(
                        buttonColor: Colors.green,
                        buttonText: 'APPROVE',
                        width: sw / 2.5,
                        onPressed: () {
                          controller.approval(action: 'approve');
                        },
                      ),
                    ],
                  ),
                )
          : Container(),
    );
  }

  static Widget buttonApproval(controller) {
    final sw = SizeConfig().screenWidth;
    final sh = SizeConfig().screenHeight;
    return Container(
      child: controller.detail.value.status == '1' ||
              controller.detail.value.statusLabel == 'Created'
          ? controller.groupId.toString() == '5'
              ? controller.detail.value.statusLabel == 'Created'
                  ? Container(
                      child: CustomButton(
                        buttonText: 'SIMPAN',
                        width: sw,
                        onPressed: () {
                          controller.submit();
                        },
                      ),
                    )
                  : Container()
              : Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        buttonColor: Colors.red,
                        buttonText: 'REJECT',
                        width: sw / 2.5,
                        onPressed: () {
                          controller.approval(action: 'reject');
                        },
                      ),
                      CustomButton(
                        buttonColor: Colors.green,
                        buttonText: 'APPROVE',
                        width: sw / 2.5,
                        onPressed: () {
                          controller.approval(action: 'approve');
                        },
                      ),
                    ],
                  ),
                )
          : Container(),
    );
  }

  static Widget hideWidget(id, widget) {
    return id != '5' ? widget : Container();
  }

  static Widget statusApproval(data) {
    final sw = SizeConfig().screenWidth;
    final sh = SizeConfig().screenHeight;
    return Container(
        width: sw,
        height: sh * .05,
        child: Card(
            elevation: 0,
            color: data.status == '2' || data.statusLabel == 'Selesai'
                ? Colors.green
                : data.status == '1' ||
                        data.statusLabel == 'Created' ||
                        data.statusLabel == 'Rencana'
                    ? Colors.yellow[800]
                    : Colors.red,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            )),
            child: Center(
                child: CommonWidget.bodyText(
                    text: data.statusLabel.toString(), color: Colors.white))));
  }

  static Widget deleteButtonApproval({controller, name}) {
    return controller.groupId.toString() != '3'
        ? IconButton(
            onPressed: () {
              controller.deleteGoods(name: name);
            },
            icon: Icon(Icons.close_rounded),
            color: Colors.red,
          )
        : Container();
  }

  static Widget addButtonApproval({controller, name, onPressed, showId = '5'}) {
    return controller.groupId.toString() == showId
        ? IconButton(
            onPressed: onPressed,
            tooltip: 'Tambah',
            icon: Icon(Icons.add_box_rounded, size: 20),
          )
        : Container();
  }
}
