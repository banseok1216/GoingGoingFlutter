import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'Calender.dart';
import 'CustomCalender.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static double screenWidth = 0;
  static double screenHeight = 0;
  CalendarViews _currentView = CalendarViews.dates;
  late DateTime _currentDateTime;
  late DateTime _selectedDateTime;
  late List<Calendar> _sequentialDates = [];
  late int midYear;
  final List<String> _weekDays = [
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
    'SUN'
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

  @override
  void initState() {
    super.initState();
    final date = DateTime.now();
    _currentDateTime = DateTime(date.year, date.month);
    _selectedDateTime = DateTime(date.year, date.month, date.day);
    midYear = date.year;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() => _getCalendar());
    });
  }

  // get calendar for current month
  void _getCalendar() {
    _sequentialDates = CustomCalendar().getMonthCalendar(
        _currentDateTime.month, _currentDateTime.year,
        startWeekDay: StartWeekDay.monday);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width / 540;
    screenHeight = MediaQuery.of(context).size.height / 1200;
    return Container(
      child: Center(
        child: Container(
            width: 479 * screenWidth,
            height: 849 * screenHeight,
            padding: EdgeInsets.symmetric(
                horizontal: 25 * screenWidth, vertical: 21 * screenHeight),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _xBtn(),
                      SizedBox(height: 20 * screenHeight),
                      firstframe(),
                      SizedBox(height: 20 * screenHeight),
                      _showSelectDate(),
                      SizedBox(height: 20 * screenHeight),
                      Container(
                        width: 429 * screenWidth,
                        height: 445 * screenHeight,
                        padding: EdgeInsets.symmetric(
                            vertical: 12 * screenHeight,
                            horizontal: 18 * screenWidth),
                        decoration: ShapeDecoration(
                          color: Color(0xFF292929),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                        ),
                        child: _datesView(),
                      ),
                      SizedBox(height: 20 * screenHeight),
                      Container(
                          width: 429 * screenWidth,
                          height: 81 * screenHeight,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFF4F4F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(70),
                            ),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color(0xFFFF4F4F), // 배경색을 빨간색으로 설정
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 236 * screenWidth,
                                  height: 37 * screenHeight,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      '이 날짜로 설정할게요.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFFF2F2F2),
                                        fontSize: 18*screenHeight,
                                        fontFamily: 'Apple',
                                        fontWeight: FontWeight.w100,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              String formattedDate =
                                  DateFormat('yyyy/MM/dd EEE', 'ko_KR')
                                      .format(_selectedDateTime);
                              Navigator.of(context).pop(formattedDate);
                            },
                          ))
                    ],
                  ),
                )
              ],
            ) // to be added in next step
            ),
      ),
    );
  }

  Widget firstframe() {
    return Container(
      width: double.infinity,
      height: 82 * screenHeight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 25 * screenWidth,
                  height: 28 * screenHeight,
                  child: Stack(children: [
                    SvgPicture.asset('assets/icons/whitebag.svg',
                        width: 25 * screenWidth, height: 28 * screenHeight)
                  ]),
                ),
              ],
            ),
          ),
          SizedBox(height: 14 * screenHeight),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 328 * screenWidth,
                  height: 40 * screenHeight,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      '새로운 일정을 추가할 수 있어요.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFF2F2F2),
                        fontSize: 20*screenHeight,
                        fontFamily: 'Apple',
                        fontWeight: FontWeight.w100,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _showSelectDate() {
    return Container(
        width: 429 * screenWidth,
        height: 87 * screenHeight,
        padding: EdgeInsets.symmetric(
            horizontal: 22 * screenWidth, vertical: 22 * screenHeight),
        decoration: ShapeDecoration(
          color: Color(0xFF4D4D4D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
        child: Container(
          width: 377 * screenWidth,
          height: 40 * screenHeight,
          alignment: Alignment.center, // 가운데 정렬
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              DateFormat('yyyy/MM/dd EEE').format(_selectedDateTime),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFF2F2F2),
                fontSize: 32*screenHeight,
                fontFamily: 'Apple',
                fontWeight: FontWeight.w100,
                height: 0,
              ),
            ),
          ),
        ));
  }

  Widget _xBtn() {
    return Container(
      width: 429 * screenWidth,
      height: 32 * screenHeight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 32 * screenWidth,
                  height: 32 * screenHeight,
                  child: Stack(children: [
                    SvgPicture.asset(
                      'assets/icons/greyxbutton.svg',
                      width: 32 * screenWidth,
                      height: 32 * screenHeight,
                    )
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _datesView() {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Container(
        padding: EdgeInsets.symmetric(horizontal: 5 * screenWidth),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              _toggleBtn(false),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _currentView = CalendarViews.months;
                    });
                  },
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 47 * screenWidth,
                          height: 27 * screenHeight,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              '${_currentDateTime.year}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15*screenHeight,
                                fontFamily: 'Apple',
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            width: 206 * screenWidth,
                            height: 41 * screenHeight,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                '${_monthNames[_currentDateTime.month - 1]}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36*screenHeight,
                                  fontFamily: 'Apple',
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              _toggleBtn(true),
            ]),
      ),
      SizedBox(height: 12 * screenHeight),
      Flexible(child: _calendarBody()),
    ]);
  }

  Widget _toggleBtn(bool next) {
    return InkWell(
      // explained in later stages
      onTap: () {
        if (_currentView == CalendarViews.dates) {
          setState(() => (next) ? _getNextMonth() : _getPrevMonth());
        } else if (_currentView == CalendarViews.year) {
          if (next) {
            midYear =
                (midYear == null) ? _currentDateTime.year + 9 : midYear + 9;
          } else {
            midYear =
                (midYear == null) ? _currentDateTime.year - 9 : midYear - 9;
          }
          setState(() {});
        }
      },
      child: Container(
        width: 35 * screenWidth,
        height: 35 * screenHeight,
        child: Icon((next) ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
            color: Colors.grey),
      ),
    );
  }

  Widget _calendarBody() {
    if (_sequentialDates == null) return Container();
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: _sequentialDates.length + 7,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10 * screenWidth,
        crossAxisCount: 7,
        crossAxisSpacing: 10 * screenHeight,
      ),
      itemBuilder: (context, index) {
        if (index < 7) return _weekDayTitle(index);
        if (_sequentialDates[index - 7].date == _selectedDateTime)
          return _selector(_sequentialDates[index - 7]);
        return _calendarDates(_sequentialDates[index - 7]);
      },
    );
  }

  Widget _weekDayTitle(int index) {
    return Text(
      _weekDays[index],
      style: TextStyle(
          fontFamily: 'Apple',
          fontWeight: FontWeight.w100,
          color: Colors.white,
          fontSize: 15*screenHeight),
    );
  }

