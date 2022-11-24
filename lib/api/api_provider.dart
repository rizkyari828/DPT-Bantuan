import 'package:sales/api/base_provider.dart';
import 'package:sales/models/models.dart';
import 'package:sales/models/request/detail_request.dart';
import 'package:sales/models/request/logout_request.dart';
import 'package:get/get.dart';
import 'package:sales/models/request/reliver/approve_reliver_request.dart';
import 'package:sales/models/request/reliver/create_reliver_request.dart';

class ApiProvider extends BaseProvider {
  Future<Response> login(String path, LoginRequest data) {
    print(data.toJson());
    return post(path, data.toJson());
  }

  Future<Response> logout(String path, LogoutRequest data) {
    return post(path, data.toJson());
  }

  Future<Response> getUsers(String path) {
    return get(path);
  }

  Future<Response> getUserSchedule(String path) {
    return get(path);
  }

  Future<Response> getMasterData(String path) {
    return get(path);
  }
  //END OVERTIME

  Future<Response> getTypeIzin(String path) {
    return get(path);
  }

  //START IZIN
  Future<Response> getReliver(String path) {
    return get(path);
  }

  //START TASKLIST
  Future<Response> getTaskList(String path) {
    return get(path);
  }

  Future<Response> getShowTaskList(String path) {
    print(path);
    return get(path);
  }

  Future<Response> deleteTaskList(String path) {
    return delete(path);
  }

  Future<Response> getType(String path) {
    return get(path);
  }

  Future<Response> getTaskName(String path) {
    return get(path);
  }

  Future<Response> getBranchList(String path) {
    return get(path);
  }

  Future<Response> listTaskListTadKorlap(String path) {
    return get(path);
  }

  Future<Response> showTaskListTadKorlap(String path) {
    return get(path);
  }

  Future<Response> getRate(String path) {
    return get(path);
  }

  Future<Response> getShowReliver(String path) {
    return get(path);
  }

  Future<Response> submitReliver(String path, CreateReliverRequest data) {
    print(data.toJson());
    return post(path, data.toJson());
  }

  Future<Response> updateApprovalReliver(
      String path, ApproveReliverRequest data) {
    return patch(path, data.toJson());
  }
}
