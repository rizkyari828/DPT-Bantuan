import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:shared_preferences/shared_preferences.dart';

FutureOr<Request> requestInterceptor(request) async {
  var prefs = Get.find<SharedPreferences>();
  final token = prefs.getString('token') ?? "";
  print('Bearer ' + token);

  request.headers['X-Requested-With'] = 'XMLHttpRequest';
  request.headers['Authorization'] = 'Bearer $token';

  EasyLoading.show(status: 'loading..');
  return request;
}
