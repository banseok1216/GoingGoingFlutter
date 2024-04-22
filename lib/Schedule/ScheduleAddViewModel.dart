import 'package:flutter/cupertino.dart';
import 'package:goinggoing_flutterapp/Auth/AuthRepository.dart';
import 'package:goinggoing_flutterapp/Schedule/Schedule.dart';
import 'package:goinggoing_flutterapp/Schedule/ScheduleRepository.dart';

class ScheduleAddViewModel with ChangeNotifier {
  DateTime _selectedTime = DateTime.now();
  bool _isAnimatedfirst = false;
  bool _isAnimatedthird = false;
  bool _isAnimatedsecond = false;
  bool _isfirstComplete = false;
  bool _isthirdComplete = false;
  bool _isAnimatedfourth = false;
  bool _issecondComplete = false;
  bool _isfourthComplete = false;
  bool _iseverythingComplete = false;

  DateTime get selectedTime => _selectedTime;

  bool get isAnimatedfirst => _isAnimatedfirst;

  bool get isAnimatedthird => _isAnimatedthird;

  bool get isAnimatedsecond => _isAnimatedsecond;

  bool get isfirstComplete => _isfirstComplete;

  bool get isthirdComplete => _isthirdComplete;

  bool get isAnimatedfourth => _isAnimatedfourth;

  bool get issecondComplete => _issecondComplete;

  bool get isfourthComplete => _isfourthComplete;

  bool get iseverythingComplete => _iseverythingComplete;
  String _firstinitate = '일정제목';
  String _secondinitate = '날짜';
  String _fourthinitate = '장소';
  String _thirdinitate = '시간';

  String get firstinitate => _firstinitate;

  String get secondinitate => _secondinitate;

  String get fourthinitate => _fourthinitate;

  String get thirdinitate => _thirdinitate;
  late Schedule? _schedule;

  late final ScheduleRepository _scheduleRepository;
  late final AuthRepository _authRepository;

  ScheduleAddViewModel() {
    _scheduleRepository = ScheduleRepository();
    _authRepository = AuthRepository();
  }

  void resetState() {
    _selectedTime = DateTime.now();
    _isAnimatedfirst = false;
    _isAnimatedthird = false;
    _isAnimatedsecond = false;
    _isfirstComplete = false;
    _isthirdComplete = false;
    _isAnimatedfourth = false;
    _issecondComplete = false;
    _isfourthComplete = false;
    _iseverythingComplete = false;
    _firstinitate = '일정제목';
    _secondinitate = '날짜';
    _fourthinitate = '장소';
    _thirdinitate = '시간';
    _schedule = null; // 또는 초기값으로 설정해야 하는 값으로 초기화
    notifyListeners();
  }

  void changefirstinitate(String value) {
    _firstinitate = value;
  }

  void changesecondinitate(String value) {
    _secondinitate = value;
  }

  void changefourthinitate(String value) {
    _fourthinitate = value;
  }

  void changethirdinitate(String value) {
    _thirdinitate = value;
  }

  void changeAnimatedfirst(bool value) {
    _isAnimatedfirst = value;
    notifyListeners();
  }

  void changeAnimatedthird(bool value) {
    _isAnimatedthird = value;
    notifyListeners();
  }

  void changeAnimatedsecond(bool value) {
    _isAnimatedsecond = value;
    notifyListeners();
  }

  void changeAnimatedfourth(bool value) {
    _isAnimatedfourth = value;
    notifyListeners();
  }

  void changefirstComplete(bool value) {
    _isfirstComplete = value;
    notifyListeners();
  }

  void changesecondComplete(bool value) {
    _issecondComplete = value;
    notifyListeners();
  }

  void changethirdComplete(bool value) {
    _isthirdComplete = value;
    notifyListeners();
  }

  void changefourthComplete(bool value) {
    _isfourthComplete = value;
    notifyListeners();
  }

  void changeeverythingComplete(bool value) {
    _iseverythingComplete = value;
    notifyListeners();
  }

  void changeselectedTime(DateTime time) {
    _selectedTime = time;
  }

  Future<Schedule> postSchedule() async {
    final token = await _authRepository.loadToken();
    DateTime date = DateTime.parse(_secondinitate.split(" ")[0].replaceAll("/", "-"));
    DateTime dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        _selectedTime.hour,
        _selectedTime.minute);
    _schedule = Schedule(
        id: null,
        title: _firstinitate,
        date: dateTime,
        location: _fourthinitate);
    Schedule? schedule =  await _scheduleRepository.postSchedule(token, _schedule!);
    if(schedule == null){
      final token = await _authRepository.requestRefreshToken();
      schedule =await _scheduleRepository.postSchedule(token, _schedule!);
    }
    return schedule!;
  }

}
