import 'package:flutter/cupertino.dart';
import 'package:goinggoing_flutterapp/Schedule/ScheduleViewModel.dart';

import '../Auth/AuthRepository.dart';
import '../Schedule/Schedule.dart';
import 'Routine.dart';
import 'RoutineRepository.dart';

class RoutineViewModel with ChangeNotifier {
  late final RoutineRepository _routineRepository;
  late final AuthRepository _authRepository;
  bool _isPutRunning=false;
  bool get isPutRunning => _isPutRunning;

  void statePutRunning(){
    _isPutRunning = !_isPutRunning;
    notifyListeners();
  }
  void makePutFalse(){
    _isPutRunning = false;
    notifyListeners();
  }

  late Routine? _emptyRoutine;
  Routine? get emptyRoutine => _emptyRoutine;

  List<ScheduleRoutine> _scheduleRoutineList = List.empty(growable: true);
  List<ScheduleRoutine> get scheduleRoutineList => _scheduleRoutineList;
  List<Routine> _routineList = List.empty(growable: true);
  List<Routine> get routineList => _routineList;
  late int _selectedRoutineIndex = -1;
  int get selectedRoutineIndex =>_selectedRoutineIndex;


  RoutineViewModel() {
    _routineRepository = RoutineRepository();
    _authRepository = AuthRepository();  // _authRepository를 초기화해줘야 함
  }

  void getEmptyRoutineList() {
    _emptyRoutine = Routine(routineId: null, title: '', details: <RoutineDetail>[] );
  }

  Future<void> getScheduleRoutineList(int id) async {
    final token = await _authRepository.loadToken();
    ScheduleRoutineData? scheduleRoutineData = await _routineRepository.getRoutineScheduleList(token, id);
    if(scheduleRoutineData == null){
      final token = await _authRepository.requestRefreshToken();
      scheduleRoutineData = await _routineRepository.getRoutineScheduleList(token, id);
    }
    _scheduleRoutineList = List.from(scheduleRoutineData!.scheduleRoutineList);
    _scheduleRoutineList.sort((a, b) => b.index.compareTo(a.index));
    notifyListeners();
  }
  void getMemberScheduleRoutineList(ScheduleRoutineData scheduleRoutineData){
    _scheduleRoutineList = List.from(scheduleRoutineData.scheduleRoutineList);
    _scheduleRoutineList.sort((a, b) => b.index.compareTo(a.index));
    notifyListeners();
  }
  void resetScheduleRoutineList() async{
    _scheduleRoutineList = List.empty(growable: true);
  }

  Future<void> getRoutineList() async {
    final token = await _authRepository.loadToken();
    List<Routine>? tempRoutineList = await _routineRepository.getRoutineList(token);
    if(tempRoutineList == null){
      final token = await _authRepository.requestRefreshToken();
      tempRoutineList = await _routineRepository.getRoutineList(token);
    }
    _routineList = tempRoutineList!;
    notifyListeners();
    print(_scheduleRoutineList.length);
  }


  int getScheduleRoutineTotalTime(){
    late int totaltime = 0;
    for (int index = 0; index < _scheduleRoutineList.length; index++) {
      totaltime += _scheduleRoutineList[index].time;
    }
    print(totaltime);
    return totaltime;
  }

  int getRoutineTotalTime(int index){
    late int totaltime = 0;
    for (int i = 0; i < _routineList[index].details!.length; i++) {
      totaltime += _routineList[index].details![i].time;
    }
    return totaltime;

  }

  int getRoutineDetailTotalTime(){
    late int totaltime = 0;
    for (int i = 0; i < _emptyRoutine!.details!.length; i++) {
      totaltime += _emptyRoutine!.details![i].time;
    }
    return totaltime;
  }

  Future<void> removeRoutineList(int index) async {
    final token = await _authRepository.loadToken();
    bool? success = await  _routineRepository.removeUserRoutine(token,routineList[index]!.routineId!);
    if(success == null){
      final token = await _authRepository.requestRefreshToken();
      success = await  _routineRepository.removeUserRoutine(token,routineList[index]!.routineId!);
    }
    _routineList.removeAt(index);
    notifyListeners();
  }
  void addRoutineList(Routine routine) {
    _routineList.add(routine);
    notifyListeners();
  }

  Future<void> removeScheduleRoutineList(int index) async{
    final token = await _authRepository.loadToken();
    bool? success =  await _routineRepository.removeScheduleRoutine(token,_scheduleRoutineList[index]!.scheduleId!);
    if(success == null){
      final token = await _authRepository.requestRefreshToken();
      success = await _routineRepository.removeScheduleRoutine(token,_scheduleRoutineList[index]!.scheduleId!);
    }
    _scheduleRoutineList.removeAt(index);
    notifyListeners();
  }

