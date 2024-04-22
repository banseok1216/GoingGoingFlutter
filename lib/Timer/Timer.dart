class TimerRoutine {
  String title;
  List<TimerRoutineDetail> details;

  TimerRoutine({required this.title, required this.details});
}

class TimerRoutineDetail {
  String RoutineContent;
  Duration Rountinetime;
  TimerRoutineDetail({required this.RoutineContent, required this.Rountinetime});
}

class TimerSchedule {
  String Schedulelocation;
  Duration Scheduleduration;
  String Scheduletitle;
  DateTime Scheduledate;
  Duration ScheduleTotaltime;
  TimerSchedule({
    required this.Schedulelocation,
    required this.Scheduleduration,
    required this.Scheduletitle,
    required this.Scheduledate,
    required this.ScheduleTotaltime,
  });
}
