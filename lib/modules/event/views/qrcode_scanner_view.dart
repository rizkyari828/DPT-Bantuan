import 'package:flutter/cupertino.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sales/modules/event/controllers/event_detail_controller.dart';
import 'package:sales/modules/event/controllers/qr_code_controller.dart';
import 'package:sales/modules/event/views/qr_scanner_overlay.dart';
import 'package:sales/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sales/shared/utils/size.dart';
import 'package:sales/shared/widgets/button.dart';

class QRScannerView extends GetView<QRCodeController> {
  final data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final sw = SizeConfig().screenWidth;
    Size size = MediaQuery.of(context).size;
    double scaleWidth = size.width / 360;

    return Scaffold(
        body: Obx(
      () => ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: size.width,
          minHeight: size.height,
        ),
        child: IntrinsicHeight(
          child: Container(
            height: double.infinity,
            child: Stack(
              children: <Widget>[
                MobileScanner(
                  controller: controller.cameraController,
                  allowDuplicates: false,
                  onDetect: (barcode, args) {
                    controller.onSuccessScan(barcode.rawValue);
                  },
                ),
                QRScannerOverlay(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.only(
                        top: size.height * 0.05,
                        left: AppSize.DIMEN_20,
                      ),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            onPressed: controller.onWillPop,
                            color: Colors.white,
                          ),
                          SizedBox(width: AppSize.DIMEN_10 * scaleWidth),
                          IconButton(
                            icon: controller.isFlashOn
                                ? Icon(Icons.flash_on)
                                : Icon(Icons.flash_off),
                            onPressed: controller.toggleFlash,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.only(
                        top: size.height * 0.05,
                        right: AppSize.DIMEN_20,
                      ),
                      child: IconButton(
                        icon: Icon(CupertinoIcons.camera_rotate),
                        onPressed: controller.toggleCamera,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    height: AppSize.DIMEN_160 * scaleWidth,
                    width: AppSize.DIMEN_360 * scaleWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppSize.RADIUS_10),
                        topRight: Radius.circular(AppSize.RADIUS_10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          CommonWidget.minHeadText(
                              text: controller.stringQr.value != ""
                                  ? 'Hasil Scan'
                                  : ''),
                          SizedBox(height: 10.0),
                          CommonWidget.subtitleText(
                              textAlign: TextAlign.justify,
                              text: controller.stringQr.value == ""
                                  ? 'Silahkan lakukan scan QR Code'
                                  : controller.stringQr.value),
                          SizedBox(height: 30.0),
                          CustomButton(
                            isDisabled:
                                controller.stringQr.value == "" ? true : false,
                            buttonColor: Colors.green,
                            buttonText: 'SIMPAN',
                            width: sw,
                            onPressed: () {
                              controller.submit();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
