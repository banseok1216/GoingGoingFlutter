
import 'package:goinggoing_flutterapp/DataSource/RemoteDataSource.dart';

import 'Schedule.dart';

class ScheduleRepository {
  final RemoteDataSource _remoteDataSource = RemoteDataSource();
  Future<List<ScheduleData>?> getScheduleList(String? token) {
    return _remoteDataSource.getScheduleList(token);
  }
  Future<Schedule?> postSchedule(String? token, Schedule schedule){
    return _remoteDataSource.postNewSchedule(token!, schedule);
  }
  Future<ScheduleRoutineData?> getRoutineScheduleList(String? token, int id) {
    return _remoteDataSource.getScheduleRoutineList(token,id);
  }
  Future<bool?> updateSchedule(String? token, Schedule schedule){
    return _remoteDataSource.updateSchedule(token!, schedule);
  }
  Future<bool?> updateDurationAndDone(String? token, PersonalSchedule personalSchedule){
    return _remoteDataSource.updateDurationAndDone(token!, personalSchedule);
  }

}

