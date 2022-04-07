import 'dart:async';
import 'package:cleaner/models/models.dart';
import 'package:cleaner/models/request/attendance/submit_attendance.dart';
import 'package:cleaner/models/request/cnc/approval_cnc.dart';
import 'package:cleaner/models/request/cnc/submit_cnc.dart';
import 'package:cleaner/models/request/cuti/submit_cuti_request.dart';
import 'package:cleaner/models/request/cuti/update_approval_request.dart';
import 'package:cleaner/models/request/izin/submit_izin_request.dart';
import 'package:cleaner/models/request/izin/update_approval_request.dart';
import 'package:cleaner/models/request/logout_request.dart';
import 'package:cleaner/models/request/overtime/set_done_overtime_request.dart';
import 'package:cleaner/models/request/overtime/submit_overtime_client_request.dart';
import 'package:cleaner/models/request/overtime/submit_request_overtime.dart';
import 'package:cleaner/models/request/overtime/update_approval_overtime_request.dart';
import 'package:cleaner/models/request/rate/submit_rate_request.dart';
import 'package:cleaner/models/request/reliver/approve_reliver_request.dart';
import 'package:cleaner/models/request/reliver/create_reliver_request.dart';
import 'package:cleaner/models/request/taskList/create_task_list_general_khusus.dart';
import 'package:cleaner/models/request/taskList/create_task_list_khusus.dart';
import 'package:cleaner/models/request/taskList/update_task_list_tad_before_request.dart';
import 'package:cleaner/models/request/taskList/update_task_tad.dart';
import 'package:cleaner/models/request/update_fcm_profile_request.dart';
import 'package:cleaner/models/request/update_photo_profile_request.dart';
import 'package:cleaner/models/response/attendance/attendance_submit.dart';
import 'package:cleaner/models/response/attendance/attendance_validate.dart';
import 'package:cleaner/models/response/branch_response.dart';
import 'package:cleaner/models/response/cnc/category.dart';
import 'package:cleaner/models/response/cnc/list.dart';
import 'package:cleaner/models/response/cnc/list_item.dart';
import 'package:cleaner/models/response/cnc/show.dart';
import 'package:cleaner/models/response/cnc/submit.dart';
import 'package:cleaner/models/response/cuti/list_cuti.dart';
import 'package:cleaner/models/response/cuti/show_cuti.dart';
import 'package:cleaner/models/response/cuti/type_cuti.dart';
import 'package:cleaner/models/response/izin/list_izin.dart';
import 'package:cleaner/models/response/izin/show_izin.dart';
import 'package:cleaner/models/response/izin/type_izin.dart';
import 'package:cleaner/models/response/name_tad_list_response.dart';
import 'package:cleaner/models/response/overtime/approval.dart';
import 'package:cleaner/models/response/overtime/list.dart';
import 'package:cleaner/models/response/overtime/show.dart';
import 'package:cleaner/models/response/rate/show_rate_review_response.dart';
import 'package:cleaner/models/response/recap_history.dart';
import 'package:cleaner/models/response/reliver/list_reliver_response.dart';
import 'package:cleaner/models/response/reliver/show_reliver_response.dart';
import 'package:cleaner/models/response/taskList/korlap/list_task_list_tad_response.dart';
import 'package:cleaner/models/response/taskList/korlap/show_task_list_tad_korlap_response.dart';
import 'package:cleaner/models/response/taskList/master/task_name_response.dart';
import 'package:cleaner/models/response/taskList/master/task_type_response.dart';
import 'package:cleaner/models/response/taskList/show_task_list_khusus_response.dart';
import 'package:cleaner/models/response/taskList/show_task_list_response.dart';
import 'package:cleaner/models/response/taskList/tad/show_task_list_tad_response.dart';
import 'package:cleaner/models/response/taskList/tad/task_list_tad_response.dart';
import 'package:cleaner/models/response/taskList/task_list_response.dart';
import 'package:cleaner/models/response/update_profile_response.dart';
import 'package:cleaner/models/response/user/logout_response.dart';
import 'package:cleaner/models/response/user/user_schedule.dart';
import 'package:cleaner/models/response/user/users_response.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'api.dart';

