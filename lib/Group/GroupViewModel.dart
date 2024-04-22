import 'package:flutter/material.dart';

import '../Auth/AuthRepository.dart';
import '../Schedule/Schedule.dart';
import 'Group.dart';
import 'GroupRepository.dart';

class GroupViewModel with ChangeNotifier {
  late final GroupRepository _groupRepository;
  late final AuthRepository _authRepository;
  List<Group> _scheduleGroupList = List.empty(growable: true);
  List<Group> _timerGroupList = List.empty(growable: true);
  late  int _selectedMember;
  int get selectedMember => _selectedMember;
  List<Group> get timerGroupList => _timerGroupList;
  List<Group> get scheduleGroupList => _scheduleGroupList;
  bool _showAddButton = false;

  bool get showAddButton => _showAddButton;

  GroupViewModel() {
    _groupRepository = GroupRepository();
    _authRepository = AuthRepository();
  }

  Future<void> getScheduleGroupList(int scheduleId, int userId) async {
    final token = await _authRepository.loadToken();
    List<Group>? tempGroupList = await _groupRepository.getGroupList(token,scheduleId);
    if(tempGroupList == null){
      final token = await _authRepository.requestRefreshToken();
      tempGroupList = await _groupRepository.getGroupList(token,scheduleId);
    }
    _scheduleGroupList = tempGroupList!;
    _selectedMember = userId;
    notifyListeners();
  }
  Future<void> getTimerGroupList(int scheduleId, int userId) async {
    final token = await _authRepository.loadToken();
    List<Group>? tempGroupList = await _groupRepository.getGroupList(token,scheduleId);
    if(tempGroupList == null){
      final token = await _authRepository.requestRefreshToken();
      tempGroupList = await _groupRepository.getGroupList(token,scheduleId);
    }
    _timerGroupList = tempGroupList!;
    _selectedMember = userId;
    notifyListeners();
  }

  void updateShowAddButton(bool value) {
    print(_showAddButton);
    _showAddButton = value;
    notifyListeners();
  }

  Future<ScheduleRoutineData> getMemberScheduleRoutineList(int scheduleId, int userId) async {
    final token = await _authRepository.loadToken();
    ScheduleRoutineData? scheduleRoutineData =await _groupRepository.getMemberScheduleRoutineList(token,scheduleId,userId);
    if(scheduleRoutineData == null){
      final token = await _authRepository.requestRefreshToken();
      scheduleRoutineData = await _groupRepository.getMemberScheduleRoutineList(token,scheduleId,userId);
    }
    _selectedMember = userId;
    return scheduleRoutineData!;
  }
}
