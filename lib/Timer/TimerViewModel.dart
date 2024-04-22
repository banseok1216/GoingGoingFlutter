import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:goinggoing_flutterapp/Routine/RoutineViewModel.dart';
import 'package:intl/intl.dart';

import '../Auth/AuthRepository.dart';
import '../Routine/Routine.dart';
import '../Routine/RoutineRepository.dart';
import '../Schedule/Schedule.dart';
import 'dart:io';
import '../Schedule/ScheduleRepository.dart';
import '../Schedule/ScheduleViewModel.dart';
import 'Timer.dart';

class TimerViewModel extends ChangeNotifier {

  final  ScheduleViewModel _scheduleViewModel;
  late  AuthRepository _authRepository;
  late  RoutineRepository _routineRepository;
  late ScheduleRepository _scheduleRepository;
  List<ScheduleRoutine> _scheduleRoutineList = List.empty(growable: true);
  List<ScheduleRoutine> get scheduleRoutineList => _scheduleRoutineList;
  late PersonalSchedule _personalSchedule;
  Schedule _nearestSchedule = Schedule(id: null, title: '다가오는 일정이 없습니다', date: null, location: null);
  Schedule _schedule = Schedule(id: null, title: '다가오는 일정이 없습니다', date: null, location: null);
  Schedule get schedule => _schedule;
  Schedule get nearestSchedule => _nearestSchedule;
  late String _remainingTime = '';
  Duration _difference = Duration.zero;
  Duration _remainingRoutineTime = Duration.zero;
  Duration get remainingRoutineTime => _remainingRoutineTime;
  String get remainingTime => _remainingTime;

   bool _start = false;
  bool _done = false;
  bool _empty = false;
  late DateTime _currentRoutineTime;
  late double _percentage=0;
  double get percentage => _percentage;

  int _currentIndex =0;
  int get currentIndex => _currentIndex;
  Timer? _timer;
  Timer? _startedTimer;

  bool get start => _start;
  bool get empty => _empty;

  bool get done => _done;

  Duration get difference => _difference;


  TimerViewModel(this._scheduleViewModel)  {
    _routineRepository = RoutineRepository();
    _authRepository = AuthRepository();
    _scheduleRepository = ScheduleRepository();
    getNearScheduleList(_scheduleViewModel.scheduleList);
    }

    //타이머에 필요요 루틴 리스트 가져옴
  Future<void> getScheduleRoutineList() async {
    final token = await _authRepository.loadToken();
    ScheduleRoutineData? scheduleRoutineData = await _routineRepository.getRoutineScheduleList(token, _nearestSchedule!.id!);
    if(scheduleRoutineData == null){
      final token = await _authRepository.requestRefreshToken();
      scheduleRoutineData = await _routineRepository.getRoutineScheduleList(token, _nearestSchedule!.id!);
    }
    _personalSchedule = scheduleRoutineData!.personalSchedule;
    _scheduleRoutineList = scheduleRoutineData.scheduleRoutineList;
    notifyListeners();
  }

  Duration getTotalTime() {
    Duration totalDuration = Duration.zero;
    for (var detail in _scheduleRoutineList) {
      totalDuration += Duration(seconds: detail.time);
    }
    return totalDuration;
  }