class ApiRepository {
  ApiRepository({required this.apiProvider});

  final ApiProvider apiProvider;
  final int timeout = 60;

  Future<LoginResponse?> login(LoginRequest data) async {
    try {
      final res = await apiProvider
          .login('/api/v1/auth/login', data)
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return LoginResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<LogoutResponse?> logout(LogoutRequest data) async {
    final res = await apiProvider
        .logout('/api/v1/auth/logout', data)
        .timeout(Duration(seconds: timeout));
    if (res.statusCode == 200) {
      return LogoutResponse.fromJson(res.body);
    }
  }

  Future<UsersResponse?> getUsers() async {
    final res = await apiProvider.getUsers('/api/users?page=1&per_page=12');
    if (res.statusCode == 200) {
      return UsersResponse.fromJson(res.body);
    }
  }

  Future<UserScheduleResponse?> getUserSchedule() async {
    final res = await apiProvider.getUserSchedule('/api/v1/user/schedule');
    if (res.statusCode == 200) {
      return UserScheduleResponse.fromJson(res.body);
    }
  }

  Future<RecapHistoryResponse?> getRecapHistory(month) async {
    try {
      final res = await apiProvider
          .getRecapHistory('/api/v1/user/attendence?month=$month')
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200) {
        return RecapHistoryResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<AttendanceValidateResponse?> validateAttendance(
      double latitude, double longitude) async {
    final link = '/api/v1/user/validate-location?latitude=' +
        latitude.toString() +
        '&longitude=' +
        longitude.toString();
    try {
      final res = await apiProvider
          .validateAttendance(link)
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return AttendanceValidateResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<AttendanceSubmitResponse?> submitAttendance(
      AttendanceSubmitRequest data) async {
    try {
      final res = await apiProvider
          .submitAttendance('/api/v1/user/attendence', data)
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return AttendanceSubmitResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  // START CNC
  Future<CnCItemResponse?> listCnCItem(String categoryId) async {
    try {
      final res = await apiProvider
          .getCnCItem(
              '/api/v1/cnc/item?page=1&limit=1000&category_id=' + categoryId)
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return CnCItemResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<CnCItemResponse?> listAllCnCItem() async {
    try {
      final res = await apiProvider
          .getCnCItem('/api/v1/cnc/item?page=1&limit=1000')
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return CnCItemResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<CategoryCnCResponse?> listCnCCategory() async {
    try {
      final res = await apiProvider
          .getCnCCategory('/api/v1/cnc/category-item?page=1&limit=1000')
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return CategoryCnCResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<CnCResponse?> listCnC({int page: 1, int limit: 10}) async {
    try {
      final res = await apiProvider
          .getCnC('/api/v1/cnc?page=' +
              page.toString() +
              '&limit=' +
              limit.toString())
          .timeout(Duration(seconds: timeout));
      // final res = await apiProvider
      //     .getCnC('/api/v1/long-timeout')
      //     .timeout(Duration(seconds: timeout));

      if (res.statusCode == 200 || res.statusCode == 401) {
        return CnCResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<ShowCnCResponse?> showCnC(String id) async {
    try {
      final res = await apiProvider
          .getShowCnC('/api/v1/cnc/' + id)
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return ShowCnCResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<SubmitCnCResponse?> submitCnC(SubmitCnCRequest data) async {
    try {
      final res = await apiProvider
          .submitCnC('/api/v1/cnc', data)
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return SubmitCnCResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<ErrorResponse?> updateApprovalCnC(
      String id, ApprovalCnCRequest data) async {
    try {
      print(data.itemList);
      final res = await apiProvider
          .updateApprovalCnC('/api/v1/cnc/' + id, data)
          .timeout(Duration(seconds: timeout));
      print(res);
      if (res.statusCode == 200 || res.statusCode == 401) {
        return ErrorResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }
  //END CNC

  //START OVERTIME
  Future<OvertimeResponse?> listOvertime({int page: 1, int limit: 10}) async {
    try {
      final res = await apiProvider
          .getOvertime('/api/v1/overtime?page=' +
              page.toString() +
              '&limit=' +
              limit.toString())
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return OvertimeResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<ShowOvertimeResponse?> showOvertime(String id) async {
    try {
      final res = await apiProvider
          .getShowOvertime('/api/v1/overtime/' + id)
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return ShowOvertimeResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<ErrorResponse?> submitOvertime(SubmitOvertimeRequest data) async {
    try {
      final res = await apiProvider
          .submitOvertime('/api/v1/overtime', data)
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200) {
        return ErrorResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<ErrorResponse?> submitOvertimeClient(
      SubmitOvertimeClientRequest data) async {
    try {
      final res = await apiProvider
          .submitOvertimeClient('/api/v1/overtime', data)
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200) {
        return ErrorResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<UpdateApprovalOvertimeRespons?> updateApprovalOvertime(
      String id, UpdateApprovalOvertimeRequest data) async {
    try {
      final res = await apiProvider
          .updateApprovalOvertime('/api/v1/overtime/update-status/' + id, data)
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return UpdateApprovalOvertimeRespons.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<ErrorResponse?> setDoneOvertime(
      String id, SetDoneOvertimeRequest data) async {
    print(data);
    try {
      final res = await apiProvider
          .setDoneOvertime('/api/v1/overtime/set-done/' + id, data)
          .timeout(Duration(seconds: timeout));
      print(res);
      if (res.statusCode == 200 || res.statusCode == 401) {
        return ErrorResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }
  //END OVERTIME

  //START CUTI
  Future<CutiResponse?> listCuti({int page: 1, int limit: 10}) async {
    try {
      final res = await apiProvider
          .getCuti('/api/v1/cuti?page=' +
              page.toString() +
              '&limit=' +
              limit.toString())
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return CutiResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<TypeCutiResponse?> typeCuti({int page: 1, int limit: 10}) async {
    try {
      final res = await apiProvider
          .getTypeCuti('/api/v1/cuti/type')
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return TypeCutiResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<ShowCutiResponse?> showCuti(String id) async {
    print(id);
    try {
      final res = await apiProvider
          .getShowCuti('/api/v1/cuti/' + id)
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return ShowCutiResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<ShowCutiResponse?> submitCuti(SubmitCutiRequest data) async {
    try {
      final res = await apiProvider
          .submitCuti('/api/v1/cuti', data)
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return ShowCutiResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<ErrorResponse?> updateApprovalCuti(
      String id, UpdateApprovalCutiRequest data) async {
    try {
      final res = await apiProvider
          .updateApprovalCuti('/api/v1/cuti/update-status/' + id, data)
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
  }

  Future<ShowCutiResponse?> updateCuti(
      String id, SubmitCutiRequest data) async {
    print(data);
    try {
      final res = await apiProvider
          .updateCuti('/api/v1/cuti/' + id, data)
          .timeout(Duration(seconds: timeout));
      print(res);
      if (res.statusCode == 200 || res.statusCode == 401) {
        return ShowCutiResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }
  //END CUTI

  //START IZIN
  Future<IzinResponse?> listIzin({int page: 1, int limit: 10}) async {
    try {
      final res = await apiProvider
          .getIzin('/api/v1/izin?page=' +
              page.toString() +
              '&limit=' +
              limit.toString())
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return IzinResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<TypeIzinResponse?> typeIzin() async {
    try {
      final res = await apiProvider
          .getTypeIzin('/api/v1/izin/type')
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return TypeIzinResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<ShowIzinResponse?> showIzin(String id) async {
    try {
      final res = await apiProvider
          .getShowIzin('/api/v1/izin/' + id)
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return ShowIzinResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<ErrorResponse?> submitIzin(SubmitIzinRequest data) async {
    try {
      print(data);
      final res = await apiProvider
          .submitIzin('/api/v1/izin', data)
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
  }

  Future<ErrorResponse?> updateApprovalIzin(
      String id, UpdateApprovalIzinRequest data) async {
    try {
      final res = await apiProvider
          .updateApprovalIzin('/api/v1/izin/update-status/' + id, data)
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
  }

  Future<ErrorResponse?> updateIzin(String id, SubmitIzinRequest data) async {
    print(data);
    try {
      final res = await apiProvider
          .updateIzin('/api/v1/izin/set-done/' + id, data)
          .timeout(Duration(seconds: timeout));
      print(res);
      if (res.statusCode == 200 || res.statusCode == 401) {
        return ErrorResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  //RELIVER
  Future<ListReliverResponse?> listReliver({int page: 1, int limit: 10}) async {
    try {
      final res = await apiProvider
          .getReliver('/api/v1/reliver?page=' +
              page.toString() +
              '&limit=' +
              limit.toString())
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return ListReliverResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<ShowReliverResponse?> showReliver(String id) async {
    try {
      final res = await apiProvider
          .getShowReliver('/api/v1/reliver/' + id)
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
  }

  Future<ErrorResponse?> submitReliver(CreateReliverRequest data) async {
    try {
      print(data);
      final res = await apiProvider
          .submitReliver('/api/v1/reliver', data)
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
  }

  Future<ErrorResponse?> updateApprovalReliver(
      String id, ApproveReliverRequest data) async {
    try {
      final res = await apiProvider
          .updateApprovalReliver('/api/v1/reliver/approve/' + id, data)
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
  }
  //END RELIVER

  //TASK LIST
  Future<TaskListResponse?> taskList({int page: 1, int limit: 10}) async {
    try {
      final res = await apiProvider
          .getTaskList('/api/v1/task?page=' +
              page.toString() +
              '&limit=' +
              limit.toString())
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return TaskListResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<TaskListTadResponse?> taskListTad({int page: 1, int limit: 10}) async {
    try {
      // final res = await apiProvider.getTaskList('/api/v1/task/tad/?page=' +
      //     page.toString() +
      //     '&limit=' +
      //     limit.toString());
      final res = await apiProvider
          .getTaskList('/api/v1/task/tad?page=' +
              page.toString() +
              '&limit=' +
              limit.toString())
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return TaskListTadResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<ListTaskListTadKorlapResponse?> listTaskListTadKorlap(
      {int page: 1, int limit: 10}) async {
    try {
      final res = await apiProvider
          .listTaskListTadKorlap('/api/v1/task/tad-users')
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return ListTaskListTadKorlapResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<ShowTaskListTadKorlapResponse?> showTaskListTadKorlap(
      String id) async {
    try {
      final res = await apiProvider
          .showTaskListTadKorlap('/api/v1/task/tad-users/' + id)
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200 || res.statusCode == 401) {
        return ShowTaskListTadKorlapResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<ShowTaskListResponse?> showTaskList(
      String idTask, String idType) async {
    try {
      final res = await apiProvider
          .getShowTaskList('/api/v1/task/' + idTask + '/' + idType)
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200) {
        return ShowTaskListResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<ShowTaskListKhususResponse?> showTaskListKhusus(
      String idTask, String idType) async {
    try {
      final res = await apiProvider
          .getShowTaskList('/api/v1/task/' + idTask + '/' + idType)
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200) {
        return ShowTaskListKhususResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<ShowTaskListTadResponse?> showTaskListTad(
      String idTask, String idType) async {
    try {
      final res = await apiProvider
          .getShowTaskList('/api/v1/task/' + idTask + '/' + idType + '/tad')
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200) {
        return ShowTaskListTadResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<ErrorResponse?> updateTaskListAfterTad(
      String idTask, String idType, UpdateTaskListTadRequest data) async {
    try {
      final res = await apiProvider
          .updateTaskList(
              '/api/v1/task/' + idTask + '/' + idType + '/tad', data)
          .timeout(Duration(seconds: timeout));
      print(res);
      if (res.statusCode == 200) {
        return ErrorResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<ErrorResponse?> updateTaskListBeforeTad(
      String idTask, String idType, UpdateTaskListTadBeforeRequest data) async {
    try {
      final res = await apiProvider
          .updateTaskListBefore(
              '/api/v1/task/' + idTask + '/' + idType + '/tad', data)
          .timeout(Duration(seconds: timeout));
      print(res);
      if (res.statusCode == 200) {
        return ErrorResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<ErrorResponse?> deleteTaskList(String idTask, String idType) async {
    try {
      final res = await apiProvider
          .deleteTaskList('/api/v1/task/' + idTask + '/' + idType)
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
  }

  Future<TypeTaskListResponse?> typeTaskList() async {
    try {
      final res = await apiProvider
          .getType('/api/v1/task/type')
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200) {
        return TypeTaskListResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<NameTaskListResponse?> nameTaskList(
      {String typeId: '1', int limit: 100}) async {
    try {
      final res = await apiProvider
          .getTaskName(
              '/api/v1/task/task-name/' + typeId + '?limit=' + limit.toString())
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200) {
        return NameTaskListResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<BranchListResponse?> branchList({int page: 1, int limit: 100}) async {
    try {
      final res = await apiProvider
          .getBranchList('/api/v1/branch?limit=' + limit.toString())
          .timeout(Duration(seconds: timeout));
      if (res.statusCode == 200) {
        return BranchListResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<NameTadListResponse?> branchNameTad({branchId = 0}) async {
    print(branchId);
    try {
      final res = await apiProvider
          .getBranchList(
              '/api/v1/branch/tad-users?branch_id=' + branchId.toString())
          .timeout(Duration(seconds: timeout));
      print(res);
      if (res.statusCode == 200) {
        return NameTadListResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<ErrorResponse?> submitTaskListGeneral(
      CreateTaskListGeneralRequest data) async {
    try {
      final res = await apiProvider
          .submitTaskListGeneral('/api/v1/task', data)
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
  }

  Future<ErrorResponse?> submitTaskListKhusus(
      CreateTaskListKhususRequest data) async {
    try {
      final res = await apiProvider
          .submitTaskListKhusus('/api/v1/task', data)
          .timeout(Duration(seconds: timeout));
      print(res);
      if (res.statusCode == 200 || res.statusCode == 401) {
        return ErrorResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<ErrorResponse?> editTaskListGeneral(
      CreateTaskListGeneralRequest data, String idTask, String idType) async {
    try {
      final res = await apiProvider
          .editTaskListGeneral('/api/v1/task/' + idTask + '/' + idType, data)
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
  }

  Future<ErrorResponse?> editTaskListKhusus(
      CreateTaskListKhususRequest data, String idTask, String idType) async {
    try {
      final res = await apiProvider
          .editTaskListKhusus('/api/v1/task/' + idTask + '/' + idType, data)
          .timeout(Duration(seconds: timeout));
      print(res);
      if (res.statusCode == 200 || res.statusCode == 401) {
        return ErrorResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<ErrorResponse?> updateFcmProfile(UpdateFcmProfileRequest data) async {
    try {
      final res = await apiProvider
          .updateFcmProfile('/api/v1/auth/update', data)
          .timeout(Duration(seconds: timeout));
      print(res);
      if (res.statusCode == 200 || res.statusCode == 401) {
        return ErrorResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<UpdateProfileResponse?> updatePhotoProfile(
      UpdatePhotoProfileRequest data) async {
    try {
      final res = await apiProvider
          .updatePhotoProfile('/api/v1/auth/update', data)
          .timeout(Duration(seconds: timeout));
      print(res);
      if (res.statusCode == 200 || res.statusCode == 401) {
        return UpdateProfileResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<ShowReviewRateResponse?> getRate() async {
    try {
      final res = await apiProvider
          .getRate('/api/v1/rate')
          .timeout(Duration(seconds: timeout));
      print(res);
      if (res.statusCode == 200) {
        return ShowReviewRateResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }

  Future<ShowReviewRateResponse?> submitRate(SubmitRate data) async {
    try {
      final res = await apiProvider
          .submitRate('/api/v1/rate', data)
          .timeout(Duration(seconds: timeout));
      print(res);
      if (res.statusCode == 200) {
        return ShowReviewRateResponse.fromJson(res.body);
      }
    } on TimeoutException catch (_) {
      EasyLoading.showError('Connection Timeout. Please try again later');
      EasyLoading.dismiss();
    } catch (exception) {
      print(exception);
    }
  }
}
