import 'package:get/get.dart';

import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/CnC/bindings/cn_c_binding.dart';
import '../modules/CnC/views/cn_c_add_view.dart';
import '../modules/CnC/views/cn_c_show_view.dart';
import '../modules/CnC/views/cn_c_view.dart';
import '../modules/absensi/bindings/absensi_binding.dart';
import '../modules/absensi/views/absensi_view.dart';
import '../modules/auth/auth.dart';
import '../modules/cuti/bindings/cuti_binding.dart';
import '../modules/cuti/views/cuti_add_view.dart';
import '../modules/cuti/views/cuti_detail_view.dart';
import '../modules/cuti/views/cuti_view.dart';
import '../modules/home/attendance/attendance_binding.dart';
import '../modules/home/home.dart';
import '../modules/information/bindings/information_binding.dart';
import '../modules/information/views/information_view.dart';
import '../modules/izin/bindings/izin_binding.dart';
import '../modules/izin/views/add_izin_view.dart';
import '../modules/izin/views/detail_izin_view.dart';
import '../modules/izin/views/izin_view.dart';
import '../modules/lembur/bindings/lembur_binding.dart';
import '../modules/lembur/views/add_lembur_view.dart';
import '../modules/lembur/views/detail_lembur_view.dart';
import '../modules/lembur/views/lembur_view.dart';
import '../modules/modules.dart';
import '../modules/recap/bindings/recap_binding.dart';
import '../modules/recap/views/recap_view.dart';
import '../modules/reliver/bindings/reliver_binding.dart';
import '../modules/reliver/views/reliver_add_view.dart';
import '../modules/reliver/views/reliver_detail_view.dart';
import '../modules/reliver/views/reliver_view.dart';
import '../modules/task_list/bindings/task_list_binding.dart';
import '../modules/task_list/views/korlap/tad/task_list_tad_korlap_detail_view.dart';
import '../modules/task_list/views/korlap/tad/task_list_tad_korlap_list_view.dart';
import '../modules/task_list/views/korlap/task_list_detail_korlap.dart';
import '../modules/task_list/views/task_list_add_view.dart';
import '../modules/task_list/views/task_list_detail.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    // GetPage(
    //   name: Routes.AUTH,
    //   page: () => AuthScreen(),
    //   binding: AuthBinding(),
    //   children: [
    //     GetPage(name: Routes.REGISTER, page: () => RegisterScreen()),
    //     GetPage(name: Routes.LOGIN, page: () => LoginScreen()),
    //   ],
    // ),
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
      name: Routes.ADD_CNC,
      page: () => CnCAddView(),
      binding: CnCBinding(),
    ),
    GetPage(
      name: Routes.CN_C,
      page: () => CnCView(),
      binding: CnCBinding(),
    ),
    GetPage(
      name: Routes.IZIN,
      page: () => IzinView(),
      binding: IzinBinding(),
    ),
    GetPage(
      name: Routes.ADD_IZIN,
      page: () => AddIzinView(),
      binding: IzinBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_IZIN,
      page: () => IzinDetailView(),
      binding: IzinBinding(),
    ),
    GetPage(
      name: Routes.LEMBUR,
      page: () => LemburView(),
      binding: LemburBinding(),
    ),
    GetPage(
      name: Routes.ADD_LEMBUR,
      page: () => LemburAddView(),
      binding: LemburBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_LEMBUR,
      page: () => LemburDetailView(),
      binding: LemburBinding(),
    ),
    GetPage(
      name: Routes.CUTI,
      page: () => CutiView(),
      binding: CutiBinding(),
    ),
    GetPage(
      name: Routes.ADD_CUTI,
      page: () => CutiAddView(),
      binding: CutiBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_CUTI,
      page: () => CutiDetailView(),
      binding: CutiBinding(),
    ),
    GetPage(
      name: Routes.ABSENSI,
      page: () => AbsensiView(),
      binding: AbsensiBinding(),
    ),
    GetPage(
      name: Routes.TASK_LIST_ADD,
      page: () => TaskListAddView(),
      binding: TaskListBinding(),
    ),
    GetPage(
      name: Routes.TASK_LIST_DETAIL,
      page: () => TaskListDetailView(),
      binding: TaskListBinding(),
    ),
    GetPage(
      name: Routes.TASK_LIST_KORLAP_DETAIL,
      page: () => TaskListDetailKorlapView(),
      binding: TaskListBinding(),
    ),
    GetPage(
      name: Routes.TASK_LIST_TAD_KORLAP_LIST,
      page: () => ListTaskListTadKorlapView(),
      binding: TaskListBinding(),
    ),
    GetPage(
      name: Routes.TASK_LIST_TAD_KORLAP_DETAIL,
      page: () => TaskListTadKorlapDetailView(),
      binding: TaskListBinding(),
    ),
    GetPage(
      name: Routes.INFORMATION,
      page: () => InformationView(),
      binding: InformationBinding(),
    ),
    GetPage(
      name: Routes.RECAP,
      page: () => RecapView(),
      binding: RecapBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_CNC,
      page: () => CnCShowView(),
      binding: CnCBinding(),
    ),
    GetPage(
      name: Routes.DISCOVER_TAB,
      page: () => DiscoverTab(),
      binding: AttendanceBinding(),
    ),
    GetPage(
      name: Routes.RELIVER,
      page: () => ReliverView(),
      binding: ReliverBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_RELIVER,
      page: () => ReliverDetailView(),
      binding: ReliverBinding(),
    ),
    GetPage(
      name: Routes.ADD_RELIVER,
      page: () => ReliverAddView(),
      binding: ReliverBinding(),
    ),
    GetPage(
      name: Routes.NOTIFICATION,
      page: () => NotificationView(),
      binding: NotificationBinding(),
    ),
  ];
}
