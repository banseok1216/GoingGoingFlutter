import 'package:flutter/material.dart';
import 'package:goinggoing_flutterapp/Schedule/ScheduleViewModel.dart';

import 'Calender.dart';
import 'CustomCalender.dart';



class CalendarViewModel extends ChangeNotifier {
  CalendarViews _currentView = CalendarViews.dates;
  late DateTime _currentDateTime;
  late DateTime _selectedDateTime;
  late DateTime _today;
  late List<Calendar> _sequentialDates = [];
  late List<Calendar> _onlysequentialDates = [];

  late int midYear;
  final List<String> _weekDays = [
    'SUN',
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
  ];
  final List<String> _weeksDays = [
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
    'SUN',
  ];
  final List<String> _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  CalendarViewModel() {
    _initialize();
  }

  void _initialize() {
    final date = DateTime.now();
    _currentDateTime = DateTime(date.year, date.month, date.day);
    _selectedDateTime = DateTime(date.year, date.month, date.day);
    _today = DateTime(date.year, date.month, date.day);
    midYear = date.year;
    getCalendar();
    getOnlyCalender();
  }

  CalendarViews get currentView => _currentView;

  DateTime get currentDateTime => _currentDateTime;

  DateTime get selectedDateTime => _selectedDateTime;

  DateTime get today => _today;

  List<Calendar> get sequentialDates => _sequentialDates;

  List<Calendar> get onlysequentialDates => _onlysequentialDates;

  List<String> get weekDays => _weekDays;
  List<String> get weeksDays => _weeksDays;

  List<String> get monthNames => _monthNames;

  void getCalendar() {
    _sequentialDates = CustomCalendar().getMonthCalendar(
        _currentDateTime.month, _currentDateTime.year,
        startWeekDay: StartWeekDay.sunday);
    notifyListeners();
  }
  void getOnlyCalender(){
    _onlysequentialDates = CustomCalendar().getOnlyMonthCalendar(
        _currentDateTime.month, _currentDateTime.year);
    notifyListeners();
  }
  void updateView(Calendar calendar, double screenWidth) {
    _selectedDateTime = calendar.date;
    _scrollToSelectedDate(calendar,screenWidth);
    notifyListeners();
  }
  void onNextTap() {
    if (_currentView == CalendarViews.dates) {
      getNextMonth();
    } else if (_currentView == CalendarViews.year) {
      midYear = midYear == null ? _currentDateTime.year + 9 : midYear + 9;
    }
    notifyListeners();
  }

  void onPrevTap() {
    if (_currentView == CalendarViews.dates) {
      getPrevMonth();
    } else if (_currentView == CalendarViews.year) {
      midYear = midYear == null ? _currentDateTime.year - 9 : midYear - 9;
    }
    notifyListeners();
  }

  void getNextMonth() {
    if (_currentDateTime.month == 12) {
      _currentDateTime = DateTime(_currentDateTime.year + 1, 1);
    } else {
      _currentDateTime =
          DateTime(_currentDateTime.year, _currentDateTime.month + 1);
    }
    getCalendar();
    getOnlyCalender();
  }

  void getPrevMonth() {
    if (_currentDateTime.month == 1) {
      _currentDateTime = DateTime(_currentDateTime.year - 1, 12);
    } else {
      _currentDateTime =
          DateTime(_currentDateTime.year, _currentDateTime.month - 1);
    }
    getCalendar();
    getOnlyCalender();
  }
  void _scrollToSelectedDate(Calendar calendar,double screenWidth) {
    if (selectedDateTime != null && onlysequentialDates.isNotEmpty) {
      int selectedIndex = onlysequentialDates.indexOf(calendar);
      double itemWidth = 56*screenWidth; // 아이템 너비
      double offset = (selectedIndex-3.5)*itemWidth;
      scrollController.animateTo(
        offset,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
  ScrollController scrollController = ScrollController();
}
