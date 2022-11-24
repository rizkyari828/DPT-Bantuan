import 'package:get/get.dart';
import 'package:sales/modules/event/bindings/event_binding.dart';
import 'package:sales/modules/event/views/event_detail_view.dart';
import 'package:sales/modules/event/views/event_view.dart';
import 'package:sales/modules/event/views/qrcode_scanner_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/auth/auth.dart';
import '../modules/home/home.dart';
import '../modules/modules.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.EVENT,
      page: () => EventView(),
      binding: EventBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_EVENT,
      page: () => ReliverDetailView(),
      binding: EventBinding(),
    ),
    GetPage(
      name: Routes.QRSCANNER,
      page: () => QRScannerView(),
      binding: EventBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.NOTIFICATION,
      page: () => NotificationView(),
      binding: NotificationBinding(),
    ),
  ];
}
