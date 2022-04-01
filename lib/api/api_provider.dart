import 'package:cleaner/api/base_provider.dart';
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
import 'package:get/get.dart';

class ApiProvider extends BaseProvider {
  Future<Response> login(String path, LoginRequest data) {
    return post(path, data.toJson());
  }

  Future<Response> logout(String path, LogoutRequest data) {
    return post(path, data.toJson());
  }

  Future<Response> register(String path, RegisterRequest data) {
    return post(path, data.toJson());
  }

  Future<Response> getUsers(String path) {
    return get(path);
  }

  Future<Response> getUserSchedule(String path) {
    return get(path);
  }

  Future<Response> getRecapHistory(String path) {
    return get(path);
  }

  Future<Response> submitAttendance(String path, AttendanceSubmitRequest data) {
    return post(path, data.toJson());
  }

  Future<Response> validateAttendance(String path) {
    return get(path);
  }

  //START CNC
  Future<Response> getCnCItem(String path) {
    return get(path);
  }

  Future<Response> getCnCCategory(String path) {
    return get(path);
  }

  Future<Response> getCnC(String path) {
    return get(path);
  }

  Future<Response> getShowCnC(String path) {
    return get(path);
  }

  Future<Response> submitCnC(String path, SubmitCnCRequest data) {
    print(data.toJson());
    return post(path, data.toJson());
  }

  Future<Response> updateApprovalCnC(String path, ApprovalCnCRequest data) {
    print(data.toJson());
    return patch(path, data.toJson());
  }
  //END CNC

  //START OVERTIME
  Future<Response> getOvertime(String path) {
    return get(path);
  }

  Future<Response> getShowOvertime(String path) {
    return get(path);
  }

  Future<Response> submitOvertime(String path, SubmitOvertimeRequest data) {
    return post(path, data.toJson());
  }

  Future<Response> setDoneOvertime(String path, SetDoneOvertimeRequest data) {
    return patch(path, data.toJson());
  }

  Future<Response> updateApprovalOvertime(
      String path, UpdateApprovalOvertimeRequest data) {
    return patch(path, data.toJson());
  }
  //END OVERTIME

  //START CUTI
  Future<Response> getCuti(String path) {
    return get(path);
  }

  Future<Response> getTypeCuti(String path) {
    return get(path);
  }

  Future<Response> getShowCuti(String path) {
    print(path);
    return get(path);
  }

  Future<Response> submitCuti(String path, SubmitCutiRequest data) {
    return post(path, data.toJson());
  }

  Future<Response> updateCuti(String path, SubmitCutiRequest data) {
    return patch(path, data.toJson());
  }

  Future<Response> updateApprovalCuti(
      String path, UpdateApprovalCutiRequest data) {
    return patch(path, data.toJson());
  }
  //END CUTI

  //START IZIN
  Future<Response> getIzin(String path) {
    return get(path);
  }

  Future<Response> getTypeIzin(String path) {
    return get(path);
  }

  Future<Response> getShowIzin(String path) {
    return get(path);
  }

  Future<Response> submitIzin(String path, SubmitIzinRequest data) {
    return post(path, data.toJson());
  }

  Future<Response> updateIzin(String path, SubmitIzinRequest data) {
    return patch(path, data.toJson());
  }

  Future<Response> updateApprovalIzin(
      String path, UpdateApprovalIzinRequest data) {
    return patch(path, data.toJson());
  }
  //ENDIZIN

  //START IZIN
  Future<Response> getReliver(String path) {
    return get(path);
  }

  Future<Response> getShowReliver(String path) {
    return get(path);
  }

  Future<Response> submitReliver(String path, CreateReliverRequest data) {
    return post(path, data.toJson());
  }

  Future<Response> updateApprovalReliver(
      String path, ApproveReliverRequest data) {
    return patch(path, data.toJson());
  }
  //ENDIZIN

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

  Future<Response> updateTaskList(String path, UpdateTaskListTadRequest data) {
    print(data.toJson());
    return patch(path, data.toJson());
  }

  Future<Response> updateTaskListBefore(
      String path, UpdateTaskListTadBeforeRequest data) {
    print(data.toJson());
    return patch(path, data.toJson());
  }

  Future<Response> submitTaskListKhusus(
      String path, CreateTaskListKhususRequest data) {
    return post(path, data.toJson());
  }

  Future<Response> submitTaskListGeneral(
      String path, CreateTaskListGeneralRequest data) {
    return post(path, data.toJson());
  }

  Future<Response> editTaskListKhusus(
      String path, CreateTaskListKhususRequest data) {
    return patch(path, data.toJson());
  }

  Future<Response> editTaskListGeneral(
      String path, CreateTaskListGeneralRequest data) {
    return patch(path, data.toJson());
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

  Future<Response> updateFcmProfile(String path, UpdateFcmProfileRequest data) {
    print(data.toJson());
    return patch(path, data.toJson());
  }

  Future<Response> updatePhotoProfile(
      String path, UpdatePhotoProfileRequest data) {
    print(data.toJson());
    return patch(path, data.toJson());
  }

  Future<Response> getRate(String path) {
    return get(path);
  }

  Future<Response> submitRate(String path, SubmitRate data) {
    print(data.toJson());
    return patch(path, data.toJson());
  }
}
