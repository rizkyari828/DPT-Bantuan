import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AbsensiController extends GetxController {
  //TODO: Implement AbsensiController
  static final LatLng kMapCenter =
      LatLng(19.018255973653343, 72.84793849278007);

  final CameraPosition kInitialPosition =
      CameraPosition(target: kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
