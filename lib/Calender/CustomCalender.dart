import 'Calender.dart';

class CustomCalendar{
// number of days in month
  //[JAN, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCT, NOV, DEC]
  final List<int> _monthDays =
  [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
// check for leap year
  bool _isLeapYear(int year){
    if(year % 4 == 0){
      if(year % 100 == 0){
        if(year % 400 == 0) return true;
        return false;
      }
      return true;
    }
    return false;
  }
  List<Calendar> getOnlyMonthCalendar(int month, int year) {
    List<Calendar> calendar = [];
    // validate
    if (year == null || month == null || month < 1 || month > 12)
      throw ArgumentError('Invalid year or month');
    // get no. of days in the month
    // month-1 because _monthDays starts from index 0
    // and month starts from 1
    int totalDays = _monthDays[month - 1];
    // if this is a leap year and the month is february,
    // increment the total days by 1
    if (_isLeapYear(year) && month == DateTime.february) totalDays++;
    // get days for this month
    for (int i = 0; i < totalDays; i++) {
      calendar.add(
        Calendar(
          // i+1 because day starts from 1 in DateTime class
          date: DateTime(year, month, i + 1),
          thisMonth: true,
        ),
      );
    }
    return calendar;
  }

  /// get the month calendar
  /// month is between from 1-12 (1 for January and 12 for December)
  List<Calendar> getMonthCalendar(int month, int year,
      {StartWeekDay startWeekDay = StartWeekDay.sunday}){
    List<Calendar> calendar = [];
    // validate
    if(year == null || month == null || month < 1 || month > 12)
      throw ArgumentError('Invalid year or month');
    // get no. of days in the month
    // month-1 because _monthDays starts from index 0
    // and month starts from 1
    int totalDays = _monthDays[month - 1];
    // if this is a leap year and the month is february,
    // increment the total days by 1
    if(_isLeapYear(year) && month == DateTime.february) totalDays++;
    // get days for this month
    for(int i=0; i<totalDays; i++){
      calendar.add(
        Calendar(
          // i+1 because day starts from 1 in DateTime class
          date: DateTime(year, month, i+1),
          thisMonth: true,
        ),
      );
    }
    // used for previous and next month's calendar days
    int otherYear;
    int otherMonth;
    int leftDays;
// fill the unfilled starting weekdays of this month
// with the previous month days
    if(
    (startWeekDay == StartWeekDay.sunday &&
        calendar.first.date.weekday != DateTime.sunday) ||
        (startWeekDay == StartWeekDay.monday &&
            calendar.first.date.weekday != DateTime.monday)
    ){
      // if this month is january,
      // then previous month would be decemeber of previous year
      if(month == DateTime.january){
        otherMonth = DateTime.december;
        otherYear = year-1;
      }
      else{
        otherMonth = month - 1;
        otherYear = year;
      }

      // month-1 because _monthDays starts from index 0
      // and month starts from 1
      totalDays = _monthDays[otherMonth - 1];
      if(_isLeapYear(otherYear) && otherMonth == DateTime.february)
        totalDays++;
      leftDays = totalDays - calendar.first.date.weekday +
          ((startWeekDay == StartWeekDay.sunday) ? 0 : 1);

      for(int i=totalDays; i>leftDays; i--){
        // add days to the start of the list to maintain the sequence
        calendar.insert(0,
          Calendar(
            date: DateTime(otherYear, otherMonth, i),
            prevMonth: true,
          ),
        );
      }
    }
    // fill the unfilled ending weekdays of this month with the next month days
    int rightDays;

    // Check if the last day of the current month is Saturday (7) when startWeekDay is Sunday,
    // or Sunday (1) when startWeekDay is Monday.
    if ((startWeekDay == StartWeekDay.sunday &&
        calendar.last.date.weekday != DateTime.saturday) ||
        (startWeekDay == StartWeekDay.monday &&
            calendar.last.date.weekday != DateTime.sunday)) {
      // if this month is December,
      // then next month would be January of next year
      if (month == DateTime.december) {
        otherMonth = DateTime.january;
        otherYear = year + 1;
      } else {
        otherMonth = month + 1;
        otherYear = year;
      }

      rightDays = 7 -( calendar.last.date.weekday + ((startWeekDay == StartWeekDay.sunday) ? 1 : 0));

      for (int i = 1; i <= rightDays; i++) {
        calendar.add(
          Calendar(
            date: DateTime(otherYear, otherMonth, i),
            nextMonth: true,
          ),
        );
      }
    }
    return calendar;
  }
}
enum CalendarViews{ dates, months, year }
enum StartWeekDay {sunday, monday}