  Future<void> startTimerRunning() async{
    _start = true;
    await updateStartPersonalSchedule();
    updateTimerScheduleToRoutineSchedule();
    runAlarmForRoutine(scheduleRoutineList);
    notifyListeners();
  }
  void onDoneButtonPressed() {
    _startNextRoutine(scheduleRoutineList);
    notifyListeners();
  }
  void updateTimerScheduleToRoutineSchedule(){
    _schedule = _nearestSchedule;
    notifyListeners();
  }
  void runAlarmForRoutine(List<ScheduleRoutine> details) {
    if ((details.isEmpty ||
        _personalSchedule.scheduleStartTime ==
            _personalSchedule.scheduleDoneTime) &&
        !_personalSchedule.scheduleDone) {
      updateDonePersonalSchedule();
      _remainingRoutineTime = Duration.zero;
      updateDoneBtn(true);
      _percentage = 1;
    } else {
      _currentIndex = findCurrentIndex(details); // 처음 루틴부터 시작
      _start = true; // 타이머 시작
      _currentRoutineTime = _personalSchedule.scheduleStartTime; // 시작 시간 설정
      const updateInterval = Duration(milliseconds: 100);
      _timer?.cancel(); // 기존의 타이머를 취소
      _timer = Timer.periodic(updateInterval, (timer) {
        Duration elapsedTime = DateTime.now().difference(_currentRoutineTime);
        Duration previousRoutinesTime = Duration.zero;
        for (int i = 0; i < _currentIndex; i++) {
          previousRoutinesTime += Duration(seconds: details[i].time);
        }
        Duration totalElapsedTime = previousRoutinesTime + elapsedTime;
        _remainingRoutineTime = getTotalTime() - totalElapsedTime;
        if (getTotalTime().inSeconds == 0) {
          _percentage = 1;
        }
        if (getTotalTime().inSeconds != 0) {
          _percentage = (totalElapsedTime.inSeconds / getTotalTime().inSeconds);
        }
        if (_currentIndex < details.length &&
            elapsedTime.inSeconds >= details[_currentIndex].time) {
          _startNextRoutine(details);
        }
        notifyListeners();
      });
    }
  }

