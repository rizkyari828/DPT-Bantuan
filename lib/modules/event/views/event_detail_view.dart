import 'package:konconeDeDe/modules/event/controllers/event_detail_controller.dart';
import 'package:konconeDeDe/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:konconeDeDe/shared/widgets/button.dart';

class ReliverDetailView extends GetView<ReliverDetailController> {
  final data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    final sw = SizeConfig().screenWidth;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonWidget.appBar(title: 'Detail Campaign'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   width: sw,
                //   height: sw * .5,
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.all(Radius.circular(10)),
                //     child: Container(
                //       decoration: BoxDecoration(
                //         color: Colors.black,
                //         image: new DecorationImage(
                //           fit: BoxFit.cover,
                //           image: new NetworkImage(
                //             '',
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(height: 20.0),
                CommonWidget.minHeadText(
                    text: controller.detail.value.judul ?? ''),
                SizedBox(height: 20.0),
                CommonWidget.labelRowText(
                    text: 'Mulai',
                    widget: CommonWidget.subtitleText(
                        text: DateFormat("MMMM dd, yyyy", "en_EN").format(
                            controller.detail.value.start ?? DateTime.now()))),
                SizedBox(height: 10.0),
                CommonWidget.labelRowText(
                    text: 'Selesai',
                    widget: CommonWidget.subtitleText(
                        text: DateFormat("MMMM dd, yyyy", "en_EN").format(
                            controller.detail.value.end ?? DateTime.now()))),
                SizedBox(height: 10.0),
                CommonWidget.labelRowText(
                    text: 'Kota',
                    widget: CommonWidget.subtitleText(
                        text: controller.detail.value.kota ?? '')),
                SizedBox(height: 10.0),
                CommonWidget.labelRowText(
                    text: 'Komandante',
                    widget: CommonWidget.subtitleText(
                        text: controller.nameKomandante.value)),
                SizedBox(height: 10.0),
                CommonWidget.subtitleText(
                    textAlign: TextAlign.justify,
                    text: controller.detail.value.keterangan ?? ''),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: sw * .08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomButton(
              buttonColor: Colors.orange,
              buttonText: 'LIST PENERIMA',
              width: sw,
              onPressed: () {
                controller.goToPenerimaPages();
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomButton(
              buttonColor: Colors.green,
              buttonText: 'BUKA QR SCANNER',
              width: sw,
              onPressed: () {
                controller.goToScannerPages();
              },
            ),
          ],
        ),
      ),
    );
  }
}
