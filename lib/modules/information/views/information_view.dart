import 'package:cleaner/shared/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/information_controller.dart';

class InformationView extends GetView<InformationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      CustomAppBar(
        backButton: true,
        textLabel: "Information",
      ),
    ]));
  }
}
