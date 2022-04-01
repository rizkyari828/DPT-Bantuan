import 'dart:async';

import 'package:cleaner/routes/routes.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:cleaner/models/models.dart';
import 'package:cleaner/shared/shared.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

FutureOr<dynamic> responseInterceptor(
    Request request, Response response) async {
  print(response.body);

  if (response.statusCode == 200) {
  } else {
    print(response.statusCode);
    handleErrorStatus(response);
    // return;
  }
  EasyLoading.dismiss();
  return response;
}

void handleErrorStatus(Response response) {
  if (response.statusCode == 400) {
    final message = ErrorResponse.fromJson(response.body);
    CommonWidget.errorSnackBar(message.message);
    EasyLoading.dismiss();
    return;
  } else if (response.statusCode == 401) {
    final message = ErrorResponse.fromJson(response.body);
    CommonWidget.errorSnackBar(message.message);
    EasyLoading.dismiss();
    return;
  } else if (response.statusCode == 404) {
    final message = ErrorResponse.fromJson(response.body);
    if (message.message == 'Data rating belum tersedia') {
    } else {
      CommonWidget.errorSnackBar(message.message);
    }
    EasyLoading.dismiss();
    return;
  } else if (response.statusCode == 403) {
    final message = ErrorResponse.fromJson(response.body);
    if (message.message == 'Hanya tad yg bisa memberika rating') {
    } else {
      CommonWidget.errorSnackBar(message.message);
    }
    EasyLoading.dismiss();
    return;
  } else {
    EasyLoading.showError('Error occured. Please try again later');
    EasyLoading.dismiss();
    return;
  }
}