  int findCurrentIndex(List<ScheduleRoutine> details){
    Duration differenceTime = DateTime.now().difference(_personalSchedule.scheduleStartTime);
    Duration RoutinesTime = Duration(seconds: details[0].time);
    int i=0;
    while(RoutinesTime.inSeconds < differenceTime.inSeconds){
      RoutinesTime += Duration(seconds: details[++i].time);
    }
    return i;
  }

  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    String formattedDuration = '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    return formattedDuration;
  }
  Future<void> _startNextRoutine(List<ScheduleRoutine> details) async {
    try {
      updateRoutineDone();
      if (_currentIndex < details.length - 1) {
        _currentIndex++;
        _currentRoutineTime = DateTime.now(); // 다음 루틴 시작 시간 설정
        notifyListeners();
      } else {
        _currentIndex =0;
        _timer?.cancel();
        updateDoneBtn(true);
        await updateDonePersonalSchedule();
        await getNearScheduleList(_scheduleViewModel.scheduleList);
        _percentage = 1;
        notifyListeners();
        return;
      }
    } catch (e) {
      // 에러 처리
      print('에러가 발생했습니다: $e');
      _exitApp(); // 앱 종료
    }
  }


  void updateDoneBtn(bool value){
    _done = value;
    notifyListeners();
  }
  void updateStartBtn(bool value){
    _start = value;
    notifyListeners();
  }
  String formatScheduleDate(DateTime scheduledDate) {
    final formatter = DateFormat('yyyy/M/d (E) a h시 mm분에', 'ko_KR');
    final formattedDate = formatter.format(scheduledDate); // Format the time
    return formattedDate;
  }
  String formatScheduleLocation(String scheduleLocation){
    scheduleLocation +='에서';
    return scheduleLocation;
  }
  void _updateRemainingTime() {
    if( _nearestSchedule.date != null){
      _empty = false;
      _difference = _personalSchedule.scheduleStartTime.difference(DateTime.now());
      int days = _difference.inDays;
      int hours = _difference.inHours%24;
      int minutes = (_difference.inMinutes % 60);
      int seconds = (_difference.inSeconds % 60);
      if(days ==0){
        if(hours==0){
          if(minutes==0){
            _remainingTime = '$seconds초';
          }
          else {
            _remainingTime = '$minutes분 $seconds초';
          }
        }
        else{
          _remainingTime = '$hours시간 $minutes분';
        }
      }
      else{
        _remainingTime = '$days일 $hours시간';
      }
    }
    else{
      _difference = Duration(seconds: 0);
      _empty = true;
    }
    notifyListeners();
  }
  void _startTimer() {
    _startedTimer?.cancel();
    _startedTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if ((_personalSchedule.scheduleStartTime.isAtSameMomentAs(DateTime.now()) || DateTime.now()
          .isAfter(_personalSchedule.scheduleStartTime)) && !_personalSchedule.scheduleDone) {
        _startedTimer?.cancel();
        startTimerRunning();
      } else {
        _updateRemainingTime(); // Timer를 중지할 때 이 메서드를 호출하지 않도록 수정
      }
    });
  }
  Future<void> getNearScheduleList(List<ScheduleData> scheduleList) async {
    bool success = false;
    DateTime now = DateTime.now();
    late PersonalSchedule tempPersonalSchedule;
    Schedule tempNearestSchedule = Schedule(id: null, title: '다가오는 일정이 없습니다', date: null, location: null);
    for (ScheduleData scheduleTime in scheduleList) {
      if(scheduleTime.personalSchedule.scheduleDoneTime.isAfter(DateTime.now())&&!scheduleTime.personalSchedule.scheduleDone && scheduleTime.personalSchedule.id != null){
        Duration difference = scheduleTime.schedule.date!.difference(now);
        if(tempNearestSchedule.id==null){
          tempPersonalSchedule = scheduleTime.personalSchedule;
          tempNearestSchedule = scheduleTime.schedule;
        }
        else {
          Duration nearestDifference = tempNearestSchedule.date!.difference(now);
          if (difference.inMilliseconds.abs() <
              nearestDifference.inMilliseconds.abs()) {
            tempPersonalSchedule = scheduleTime.personalSchedule;
            tempNearestSchedule =  scheduleTime.schedule;
          }
        }
        success = true;
      }
    }
    if(!success){
      _remainingRoutineTime = const Duration(seconds: 0);
      _nearestSchedule = Schedule(id: null, title: '다가오는 일정이 없습니다', date: null, location: null);
      _scheduleRoutineList = List.empty(growable: true);
    }
    else{
      _nearestSchedule =tempNearestSchedule;
      _personalSchedule = tempPersonalSchedule;
    }
    if (_nearestSchedule.id != null) {
      await getScheduleRoutineList(); // 비동기 호출로 수정
      _startTimer(); // 그대로 유지
    }
    notifyListeners();
  }
  Future<void> updateDonePersonalSchedule() async{
    final token = await _authRepository.loadToken();
    PersonalSchedule personalSchedule = PersonalSchedule(id: _personalSchedule.id, duration: _personalSchedule.duration,scheduleDone: true, scheduleStart: _personalSchedule.scheduleStart, scheduleStartTime: _personalSchedule.scheduleStartTime, scheduleDoneTime: DateTime.now());
    await _scheduleRepository.updateDurationAndDone(token,personalSchedule);
    notifyListeners();
  }
  Future<void> updateStartPersonalSchedule() async{
    final token = await _authRepository.loadToken();
    PersonalSchedule personalSchedule = PersonalSchedule(id: _personalSchedule.id, duration: _personalSchedule.duration,scheduleDone: _personalSchedule.scheduleDone, scheduleStart: true, scheduleStartTime: DateTime.now(), scheduleDoneTime: _personalSchedule.scheduleDoneTime);
    await _scheduleRepository.updateDurationAndDone(token,personalSchedule);
    notifyListeners();
  }


  Future<void> updateDurationAndDone() async {
    final token = await _authRepository.loadToken();
    bool? success =  await _scheduleRepository.updateDurationAndDone(token,_personalSchedule);
    if(success == null){
      final token = await _authRepository.requestRefreshToken();
      success = await _scheduleRepository.updateDurationAndDone(token,_personalSchedule);
    }
    notifyListeners();
  }
  Future<void> updateRoutineDone() async {
    try {
      ScheduleRoutine routine = _scheduleRoutineList[_currentIndex];
      final token = await _authRepository.loadToken();
      bool? success = await _routineRepository.updateRoutineDone(token, routine);
      if (success == null) {
        final token = await _authRepository.requestRefreshToken();
        success = await _routineRepository.updateRoutineDone(token, routine);
      }
      notifyListeners();
    } catch (e) {
      // 에러 처리
      print('에러가 발생했습니다: $e');
      _exitApp(); // 앱 종료
    }
  }
  void _exitApp() {
    if (Platform.isAndroid || Platform.isIOS) {
      exit(0);
    }
  }
}

