import 'package:flutter/material.dart';
import 'package:goinggoing_flutterapp/Auth/AuthRepository.dart';
import 'package:intl/intl.dart';

import 'Schedule.dart';
import 'ScheduleRepository.dart';

class ScheduleViewModel with ChangeNotifier {
  late final ScheduleRepository _scheduleRepository;
  late final AuthRepository _authRepository;
  List<ScheduleData> _scheduleList = List.empty(growable: true);
  List<ScheduleData> _dayScheduleList = List.empty(growable: true);

  List<ScheduleData> get scheduleList => _scheduleList;

  List<ScheduleData> get dayScheduleList => _dayScheduleList;
  late Schedule _schedule =
      Schedule(id: null, title: null, date: null, location: null);
  late PersonalSchedule _personalSchedule = PersonalSchedule(
    id: null,
    duration: 0,
    scheduleDone: false,
    scheduleStart: false,
    scheduleStartTime: DateTime.now(),
    scheduleDoneTime: DateTime.now(),
  );
  bool _isPutRunning = false;
  bool _isAlreay = false;

  bool get isAlready => _isAlreay;

  Schedule? get schedule => _schedule;

  bool get isPutRunning => _isPutRunning;

  String? _key;

  String? get key => _key;

  PersonalSchedule get personalSchedule => _personalSchedule;

  ScheduleViewModel() {
    _scheduleRepository = ScheduleRepository();
    _authRepository = AuthRepository();
  }

  Future<void> getScheduleList() async {
    final token = await _authRepository.loadToken();
    List<ScheduleData>? scheduleList =
        await _scheduleRepository.getScheduleList(token);
    if (scheduleList == null) {
      final token = await _authRepository.requestRefreshToken();
      scheduleList = await _scheduleRepository.getScheduleList(token);
    }
    _scheduleList = scheduleList!;
    notifyListeners();
  }

  Future<void> updateSchedule() async {
    final token = await _authRepository.loadToken();
    bool? success = await _scheduleRepository.updateSchedule(token, _schedule);
    if (success == null) {
      final token = await _authRepository.requestRefreshToken();
      success = await _scheduleRepository.updateSchedule(token, _schedule);
    }
    await updateDurationAndDone();
    await getScheduleList();
    notifyListeners();
  }

  Future<void> updateDurationAndDone() async {
    final token = await _authRepository.loadToken();
    bool? success = await _scheduleRepository.updateDurationAndDone(
        token, _personalSchedule);
    if (success == null) {
      final token = await _authRepository.requestRefreshToken();
      success = await _scheduleRepository.updateDurationAndDone(
          token, _personalSchedule);
    }
    notifyListeners();
  }

  Future<void> getScheduleDuration(Schedule schedule) async {
    final token = await _authRepository.loadToken();
    ScheduleRoutineData? scheduleRoutineData =
        await _scheduleRepository.getRoutineScheduleList(token, schedule.id!);
    if (scheduleRoutineData == null) {
      final token = await _authRepository.requestRefreshToken();
      scheduleRoutineData =
          await _scheduleRepository.getRoutineScheduleList(token, schedule.id!);
    }
    _personalSchedule = scheduleRoutineData!.personalSchedule;
    notifyListeners();
  }

  void getMemberScheduleDuration(
      ScheduleRoutineData scheduleRoutineData) async {
    _personalSchedule = scheduleRoutineData.personalSchedule;
    notifyListeners();
  }

  int getScheduleForDate(DateTime date) {
    int count = 0;
    for (ScheduleData schedule in _scheduleList) {
      if (schedule.schedule.date?.year == date.year &&
          schedule.schedule.date?.month == date.month &&
          schedule.schedule.date?.day == date.day) {
        count++;
      }
    }
    return count;
  }

  void getSelectScheduleList(DateTime date) {
    List<ScheduleData> templist = List.empty(growable: true);
    for (ScheduleData schedule in _scheduleList) {
      if (schedule.schedule.date?.year == date.year &&
          schedule.schedule.date?.month == date.month &&
          schedule.schedule.date?.day == date.day) {
        templist.add(schedule);
      }
    }
    templist.sort((a, b) => (a.schedule.date ?? DateTime(0))
        .compareTo(b.schedule.date ?? DateTime(0)));
    _dayScheduleList = templist;
    notifyListeners();
  }

