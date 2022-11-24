import 'dart:async';
import 'package:sales/models/models.dart';
import 'package:sales/models/request/detail_request.dart';
import 'package:sales/models/request/logout_request.dart';
import 'package:sales/models/request/reliver/approve_reliver_request.dart';
import 'package:sales/models/request/reliver/create_reliver_request.dart';
import 'package:sales/models/response/branch_response.dart';
import 'package:sales/models/response/name_tad_list_response.dart';
import 'package:sales/models/response/reliver/list_reliver_response.dart';
import 'package:sales/models/response/reliver/show_reliver_response.dart';
import 'package:sales/models/response/user/logout_response.dart';
import 'package:sales/models/response/user/user_schedule.dart';
import 'package:sales/models/response/user/users_response.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'api.dart';

class ApiRepository {
  ApiRepository({required this.apiProvider});

  final ApiProvider apiProvider;
  final int timeout = 60;

  Future<LoginRespons?> login(
      String username, String password, LoginRequest data) async {
    try {
      final res = await apiProvider
          .login('/auth/login', data)
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return LoginRespons.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
    return null;
  }

  Future<EventResponse?> listEvent(
      {int page: 1, String idKomandante: '', String keyword: ''}) async {
    try {
      final res = await apiProvider
          .getReliver(
              '/campaign/list?page=$page&id_komandante=$idKomandante&keyword=$keyword')
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return EventResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
    return null;
  }

  Future<ShowReliverResponse?> showReliver(String id) async {
    try {
      final res = await apiProvider
          .getShowReliver('/campaign/showc?id=$id')
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return ShowReliverResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
    return null;
  }

  Future<ErrorResponse?> submitQr(CreateReliverRequest data) async {
    try {
      print(data);
      final res = await apiProvider
          .submitReliver('/campaign/submitqr', data)
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return ErrorResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
    return null;
  }
}
