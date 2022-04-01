import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/absensi_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AbsensiView extends GetView<AbsensiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AbsensiView'),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: controller.kInitialPosition,
      ),
    );
  }
}