// calendar element
  Widget _calendarDates(Calendar calendarDate) {
    return InkWell(
      onTap: () {
        if (_selectedDateTime != calendarDate.date) {
          if (calendarDate.nextMonth) {
            _getNextMonth();
          } else if (calendarDate.prevMonth) {
            _getPrevMonth();
          }
          setState(() => _selectedDateTime = calendarDate.date);
        }
      },
      child: Center(
          child: Text(
        '${calendarDate.date.day}',
        style: TextStyle(
            fontFamily: 'Apple',
            fontWeight: FontWeight.w100,
            color: (calendarDate.thisMonth)
                ? Colors.white
                : Colors.white.withOpacity(0.5),
            fontSize: 15*screenHeight),
      )),
    );
  }

// date selector
  Widget _selector(Calendar calendarDate) {
    return Container(
      width: 32 * screenWidth,
      height: 32 * screenHeight,
      decoration: BoxDecoration(
        color: Color(0xFFFF4F4F),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        child: Center(
          child: Text(
            '${calendarDate.date.day}',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Apple',
                fontWeight: FontWeight.w100),
          ),
        ),
      ),
    );
  }

  // get next month calendar
  void _getNextMonth() {
    if (_currentDateTime.month == 12) {
      _currentDateTime = DateTime(_currentDateTime.year + 1, 1);
    } else {
      _currentDateTime =
          DateTime(_currentDateTime.year, _currentDateTime.month + 1);
    }
    _getCalendar();
  }

// get previous month calendar
  void _getPrevMonth() {
    if (_currentDateTime.month == 1) {
      _currentDateTime = DateTime(_currentDateTime.year - 1, 12);
    } else {
      _currentDateTime =
          DateTime(_currentDateTime.year, _currentDateTime.month - 1);
    }
    _getCalendar();
  }
}
