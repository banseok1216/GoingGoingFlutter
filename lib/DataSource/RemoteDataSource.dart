import 'dart:convert';

import 'package:goinggoing_flutterapp/Routine/Routine.dart';
import 'package:http/http.dart' as http;

import '../Group/Group.dart';
import '../JwtToken.dart';
import '../Schedule/Schedule.dart';
import '../User/User.dart';
import 'LocalDataSource.dart';

class RemoteDataSource {

  Future<Schedule?> postNewSchedule(String token, Schedule schedule) async {
    String serverUrl = 'http://127.0.0.1:8080/api/schedule';
    var uri = Uri.parse(serverUrl);
    String jsonData = jsonEncode(schedule.toJson());
    final http.Response response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json', // JSON 데이터를 전송할 것임을 서버에 알립니다.
        'access_token': token, // 토큰을 헤더에 추가
      },
      body: jsonData, // 업데이트할 데이터를 body에 전송합니다.
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      int newScheduleId = responseData['scheduleId'];
      Schedule newSchedule = Schedule(id: newScheduleId, title: schedule.title, date: schedule.date, location: schedule.location);
      return newSchedule;
    }
    else if(response.statusCode == 401){
      return null;
    }
    else{
      throw Exception('Failed to post new schedule: ${response.statusCode}');
    }
  }
  Future<JwtToken?> postKakaoToken(User user,String deviceToken)async{
    String serverUrl = 'http://127.0.0.1:8080/api/auth/kakao';
    var uri = Uri.parse(serverUrl);
    String jsonData = jsonEncode(user.toJson());
    final http.Response response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json', // JSON 데이터를 전송할 것임을 서버에 알립니다.
        'device_token' : deviceToken
      },
      body: jsonData,
    );
    if (response.statusCode == 200) {
      String? accessToken = response.headers['access_token'];
      String? refreshToken = response.headers['refresh_token'];
      print(accessToken);
      print(refreshToken);
      if (accessToken != null && refreshToken != null) {
        return JwtToken(access_token: accessToken, refresh_token: refreshToken);
      } else {
        return null;
      }
    }
    else {
      return null;
    }
  }
  Future<bool> addUser(User user) async{
    String serverUrl = 'http://127.0.0.1:8080/api/register';
    var uri = Uri.parse(serverUrl);
    String jsonData = jsonEncode(user.toJson());
    final http.Response response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json', // JSON 데이터를 전송할 것임을 서버에 알립니다.
      },
      body: jsonData,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }


  Future<List<Group>?> getGroupList(String token,int scheduleId) async {
    String serverUrl = 'http://127.0.0.1:8080/api/group';
    Map<String, String> params = {
      'scheduleId': '$scheduleId',
    };
    var uri = Uri.parse(serverUrl).replace(queryParameters: params);
    final http.Response response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json', // JSON 데이터를 전송할 것임을 서버에 알립니다.
        'access_token': token, // 토큰을 헤더에 추가
      },
    );
    if(response.statusCode == 200){
      List<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      List<Group> groupList = [];
      for (dynamic json in jsonData) {
        Group group = Group.fromJson(json);
        // Schedule과 PersonalSchedule를 하나의 ScheduleRoutineData로 묶어서 리스트에 추가
        groupList.add(group);
      }
      return groupList;
    }
    else if(response.statusCode == 401){
      return null;
    }
  }
  Future<bool?> updateSchedule(String token, Schedule schedule) async{
    String serverUrl = 'http://127.0.0.1:8080/api/schedule';
    String jsonData = json.encode(schedule.toJson());
    var uri = Uri.parse(serverUrl);
    final http.Response response = await http.put(
        uri,
        headers: <String, String>{
        'Content-Type': 'application/json', // JSON 데이터를 전송할 것임을 서버에 알립니다.
        'access_token': token, // 토큰을 헤더에 추가
        },
        body: jsonData,
    );
    if (response.statusCode != 200) {
      return false;
    }
    else if(response.statusCode == 401){
      return null;
    }
    else{
      return true;
    }
  }
  Future<bool?> updateDurationAndDone(String token, PersonalSchedule personalSchedule) async{
    String serverUrl = 'http://127.0.0.1:8080/api/personalSchedule';
    String jsonData = json.encode(personalSchedule.toJson());
    var uri = Uri.parse(serverUrl);
    final http.Response response = await http.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json', // JSON 데이터를 전송할 것임을 서버에 알립니다.
        'access_token': token, // 토큰을 헤더에 추가
      },
      body: jsonData,
    );

    if (response.statusCode == 200) {
      return true;
    }
    else if(response.statusCode == 401){
      return null;
    }
    else{
      return true;
    }
  }
  Future<bool?> updateRoutineDone(String token, ScheduleRoutine scheduleRoutine) async{
    String serverUrl = 'http://127.0.0.1:8080/api/personalSchedule';
    String jsonData = json.encode(scheduleRoutine.toJson());
    var uri = Uri.parse(serverUrl);
    final http.Response response = await http.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json', // JSON 데이터를 전송할 것임을 서버에 알립니다.
        'access_token': token, // 토큰을 헤더에 추가
      },
      body: jsonData,
    );

    if (response.statusCode == 200) {
      return true;
    }
    else if(response.statusCode == 401){
      return null;
    }
    else{
      return true;
    }
  }

  Future<JwtToken?> requestJwtToken(User user,String deviceToken) async {
    // 서버의 엔드포인트 설정
    String serverUrl = 'http://127.0.0.1:8080/api/login';

    // 사용자 정보를 JSON 형태로 변환
    String userJson = json.encode(user);

    // HTTP POST 요청 보내기
    final http.Response response = await http.post(
      Uri.parse(serverUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'device_token' : deviceToken
      },
      body: userJson,
    );
    if (response.statusCode == 200) {
      String? accessToken = response.headers['access_token'];
      String? refreshToken = response.headers['refresh_token'];
      print(accessToken);
      print(refreshToken);
      if (accessToken != null && refreshToken != null) {
        return JwtToken(access_token: accessToken, refresh_token: refreshToken);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
  Future<bool?> addRoutineDetailToRoutine(String token, Routine routine)async{
    String serverUrl = 'http://127.0.0.1:8080/api/userRoutine';
    var uri = Uri.parse(serverUrl);
    String jsonData = jsonEncode(routine.toJson());
    final http.Response response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json', // JSON 데이터를 전송할 것임을 서버에 알립니다.
        'access_token': token, // 토큰을 헤더에 추가
      },
      body: jsonData, // 업데이트할 데이터를 body에 전송합니다.
    );
    if (response.statusCode != 200) {
      return true;
    }
    else if(response.statusCode == 401){
      return null;
    }
    return false;
  }
  Future<bool?> updateScheduleRoutine(String token, List<ScheduleRoutine> scheduleRoutineList, int personalScheduleId) async {
    String serverUrl = 'http://127.0.0.1:8080/api/routineSchedule';
    bool success = true; // 모든 요청이 성공했는지 여부를 추적하기 위한 변수

    for (var scheduleRoutine in scheduleRoutineList) {
      var uri = Uri.parse(serverUrl);

      // 업데이트할 데이터를 JSON 형식으로 인코딩합니다.
      String jsonData = jsonEncode(scheduleRoutine.toJson());

      final http.Response response = await http.put(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json', // JSON 데이터를 전송할 것임을 서버에 알립니다.
          'access_token': token, // 토큰을 헤더에 추가
        },
        body: jsonData, // 업데이트할 데이터를 body에 전송합니다.
      );

      if (response.statusCode != 200) {
        // 요청이 실패한 경우
        success = false;
        // 여기서 바로 throw를 하지 않고 반복문을 계속 실행하여 모든 요청에 대한 상태를 확인할 수 있습니다.
        print('Failed to update schedule routine with ID: ${scheduleRoutine.scheduleId}');
      }
      else if(response.statusCode == 401){
        return null;
      }
    }

    // 모든 요청이 성공했는지 여부를 반환합니다.
    return success;
  }

  Future<User?> getUserProfile(String token) async {
    String serverUrl = 'http://127.0.0.1:8080/api/user';
    // HTTP GET 요청 보내기
    final http.Response response = await http.get(
      Uri.parse(serverUrl),
      headers: <String, String>{
        'access_token': '$token',
      },
    );
    if (response.statusCode == 200) {
      // 성공적으로 요청이 완료되었을 때 사용자 프로필을 반환하거나 다른 작업 수행
      return User.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    }
    else if(response.statusCode == 401){
      return null;
    }
    else {
      return null;
    }
  }
  Future<List<ScheduleData>?> getScheduleList(token) async {
    String serverUrl = 'http://127.0.0.1:8080/api/schedule';
    final http.Response response = await http.get(
      Uri.parse(serverUrl),
      headers: <String, String>{
        'access_token': '$token',
      },
    );

    List<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    List<ScheduleData> scheduleDataList = [];
    if (response.statusCode == 200) {
      for (dynamic json in jsonData) {
        Schedule schedule = Schedule.fromJson(json);
        PersonalSchedule personalSchedule = PersonalSchedule.fromJson(json);
        scheduleDataList.add(ScheduleData(schedule, personalSchedule));
      }
      return scheduleDataList;
    }
    else if(response.statusCode == 401){
    return null;
    }else {
    // 요청이 실패한 경우 에러 출력
    throw Exception('Failed');
    }
  }

  Future<ScheduleRoutineData?> getScheduleRoutineList(token, int id) async {
    String serverUrl = 'http://127.0.0.1:8080/api/personalSchedule';
    Map<String, String> params = {
      'scheduleId': '$id',
    };

    var uri = Uri.parse(serverUrl).replace(queryParameters: params);
    final http.Response response = await http.get(
      uri,
      headers: <String, String>{
        'access_token': '$token', // 토큰을 헤더에 추가
      },
    );
    Map<String, dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    List<dynamic> scheduleRoutineListJson = jsonData['scheduleRoutineDtoList'];
    if(response.statusCode == 200) {
      List<ScheduleRoutine> scheduleRoutineList = scheduleRoutineListJson.map((
          json) => ScheduleRoutine.fromJson(json)).toList();
      PersonalSchedule personalSchedule = PersonalSchedule.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
      return ScheduleRoutineData(personalSchedule, scheduleRoutineList);
    }
    else if(response.statusCode == 401){
    return null;
    }else {
    // 요청이 실패한 경우 에러 출력
    throw Exception('Failed');
    }
  }
  Future<ScheduleRoutineData?> getMemberScheduleRoutineList(token,scheduleId,userId) async {
    String serverUrl = 'http://127.0.0.1:8080/api/memberSchedule';
    Map<String, String> params = {
      'scheduleId': '$scheduleId',
      'memberId': '$userId',
    };

    var uri = Uri.parse(serverUrl).replace(queryParameters: params);
    final http.Response response = await http.get(
      uri,
      headers: <String, String>{
        'access_token': '$token', // 토큰을 헤더에 추가
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      List<dynamic> scheduleRoutineListJson = jsonData['scheduleRoutineDtoList'];
      List<ScheduleRoutine> scheduleRoutineList = scheduleRoutineListJson.map((json) => ScheduleRoutine.fromJson(json)).toList();
      PersonalSchedule personalSchedule = PersonalSchedule.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      return ScheduleRoutineData(personalSchedule, scheduleRoutineList);
    }     else if(response.statusCode == 401){
      return null;
    }else {
      // 요청이 실패한 경우 에러 출력
      throw Exception('Failed');
    }
  }

  Future<ScheduleRoutine?> addScheduleRoutine(String? token,ScheduleRoutine scheduleRoutine,int personalScheduleId)async{
    String serverUrl = 'http://127.0.0.1:8080/api/routineSchedule';
    Map<String, dynamic> jsonData = {
      'scheduleRoutineName': scheduleRoutine.content,
      'scheduleRoutineTime': scheduleRoutine.time,
      'scheduleRoutineIndex': scheduleRoutine.index,
      'personalScheduleId': personalScheduleId,
    };
    String requestBody = json.encode(jsonData);
    // HTTP POST 요청 보내기
    final http.Response response = await http.post(
      Uri.parse(serverUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'access_token': '$token',
      },
      body: requestBody,
    );
    if (response.statusCode == 200) {
      // 서버에서 응답으로 받은 id 추출
      Map<String, dynamic> responseData = json.decode(response.body);
      int newScheduleRoutineId = responseData['scheduleRoutineId'];

      // ScheduleRoutine 객체에 새로운 id 추가하여 반환
      return ScheduleRoutine(
        scheduleId: newScheduleRoutineId,
        content: scheduleRoutine.content,
        time: scheduleRoutine.time,
        index: scheduleRoutine.index,
      );
    }
    else if(response.statusCode == 401){
      return null;
    }else {
      // 요청이 실패한 경우 에러 출력
      throw Exception('Failed');
    }
  }
  Future<bool?> removeScheduleRoutine(String? token,int scheduleRoutineId)async{
    String serverUrl = 'http://127.0.0.1:8080/api/routineSchedule';
    Map<String, String> params = {
      'scheduleRoutineId': '$scheduleRoutineId',
    };

    var uri = Uri.parse(serverUrl).replace(queryParameters: params);
    final http.Response response = await http.delete(
      uri,
      headers: <String, String>{
        'access_token': '$token', // 토큰을 헤더에 추가
      },
    );
    if (response.statusCode == 200) {
      return true;
    }     else if(response.statusCode == 401){
      return null;
    }else {
      // 요청이 실패한 경우 에러 출력
      throw Exception('Failed');
    }
  }
  Future<bool?> removeUserRoutine(String? token,int userRoutineId)async{
    String serverUrl = 'http://127.0.0.1:8080/api/userRoutine';
    Map<String, String> params = {
      'userRoutineId': '$userRoutineId',
    };
    var uri = Uri.parse(serverUrl).replace(queryParameters: params);
    final http.Response response = await http.delete(
      uri,
      headers: <String, String>{
        'access_token': '$token', // 토큰을 헤더에 추가
      },
    );
    if (response.statusCode == 200) {
      return true;
    }     else if(response.statusCode == 401){
      return null;
    }else {
      // 요청이 실패한 경우 에러 출력
      throw Exception('Failed');
    }
  }

  Future<List<Routine>?> getRoutineList(String token) async {
    String serverUrl = 'http://127.0.0.1:8080/api/userRoutine';
    var uri = Uri.parse(serverUrl);
    final http.Response response = await http.get(
      uri,
      headers: <String, String>{
        'access_token': '$token', // 토큰을 헤더에 추가
      },
    );
    List<dynamic> jsonData =jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      List<Routine> routineList =
      jsonData.map((json) => Routine.fromJson(json)).toList();
      return routineList;
    }
    else if(response.statusCode == 401){
      return null;
    }else {
      // 요청이 실패한 경우 에러 출력
      throw Exception('Failed');
    }
  }
  Future<JwtToken?> refreshToken(String refreshToken) async {
    String serverUrl = 'http://127.0.0.1:8080/api/token/refresh';
    final http.Response response = await http.get(
      Uri.parse(serverUrl),
      headers: <String, String>{
        'Content-Type': 'application/json', // JSON 데이터를 전송할 것임을 서버에 알립니다.
        'refresh_token': refreshToken, // 토큰을 헤더에 추가
      },
    );
    if (response.statusCode == 200) {
      String? accessToken = response.headers['access_token'];
      String? refreshToken = response.headers['refresh_token'];
      return JwtToken(access_token: accessToken!, refresh_token: refreshToken!);
    } else {
      return null;
    }
  }

}
