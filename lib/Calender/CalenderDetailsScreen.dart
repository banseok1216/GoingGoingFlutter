import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goinggoing_flutterapp/Calender/CalenderScreen.dart';
import 'package:goinggoing_flutterapp/Routine/RoutineViewModel.dart';
import 'package:goinggoing_flutterapp/Schedule/ScheduleViewModel.dart';
import 'package:goinggoing_flutterapp/User/UserViewModel.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Group/GroupViewModel.dart';
import '../Schedule/ScheduleDetailScreen.dart';
import 'Calender.dart';
import 'CalenderViewModel.dart';
import '../Schedule/Schedule.dart';

class CalenderDetailsScreen extends StatelessWidget {
  late List<ScheduleData> dayScheduleList;
  static double screenWidth = 0;
  static double screenHeight = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width / 540;
    screenHeight = MediaQuery.of(context).size.height / 1200;
    final routineViewModel = Provider.of<RoutineViewModel>(context);
    final groupViewModel = Provider.of<GroupViewModel>(context);
    final userViewModel = Provider.of<UserViewModel>(context);

    final ScheduleViewModel scheduleViewModel =
    Provider.of<ScheduleViewModel>(context);

    return Consumer<ScheduleViewModel>(builder: (context, provider, child) {
      dayScheduleList = provider.dayScheduleList;
      dayScheduleList = provider.dayScheduleList;
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: 540 * screenWidth,
          height: 1200 * screenHeight,
          padding: EdgeInsets.only(top: 40 * screenHeight),
          decoration: BoxDecoration(color: Color(0xFFF2F2F2)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 540 * screenWidth,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      firstframe(),
                      SizedBox(height: 19 * screenHeight),
                      _yearmonthView(context),
                      SizedBox(height: 19 * screenHeight),
                      thirdframe(context),
                      SizedBox(height: 19 * screenHeight),
                      Container(
                          height: 700 * screenHeight,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30 * screenWidth),
                          child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: dayScheduleList.length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              width: 428 * screenWidth,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 11 * screenHeight),
                                              child: ElevatedButton(
                                                  onPressed: () async{
                                                    groupViewModel.updateShowAddButton(true);
                                                    provider.getSelectSchedule(
                                                        dayScheduleList[index].schedule);
                                                    await routineViewModel
                                                        .getScheduleRoutineList(
                                                            dayScheduleList[
                                                                    index].schedule
                                                                .id!);
                                                    await groupViewModel.getScheduleGroupList(dayScheduleList[index].schedule.id!,userViewModel.user!.userId! );
                                                    scheduleViewModel.isAlreaySchedule(true);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => ScheduleDetailsScreen()));
                                                  },
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty.all<
                                                            EdgeInsetsGeometry?>(
                                                      EdgeInsets.only(
                                                        top: 23 * screenHeight,
                                                        left: 16 * screenWidth,
                                                        right: 26 * screenWidth,
                                                        bottom:
                                                            23 * screenHeight,
                                                      ),
                                                    ),
                                                    elevation:
                                                        MaterialStateProperty
                                                            .all<double>(0),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(Color(
                                                                0xFF333333)),
                                                    shape: MaterialStateProperty
                                                        .all<OutlinedBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                            width: 240 *
                                                                screenWidth,
                                                            child: Column(
                                                                children: [
                                                                  Container(
                                                                    width: 240 *
                                                                        screenWidth,
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          width:
                                                                              35 * screenWidth,
                                                                          height:
                                                                              35 * screenHeight,
                                                                          child:
                                                                              SvgPicture.asset(
                                                                            'assets/icons/circlevector.svg',
                                                                            width:
                                                                                15 * screenWidth,
                                                                            height:
                                                                                15 * screenHeight,
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          width:
                                                                              205 * screenWidth,
                                                                          child:
                                                                              FittedBox(
                                                                            fit:
                                                                                BoxFit.contain,
                                                                            child:
                                                                                Text(
                                                                              dayScheduleList[index].schedule.title!,
                                                                              maxLines: 2,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(
                                                                                color: Color(0xFFF2F2F2),
                                                                                fontSize: 26 * screenHeight,
                                                                                fontFamily: 'Apple',
                                                                                fontWeight: FontWeight.w100,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 16 *
                                                                        screenHeight,
                                                                  ),
                                                                  Container(
                                                                    height: 29 *
                                                                        screenHeight,
                                                                    width: 240 *
                                                                        screenWidth,
                                                                    padding: EdgeInsets.only(
                                                                        left: 37 *
                                                                            screenWidth),
                                                                    child: Text(
                                                                      DateFormat(
                                                                              'h:mm a')
                                                                          .format(
                                                                              dayScheduleList[index].schedule.date!),
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xFFF2F2F2),
                                                                        fontSize:
                                                                            13.51 *
                                                                                screenHeight,
                                                                        fontFamily:
                                                                            'Apple',
                                                                        fontWeight:
                                                                            FontWeight.w100,
                                                                        height:
                                                                            0,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left, // 텍스트 정렬을 왼쪽으로 설정
                                                                    ),
                                                                  ),
                                                                ])),
                                                        Flexible(
                                                          child: Container(),
                                                          fit: FlexFit.loose,
                                                        ),
                                                        Container(
                                                            width: 15,
                                                            child: Container(
                                                              alignment: Alignment
                                                                  .bottomCenter,
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/icons/blackfrontbutton.svg',
                                                                width: 15 *
                                                                    screenWidth,
                                                                height: 15 *
                                                                    screenHeight,
                                                              ),
                                                            ))
                                                      ])),
                                            );
                                          }),
                                    ),
                                  ],
                                ))
                    ]),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget firstframe() {
    return Container(
      width: 114.17 * screenWidth,
      height: 27 * screenHeight,
      padding: EdgeInsets.symmetric(horizontal: 29 * screenWidth),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/Vector.png',
            height: 27 * screenHeight,
          )
        ],
      ),
    );
  }

  Widget _yearmonthView(context) {
    final calenderViewModel = Provider.of<CalendarViewModel>(context);
    return Container(
      width: 540 * screenWidth,
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

  Widget thirdframe(context) {
    final calenderViewModel = Provider.of<CalendarViewModel>(context);
    return Container(
      width: 540 * screenWidth,
      height: 145 * screenHeight,
      padding: EdgeInsets.symmetric(
          horizontal: 48 * screenWidth, vertical: 11 * screenHeight),
      decoration: BoxDecoration(color: Colors.black),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: calenderViewModel.onlysequentialDates.length,
                scrollDirection: Axis.horizontal,
                controller: calenderViewModel.scrollController,
                itemBuilder: (BuildContext context, int index) {
                  return Day_partition(
                      context, calenderViewModel.onlysequentialDates[index]);
                }),
          ),
        ],
      ),
    );
  }

  Widget Day_partition(BuildContext context, Calendar calendarDate) {
    final calenderViewModel = Provider.of<CalendarViewModel>(context);
    final ScheduleViewModel scheduleViewModel =
        Provider.of<ScheduleViewModel>(context);
    return Container(
      height: 123 * screenHeight,
      width: 56 * screenWidth,
      child: Column(
        children: [
          Container(
            width: 56 * screenWidth,
            height: 38 * screenHeight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${calenderViewModel.weeksDays[calendarDate.date.weekday - 1]}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFF2F2F2),
                    fontSize: 15 * screenHeight,
                    fontFamily: 'Apple',
                    fontWeight: FontWeight.w100,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8 * screenHeight,
          ),
          Container(
            width: 56 * screenWidth,
            height: 60 * screenHeight,
            child: ElevatedButton(
              onPressed: () {
                scheduleViewModel.getSelectScheduleList(calendarDate.date);
                calenderViewModel.updateView(calendarDate, screenWidth);
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: EdgeInsets.symmetric(
                    vertical: 1 * screenWidth, horizontal: 1 * screenHeight),
                backgroundColor:
                    calenderViewModel.selectedDateTime != calendarDate.date
                        ? Colors.black
                        : Color(0xFFFF4F4F),
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
                          color: Color(0xFFF5F5F5),
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
        ],
      ),
    );
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