  Future<bool> updateScheduleRoutine(int personalScheduleId)async{
    for (int i=0; i<_scheduleRoutineList.length; i++){
      _scheduleRoutineList[i].index = i;
    }
    final token = await _authRepository.loadToken();
    bool? success = await _routineRepository.updateScheduleRoutine(token,_scheduleRoutineList,personalScheduleId);
    if(success == null){
      final token = await _authRepository.requestRefreshToken();
      success = await _routineRepository.updateScheduleRoutine(token,_scheduleRoutineList,personalScheduleId);
    }
    return true;
  }

  Future<void> addScheduleRoutineList(ScheduleRoutine scheduleRoutine,int personalScheduleId)async{
    final token = await _authRepository.loadToken();
    ScheduleRoutine? addScheduleRoutine = await _routineRepository.addScheduleRoutine(token,scheduleRoutine,personalScheduleId);
    if(addScheduleRoutine == null){
      final token = await _authRepository.requestRefreshToken();
      addScheduleRoutine = await _routineRepository.addScheduleRoutine(token,scheduleRoutine,personalScheduleId);
    }
    _scheduleRoutineList.add(addScheduleRoutine!);
    notifyListeners();
  }

  void moveScheduleRoutineList(int oldIndex, int newIndex) {
    if (oldIndex >= 0 && oldIndex < _scheduleRoutineList.length && newIndex >= 0 && newIndex < _scheduleRoutineList.length) {
      final ScheduleRoutine movedItem = _scheduleRoutineList.removeAt(oldIndex);
      _scheduleRoutineList.insert(newIndex, movedItem);
      notifyListeners();
    }
  }
  void moveRoutineList(int oldIndex, int newIndex) {
    if (oldIndex >= 0 && oldIndex < _routineList.length && newIndex >= 0 && newIndex < _routineList.length) {
      final Routine movedItem = _routineList.removeAt(oldIndex);
      _routineList.insert(newIndex, movedItem);
      notifyListeners();
    }
  }

  void moveRoutineDetailList(int oldIndex, int newIndex) {
    if (oldIndex >= 0 && oldIndex < _emptyRoutine!.details!.length && newIndex >= 0 && newIndex <  _emptyRoutine!.details!.length) {
      final RoutineDetail movedItem = _emptyRoutine!.details!.removeAt(oldIndex);
      _emptyRoutine!.details!.insert(newIndex, movedItem);
      notifyListeners();
    }
  }
  void updateSelectedRoutineIndex(int index){
    print(_selectedRoutineIndex);
    if(index ==-1){
      _selectedRoutineIndex = -1;
    }
    else if (_selectedRoutineIndex == index) {
        _selectedRoutineIndex = -1;
    } else {
        _selectedRoutineIndex = index;
    }
    notifyListeners();

  }
  Future<void> addRoutineToSchedule(int selectedRoutineIndex,int personalScheduleId)async {
    Routine selectedRoutine = _routineList[selectedRoutineIndex];
    int indexStart = scheduleRoutineList.length;
    for (int i = 0; i < selectedRoutine.details!.length; i++) {
      RoutineDetail routineDetail = selectedRoutine.details![i];
      ScheduleRoutine scheduleRoutine = ScheduleRoutine(
        scheduleId: null,
        content: routineDetail.content,
        time: routineDetail.time,
        index: indexStart+i,
      );
      await addScheduleRoutineList(scheduleRoutine,personalScheduleId);
    }
    notifyListeners();
  }
  Future<void> addRoutineDetailToRoutine()async{
    final token = await _authRepository.loadToken();
    for(int i=0; i<_emptyRoutine!.details!.length!; i++){
      _emptyRoutine!.details![i].index = i;
    }
    bool? success = await _routineRepository.addRoutineDetailToRoutine(token,_emptyRoutine!);
    if(success == null){
      final token = await _authRepository.requestRefreshToken();
      success = await _routineRepository.addRoutineDetailToRoutine(token,_emptyRoutine!);
    }
    getRoutineList();
    notifyListeners();
  }
  void addRoutineDetail(RoutineDetail routineDetail) {
    _emptyRoutine!.details!.add(routineDetail);
    notifyListeners();
  }
  void removeRoutineDetail(int index) {
    _emptyRoutine!.details!.removeAt(index);
    notifyListeners();
  }
  void updateRoutineDetail(int index,RoutineDetail routineDetail){
    _emptyRoutine!.details![index] = routineDetail;
    notifyListeners();

  }
  void updateEmptyRoutineTitle(String value){
    _emptyRoutine!.title = value;
    print(_emptyRoutine!.title);
    print(_emptyRoutine!.details!.length);
    notifyListeners();
  }
}
