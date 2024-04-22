import '../Routine/Routine.dart';

class Schedule {
  final int? id;
  late final String? title;
  late final DateTime? date;
  late final String? location;

  Schedule({
    required this.id,
    required this.title,
    required this.date,
    required this.location,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['scheduleId'],
      title: json['scheduleName'],
      date: DateTime.parse(json['scheduleDateTime']),
      // Parse the string to DateTime
      location: json['scheduleLocation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'scheduleId': id,
      'scheduleName': title,
      'scheduleDateTime': date?.toIso8601String(),
      // Convert DateTime to ISO 8601 string
      'scheduleLocation': location,
    };
  }
}

class PersonalSchedule {
  final int? id;
  final int duration;
  final bool scheduleDone;
  final bool scheduleStart;
  final DateTime scheduleStartTime;
  final DateTime scheduleDoneTime;

  PersonalSchedule({
    required this.scheduleStart,
    required this.scheduleStartTime,
    required this.scheduleDoneTime,
    required this.id,
    required this.duration,
    required this.scheduleDone,
  });

  factory PersonalSchedule.fromJson(Map<String, dynamic> json) {
    return PersonalSchedule(
      id: json['personalScheduleId'],
      duration: json['duration'],
      scheduleDone: json['scheduleDone'],
      scheduleStart: json['scheduleStart'],
      scheduleStartTime: DateTime.parse(json['scheduleStartTime']),
      scheduleDoneTime: DateTime.parse(json['scheduleDoneTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'personalScheduleId': id,
      'duration': duration,
      'scheduleDone': scheduleDone,
      'scheduleStart': scheduleStart,
      'scheduleStartTime': scheduleStartTime.toIso8601String(),
      'scheduleDoneTime': scheduleDoneTime.toIso8601String(),
    };
  }
}

class ScheduleData {
  final Schedule schedule;
  final PersonalSchedule personalSchedule;

  ScheduleData(this.schedule, this.personalSchedule);
}

class ScheduleRoutineData {
  final PersonalSchedule personalSchedule;
  final List<ScheduleRoutine> scheduleRoutineList;

  ScheduleRoutineData(
    this.personalSchedule,
    this.scheduleRoutineList,
  );
}
