
import 'package:goinggoing_flutterapp/DataSource/RemoteDataSource.dart';
import 'package:goinggoing_flutterapp/Routine/Routine.dart';

import '../Schedule/Schedule.dart';


class RoutineRepository {
  final RemoteDataSource _remoteDataSource = RemoteDataSource();
  Future<ScheduleRoutineData?> getRoutineScheduleList(String? token, int id) {
    return _remoteDataSource.getScheduleRoutineList(token,id);
  }
  Future<List<Routine>?> getRoutineList(String? token) {
    return _remoteDataSource.getRoutineList(token!);
  }
  Future<ScheduleRoutine?> addScheduleRoutine(String? token, ScheduleRoutine scheduleRoutine,int personalScheduleId){
    return _remoteDataSource.addScheduleRoutine(token,scheduleRoutine,personalScheduleId);
  }
  Future<bool?> removeScheduleRoutine(String? token, int scheduleRoutineId){
    return _remoteDataSource.removeScheduleRoutine(token,scheduleRoutineId);
  }
  Future<bool?> removeUserRoutine(String? token, int userRoutineId){
    return _remoteDataSource.removeUserRoutine(token,userRoutineId);
  }
  Future<bool?> updateScheduleRoutine(String? token, List<ScheduleRoutine> scheduleRoutineList,int personalScheduleId ){
    return _remoteDataSource.updateScheduleRoutine(token!,scheduleRoutineList,personalScheduleId);
  }
  Future<bool?> updateRoutineDone(String? token,ScheduleRoutine scheduleRoutine ){
    return _remoteDataSource.updateRoutineDone(token!,scheduleRoutine);
  }
  Future<bool?> addRoutineDetailToRoutine(String? token, Routine routine){
    return _remoteDataSource.addRoutineDetailToRoutine(token!,routine);
  }
}
