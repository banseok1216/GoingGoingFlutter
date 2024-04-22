import 'package:goinggoing_flutterapp/DataSource/RemoteDataSource.dart';
import 'package:goinggoing_flutterapp/Group/Group.dart';
import 'package:goinggoing_flutterapp/JwtToken.dart';

import '../Schedule/Schedule.dart';
import 'GroupDataSource.dart';

class GroupRepository {
  final RemoteDataSource _dataSource = RemoteDataSource();

  Future<List<Group>?> getGroupList(String? token,int scheduleId)  {
    return _dataSource.getGroupList(token!, scheduleId);
  }
  Future<ScheduleRoutineData?> getMemberScheduleRoutineList(String? token, int scheduleId,int userId) {
    return _dataSource.getMemberScheduleRoutineList(token,scheduleId,userId);
  }
}
