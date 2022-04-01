import 'package:flutter/material.dart';
import 'package:cleaner/shared/shared.dart';

class CustomCardView extends StatelessWidget {
  final String code;
  final String date;
  final String tipe;
  final String approval;
  final String dateStartEnd;
  final bool updateDelete;
  final VoidCallback? onPressedEdit;
  final VoidCallback? onPressedDelete;

  CustomCardView({
    this.code = '',
    this.date = '',
    this.tipe = '',
    this.approval = '',
    this.dateStartEnd = '',
    this.updateDelete = false,
    this.onPressedEdit,
    this.onPressedDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        // BorderSide(color: ColorConstants.borderColor, width: 1)
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
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  code == ''
                      ? SizedBox(height: 0)
                      : CommonWidget.subtitleText(
                          text: code, fontWeight: FontWeight.bold),
                  date == ''
                      ? SizedBox(height: 0)
                      : CommonWidget.minSubtitleText(
                          text: date,
                        ),
                  tipe == ''
                      ? SizedBox(height: 0)
                      : CommonWidget.minSubtitleText(text: tipe),
                  dateStartEnd == ''
                      ? SizedBox(height: 0)
                      : CommonWidget.minSubtitleText(text: dateStartEnd),
                ],
              ),
            ),
            updateDelete
                ? Expanded(
                    child: Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.create,
                              color: Colors.orange,
                              size: 30,
                            ),
                            onPressed: onPressedEdit),
                        IconButton(
                            icon: Icon(
                              Icons.restore_from_trash_rounded,
                              color: Colors.red,
                              size: 30,
                            ),
                            onPressed: onPressedDelete),
                      ],
                    ),
                  ))
                : Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              (approval == "Approved" || approval == "Selesai")
                                  ? Icons.check_circle_outlined
                                  : (approval == "Waiting")
                                      ? Icons.access_time_outlined
                                      : Icons.close,
                              color: (approval == "Approved" ||
                                      approval == "Selesai")
                                  ? Colors.green
                                  : (approval == "Waiting" ||
                                          approval == "Created")
                                      ? Colors.orange
                                      : Colors.red,
                              size: 30,
                            ),
                            CommonWidget.captionText(
                              text: approval,
                              color: (approval == "Approved" ||
                                      approval == "Selesai")
                                  ? Colors.green
                                  : (approval == "Waiting" ||
                                          approval == "Created")
                                      ? Colors.orange
                                      : Colors.red,
                            ),
                          ],
                        )),
                  )
          ],
        ),
      ),
    );
  }
}

class CustomExpandedCardView extends StatelessWidget {
  final String firstParagraf;
  final String secondParagrafLabel;
  final String secondParagrafValue;
  final String thirdParagrafLabel;
  final String thirdParagrafValue;
  final String forthParagraf;
  final String approval;
  final bool updateDelete;
  final VoidCallback? onPressedEdit;
  final VoidCallback? onPressedDelete;

  CustomExpandedCardView({
    this.firstParagraf = '',
    this.secondParagrafLabel = '',
    this.secondParagrafValue = '',
    this.thirdParagrafLabel = '',
    this.thirdParagrafValue = '',
    this.approval = '',
    this.forthParagraf = '',
    this.updateDelete = false,
    this.onPressedEdit,
    this.onPressedDelete,
  });

  @override
  Widget build(BuildContext context) {
    final sw = SizeConfig().screenWidth;
    final sh = SizeConfig().screenHeight;
    return Container(
      margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        // BorderSide(color: ColorConstants.borderColor, width: 1)
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
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  firstParagraf == ''
                      ? SizedBox(height: 0)
                      : CommonWidget.subtitleText(
                          text: firstParagraf, fontWeight: FontWeight.bold),
                  secondParagrafValue == ''
                      ? SizedBox(height: 0)
                      : Row(
                          children: [
                            Container(
                                width: sw * 0.2,
                                child: CommonWidget.minSubtitleText(
                                    text: secondParagrafLabel)),
                            CommonWidget.minSubtitleText(
                                text: ': ' + secondParagrafValue),
                          ],
                        ),
                  thirdParagrafValue == ''
                      ? SizedBox(height: 0)
                      : Row(
                          children: [
                            Container(
                                width: sw * 0.2,
                                child: CommonWidget.minSubtitleText(
                                    text: thirdParagrafLabel)),
                            CommonWidget.minSubtitleText(
                                text: ': ' + thirdParagrafValue),
                          ],
                        ),
                  forthParagraf == ''
                      ? SizedBox(height: 0)
                      : CommonWidget.minSubtitleText(text: forthParagraf),
                ],
              ),
            ),
            updateDelete
                ? Expanded(
                    child: Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.create,
                              color: Colors.orange,
                              size: 30,
                            ),
                            onPressed: onPressedEdit),
                        IconButton(
                            icon: Icon(
                              Icons.restore_from_trash_rounded,
                              color: Colors.red,
                              size: 30,
                            ),
                            onPressed: onPressedDelete),
                      ],
                    ),
                  ))
                : Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              (approval == "Approved" || approval == "Selesai")
                                  ? Icons.check_circle_outlined
                                  : (approval == "Waiting" ||
                                          approval == "Rencana")
                                      ? Icons.access_time_outlined
                                      : Icons.close,
                              color: (approval == "Approved" ||
                                      approval == "Selesai")
                                  ? Colors.green
                                  : (approval == "Waiting" ||
                                          approval == "Progress" ||
                                          approval == "Created" ||
                                          approval == "Rencana")
                                      ? Colors.orange
                                      : Colors.red,
                              size: 30,
                            ),
                            CommonWidget.captionText(
                              text: approval,
                              color: (approval == "Approved" ||
                                      approval == "Selesai")
                                  ? Colors.green
                                  : (approval == "Waiting" ||
                                          approval == "Created" ||
                                          approval == "Progress" ||
                                          approval == "Rencana")
                                      ? Colors.orange
                                      : Colors.red,
                            ),
                          ],
                        )),
                  )
          ],
        ),
      ),
    );
  }
}
