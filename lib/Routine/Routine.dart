class Routine {
  int? routineId;
  String? title;
  List<RoutineDetail>? details;

  Routine({
    required this.routineId,
    required this.title,
    required this.details,
  });

  factory Routine.fromJson(Map<String, dynamic> json) {
    return Routine(
      routineId: json['userRoutineId'],
      title: json['userRoutineName'],
      details: (json['userRoutineDetails'] as List<dynamic>)
          .map((detail) => RoutineDetail.fromJson(detail))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userRoutineId': routineId,
      'userRoutineName': title,
      'routineDetail': details?.map((detail) => detail.toJson()).toList(),
    };
  }
}

class RoutineDetail {
  int routineDetailId; // Added routineDetailId field
  String content;
  int time;
  int index;

  RoutineDetail({
    required this.routineDetailId,
    required this.content,
    required this.time,
    required this.index,
  });

  factory RoutineDetail.fromJson(Map<String, dynamic> json) {
    return RoutineDetail(
      index: json['index'],
      routineDetailId: json['routineDetailId'],
      content: json['routineDetailName'],
      time: json['routineDetailTime'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'routineDetailId': routineDetailId,
      'routineDetailName': content,
      'routineDetailTime': time,
      'index': index,
    };
  }
}


class ScheduleRoutine {

  int? scheduleId;
  String content;
  int time;
  int index;


  ScheduleRoutine({required this.content, required this.time,required this.scheduleId,required this.index});

  factory ScheduleRoutine.fromJson(Map<String, dynamic> json) {
    return ScheduleRoutine(
      scheduleId: json['scheduleRoutineId'],
      content: json['scheduleRoutineName'],
      time: json['scheduleRoutineTime'],
        index: json['scheduleRoutineIndex'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'scheduleRoutineId': scheduleId,
      'scheduleRoutineName': content,
      'scheduleRoutineTime': time,
      'scheduleRoutineIndex': index,
    };
  }
}
