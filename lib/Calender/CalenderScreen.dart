import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goinggoing_flutterapp/Calender/CalenderDetailsScreen.dart';
import 'package:goinggoing_flutterapp/Schedule/ScheduleViewModel.dart';
import 'package:goinggoing_flutterapp/Timer/TimerViewModel.dart';
import 'package:goinggoing_flutterapp/User/UserViewModel.dart';
import 'package:intl/intl.dart';
import 'Calender.dart';
import 'CalenderViewModel.dart';
import 'CustomCalender.dart';
import 'package:provider/provider.dart';

import 'CustomCalenderController.dart';
import '../PageServuce.dart';

class CalenderScreen extends StatelessWidget {
  static double screenWidth = 0;
  static double screenHeight = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width / 540;
    screenHeight = MediaQuery.of(context).size.height / 1200;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: 540 * screenWidth,
        height: 1100 * screenHeight,
        padding: EdgeInsets.only(
          top: 30 * screenHeight,
          left: 28 * screenWidth,
          right: 28 * screenWidth,
        ),
        decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            head_partition(context),
            mid_partition(context),
            SizedBox(height: 16 * screenHeight),
            third_partition(context),
          ],
        ),
      ),
    );
  }

  Widget mid_partition(BuildContext context) {
    return Container(
        width: 484 * screenWidth,
        height: 650 * screenHeight,
        color: const Color(0xFFF2F2F2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _yearmonthView(context),
            SizedBox(
              height: 16 * screenHeight,
            ),
            calender_partition(context),
          ],
        ));
  }

  Widget _yearmonthView(context) {
    final calenderViewModel = Provider.of<CalendarViewModel>(context);
    return Container(
      width: 484 * screenWidth,
      height: 94 * screenHeight,
      padding: EdgeInsets.only(
          left: 10 * screenWidth,
          right: 10 * screenWidth,
          bottom: 12 * screenHeight),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            _toggleBtn(false, context),
            SizedBox(
              width: 85 * screenWidth,
            ),
            Center(
                child: Container(
              width: 206 * screenWidth,
              height: 93 * screenHeight,
              child: Column(
                children: [
                  SizedBox(
                    width: 206 * screenWidth,
                    height: 27 * screenHeight,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        '${calenderViewModel.currentDateTime.year}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15 * screenHeight,
                          fontFamily: 'Apple',
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: SizedBox(),
                    fit: FlexFit.tight,
                  ),
                  SizedBox(
                    width: 206 * screenWidth,
                    height: 47 * screenHeight,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text(
                          calenderViewModel.monthNames[
                              calenderViewModel.currentDateTime.month - 1],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40 * screenHeight,
                            fontFamily: 'Apple',
                            fontWeight: FontWeight.w100,
                          )),
                    ),
                  ),
                ],
              ),
            )),
            SizedBox(
              width: 85 * screenWidth,
            ),
            _toggleBtn(true, context),
          ]),
    );
  }

  Widget _toggleBtn(bool next, context) {
    final calenderViewModel = Provider.of<CalendarViewModel>(context);
    return InkWell(
      // explained in later stages
      onTap: () {
        next ? calenderViewModel.onNextTap() : calenderViewModel.onPrevTap();
      },
      child: Container(
        width: 35 * screenWidth,
        height: 35 * screenHeight,
        child: Icon((next) ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
            color: Colors.grey),
      ),
    );
  }

  Widget calender_partition(BuildContext context) {
    final calenderViewModel = Provider.of<CalendarViewModel>(context);
    return Container(
      width: 484 * screenWidth,
      height: 530 * screenHeight,
      padding: EdgeInsets.symmetric(
          horizontal: 18 * screenWidth, vertical: 23.5 * screenHeight),
      decoration: ShapeDecoration(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 448 * screenWidth,
            height: 38 * screenHeight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int index = 0; index < 7; index++)
                  Row(
                    children: [
                      _weekDayTitle(index, context),
                      SizedBox(width: 8 * screenWidth),
                    ],
                  )
              ],
            ),
          ),
          SizedBox(height: 8 * screenHeight),
          Container(
            width: 448 * screenWidth,
            height: 66.20 * screenHeight,
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int index = 0; index < 7; index++)
                    Row(
                      children: [
                        Day_partition(
                            context, calenderViewModel.sequentialDates[index]),
                        SizedBox(width: 8 * screenWidth),
                      ],
                    )
                ]),
          ),
          SizedBox(height: 8 * screenHeight),
          Container(
            width: 448 * screenWidth,
            height: 66.20 * screenHeight,
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int index = 7; index < 14; index++)
                    Row(
                      children: [
                        Day_partition(
                            context, calenderViewModel.sequentialDates[index]),
                        SizedBox(width: 8 * screenWidth),
                      ],
                    )
                ]),
          ),
          SizedBox(height: 8 * screenHeight),
          Container(
            width: 448 * screenWidth,
            height: 66.20 * screenHeight,
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int index = 14; index < 21; index++)
                    Row(
                      children: [
                        Day_partition(
                            context, calenderViewModel.sequentialDates[index]),
                        SizedBox(width: 8 * screenWidth),
                      ],
                    )
                ]),
          ),
          SizedBox(height: 8 * screenHeight),
          Container(
            width: 448 * screenWidth,
            height: 66.20 * screenHeight,
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int index = 21; index < 28; index++)
                    Row(
                      children: [
                        Day_partition(
                            context, calenderViewModel.sequentialDates[index]),
                        SizedBox(width: 8 * screenWidth),
                      ],
                    )
                ]),
          ),
          SizedBox(height: 8 * screenHeight),
          if (calenderViewModel.sequentialDates.length >= 29)
            Container(
              width: 448 * screenWidth,
              height: 66.20 * screenHeight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int index = 28; index < 35; index++)
                    Row(
                      children: [
                        Day_partition(
                            context, calenderViewModel.sequentialDates[index]),
                        SizedBox(width: 8 * screenWidth),
                      ],
                    ),
                ],
              ),
            )
          else
            Container(),
        ],
      ),
    );
  }

  Widget _weekDayTitle(int index, context) {
    final calenderViewModel = Provider.of<CalendarViewModel>(context);
    return Container(
      width: 56 * screenWidth,
      height: 38 * screenHeight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              calenderViewModel.weekDays[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFFF2F2F2),
                fontSize: 15 * screenHeight,
                fontFamily: 'Apple',
                fontWeight: FontWeight.w100,
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget head_partition(BuildContext context) {
    ScheduleViewModel scheduleViewModel =
        Provider.of<ScheduleViewModel>(context);
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    return Container(
      width: 484 * screenWidth,
      height: 245 * screenHeight,
      padding: EdgeInsets.symmetric(
          horizontal: 17 * screenWidth, vertical: 13 * screenHeight),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: SizedBox(
                width: 77 * screenWidth,
                height: 33 * screenHeight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/images/Vector.png',
                        fit: BoxFit
                            .contain, // Adjust the BoxFit according to your needs
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 23 * screenHeight),
            Container(
              width: 449.77 * screenWidth,
              height: 143 * screenHeight,
              decoration: ShapeDecoration(
                color: const Color(0xFFE6E6E6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              padding: EdgeInsets.only(left: 30 * screenWidth),
              child: Row(
                children: [
                  Container(
                    width: 228.77 * screenWidth,
                    child: Text(
                      textAlign: TextAlign.left,
                      '안녕하세요. ${userViewModel.user!.userNickName!}님!\n오늘은 ${scheduleViewModel.getScheduleForDate(DateTime.now())}건의 외출 일정이 있어요.',
                      style: TextStyle(
                        color: const Color(0xFF4D4D4D),
                        fontSize: 16 * screenHeight,
                        fontFamily: 'Apple',
                        fontWeight: FontWeight.w100,
                        height: 0,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Container(
                    width: 191 * screenWidth,
                    height: 143 * screenHeight,
                    child: Image.asset(
                      'assets/images/rabbitcrop1.png',
                      width: 191 * screenWidth,
                      height: 143 * screenHeight,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10 * screenHeight),
            Divider(
              color: Colors.grey, // 선의 색상을 원하는 색으로 설정
              thickness: 1.0, // 선의 두께 조절
              height: 10 * screenHeight, // 선의 위와 아래 여백 조절
            ),
          ]),
    );
  }

  Widget third_partition(context) {
    ScheduleViewModel scheduleViewModel =
        Provider.of<ScheduleViewModel>(context);
    TimerViewModel timerViewModel =
    Provider.of<TimerViewModel>(context);
    return Consumer<PageViewModel>(builder: (context, vm, _) {
      return Container(
        width: 484 * screenWidth,
        height: 128 * screenHeight,
        child: ElevatedButton(
          onPressed: timerViewModel.nearestSchedule.id != null
              ? () {
                  vm.setPage(3);
                }
              : null,
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(0xFFFF4F4F)),
            padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.only(left: 36 * screenWidth),
            ),
            minimumSize: MaterialStateProperty.all<Size>(
              Size(484 * screenWidth, 128 * screenHeight),
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(68.26),
              ),
            ),
            elevation: MaterialStateProperty.all<double>(9.90),
            shadowColor: MaterialStateProperty.all<Color>(Color(0x2D000000)),
          ),
          child: Container(
            width: 448 * screenWidth,
            height: 92 * screenHeight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 258 * screenWidth,
                  padding: EdgeInsets.only(left: 20 * screenWidth),
                  height: double.infinity,
                  child: timerViewModel.nearestSchedule!.id == null
                      ? Container(
                    alignment: Alignment.centerLeft,
                          child: Text(
                            '${timerViewModel.nearestSchedule.title}',
                            style: TextStyle(
                              color: const Color(0xFFF2F2F2),
                              fontSize: 24 * screenHeight,
                              fontFamily: 'Apple',
                              fontWeight: FontWeight.w100,
                              height: 0,
                            ),
                          ),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 258 * screenWidth,
                              height: 36 * screenHeight,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${timerViewModel.nearestSchedule.title}',
                                  style: TextStyle(
                                    color: const Color(0xFFF2F2F2),
                                    fontSize: 24 * screenHeight,
                                    fontFamily: 'Apple',
                                    fontWeight: FontWeight.w100,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5 * screenHeight),
                            SizedBox(
                              width: 258 * screenWidth,
                              height: 24 * screenHeight,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'D-' +
                                      '${timerViewModel.nearestSchedule.date?.difference(DateTime.now()).inDays}',
                                  style: TextStyle(
                                    color: const Color(0xFFF2F2F2),
                                    fontSize: 16 * screenHeight,
                                    fontFamily: 'Apple',
                                    fontWeight: FontWeight.w100,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5 * screenHeight),
                            SizedBox(
                              width: 258 * screenWidth,
                              height: 22 * screenHeight,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  DateFormat('d (E)', 'ko_KR').format(
                                      timerViewModel.nearestSchedule!.date!),
                                  style: TextStyle(
                                    color: const Color(0xFFF2F2F2),
                                    fontSize: 16 * screenHeight,
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
                SizedBox(width: 106 * screenWidth),
                Container(
                  width: 19 * screenWidth,
                  height: 92 * screenHeight,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/white_vector.svg')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget Day_partition(BuildContext context, Calendar calendarDate) {
    final calenderViewModel = Provider.of<CalendarViewModel>(context);
    final ScheduleViewModel scheduleViewModel =
        Provider.of<ScheduleViewModel>(context);
    return Consumer<PageViewModel>(builder: (context, vm, _) {
      return Opacity(
        opacity: calendarDate.thisMonth ? 1 : 0.3,
        child: Container(
          width: 56 * screenWidth,
          height: 60 * screenHeight,
          child: ElevatedButton(
            onPressed: () {
              if (calendarDate.nextMonth) {
                calenderViewModel.getNextMonth();
              } else if (calendarDate.prevMonth) {
                calenderViewModel.getPrevMonth();
              } else {
                scheduleViewModel.getSelectScheduleList(calendarDate.date);
                calenderViewModel.updateView(calendarDate, screenWidth);
                vm.setPage(1);
              }
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: EdgeInsets.symmetric(
                  vertical: 1 * screenWidth, horizontal: 1 * screenHeight),
              backgroundColor: calenderViewModel.today != calendarDate.date
                  ? Colors.black
                  : const Color(0xFFFF4F4F),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 32 * min(screenWidth, screenHeight),
                  height: 32 * min(screenWidth, screenHeight),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      '${calendarDate.date.day}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFFF5F5F5),
                        fontSize: 20 * screenHeight,
                        fontFamily: 'Apple',
                        fontWeight: FontWeight.w100,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8 * screenWidth),
                countshedule(
                    scheduleViewModel.getScheduleForDate(calendarDate.date)),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget countshedule(int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        index >= 1
            ? SvgPicture.asset(
                'assets/icons/circlevector.svg',
                width: 6 * min(screenWidth, screenHeight),
                height: 6 * min(screenWidth, screenHeight),
              )
            : Container(
                width: 6 * min(screenWidth, screenHeight),
                height: 6 * min(screenWidth, screenHeight),
              ),
        SizedBox(width: 4 * screenWidth),
        index >= 2
            ? SvgPicture.asset(
                'assets/icons/circlevector.svg',
                width: 6 * min(screenWidth, screenHeight),
                height: 6 * min(screenWidth, screenHeight),
              )
            : Container(
                width: 6 * min(screenWidth, screenHeight),
                height: 6 * min(screenWidth, screenHeight),
              ),
        SizedBox(width: 4 * screenWidth),
        index >= 3
            ? SvgPicture.asset(
                'assets/icons/circlevector.svg',
                width: 6 * min(screenWidth, screenHeight),
                height: 6 * min(screenWidth, screenHeight),
              )
            : Container(
                width: 6 * min(screenWidth, screenHeight),
                height: 6 * min(screenWidth, screenHeight),
              ),
      ],
    );
  }
}