  void getSelectSchedule(Schedule schedule) {
    _schedule = schedule;
    getScheduleDuration(schedule);
    notifyListeners();
  }

  void statePutRunning() {
    _isPutRunning = !_isPutRunning;
    notifyListeners();
  }

  void makePutFalse() {
    _isPutRunning = false;
    notifyListeners();
  }

  void isAlreaySchedule(bool value) {
    _isAlreay = value;
    notifyListeners();
  }

  void updateScheduleTitle(String title) {
    if (_schedule != null) {
      _schedule = Schedule(
        id: _schedule!.id,
        title: title,
        date: _schedule!.date,
        location: _schedule!.location,
      );
      notifyListeners();
    }
  }

  void updateScheduleDate(String date) {
    if (_schedule != null) {
      final koreanDateFormatter = DateFormat('yyyy년 M월 d일 E', 'ko_KR');
      var datetime = koreanDateFormatter.parse(date);
      datetime = DateTime(
        datetime.year,
        datetime.month,
        datetime.day,
        _schedule!.date!.hour,
        _schedule!.date!.minute,
      );
      _schedule = Schedule(
        id: _schedule!.id,
        title: _schedule!.title,
        date: datetime,
        location: _schedule!.location,
      );
      notifyListeners();
      print(_schedule!.date);
    }
  }

  void updateScheduleTime(String time) {
    if (_schedule != null) {
      final koreanTimeFormatter = DateFormat('a h시 mm분', 'ko_KR');
      var datetime = koreanTimeFormatter.parse(time);
      datetime = DateTime(
        _schedule!.date!.year,
        _schedule!.date!.month,
        _schedule!.date!.day,
        datetime.hour,
        datetime.minute,
      );
      _schedule = Schedule(
        id: _schedule!.id,
        title: _schedule!.title,
        date: datetime,
        location: _schedule!.location,
      );
      notifyListeners();
      print(_schedule!.date);
    }
  }

  void updateScheduleDuration(String duration2) {
    if (_schedule != null) {
      RegExp regExp = RegExp(r'(\d+) 시간 (\d+)분 이동');
      RegExpMatch? match = regExp.firstMatch(duration2);
      if (match != null) {
        int hours = int.parse(match.group(1)!);
        int minutes = int.parse(match.group(2)!);
        Duration duration1 = Duration(hours: hours, minutes: minutes);
        _personalSchedule = PersonalSchedule(
            id: _personalSchedule.id,
            duration: duration1.inMinutes,
            scheduleDone: _personalSchedule.scheduleDone,
            scheduleStart: _personalSchedule.scheduleStart,
            scheduleStartTime: _personalSchedule.scheduleStartTime,
            scheduleDoneTime: _personalSchedule.scheduleDoneTime);
        notifyListeners();
        print(_schedule!.date);
      }
    }
  }

  void updateScheduleLocation(String location) {
    if (_schedule != null) {
      _schedule = Schedule(
        id: _schedule!.id,
        title: _schedule!.title,
        date: _schedule!.date,
        location: location,
      );
      notifyListeners();
    }
  }

  Future<void> updatePersonalSchedule(Duration duration, int routineTime) async{
    DateTime tempScheduleStartTime = _schedule.date!.subtract(duration).subtract(Duration(seconds: routineTime));
    DateTime tempScheduleDoneTime = _schedule.date!.subtract(duration);
      if (DateTime.now().isAfter(tempScheduleStartTime)) {
        if(DateTime.now().isAfter(tempScheduleDoneTime)) {
          _personalSchedule = PersonalSchedule(
          id: _personalSchedule.id,
          duration: duration.inMinutes,
          scheduleDone: true, scheduleStart: true, scheduleStartTime: tempScheduleStartTime, scheduleDoneTime: tempScheduleDoneTime);
        }
        else{
          _personalSchedule = PersonalSchedule(
              id: _personalSchedule.id,
              duration: duration.inMinutes,
              scheduleDone: false, scheduleStart: true, scheduleStartTime: tempScheduleStartTime, scheduleDoneTime: tempScheduleDoneTime);
        }
      await updateDurationAndDone();
    } else {
      _personalSchedule = PersonalSchedule(
          id: _personalSchedule.id,
          duration: duration.inMinutes,
          scheduleDone: false, scheduleStart: false, scheduleStartTime: tempScheduleStartTime, scheduleDoneTime: tempScheduleDoneTime);
      await updateDurationAndDone();
    }
  }
}
