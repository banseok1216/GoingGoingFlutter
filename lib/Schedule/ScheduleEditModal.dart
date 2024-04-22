import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'Schedule.dart';

class ScheduleEditModal extends StatefulWidget {
  String caseName;
  String value;

  ScheduleEditModal({super.key, required this.caseName, required this.value});

  @override
  _ScheduleEditModalState createState() => _ScheduleEditModalState();
}

class _ScheduleEditModalState extends State<ScheduleEditModal> {
  final _formKey = GlobalKey<FormState>();
  static double screenWidth = 0;
  static double screenHeight = 0;
  static DateTime selectedDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  late String tempDateTime = "";
  late String _value;
  late String _caseName;

  @override
  Widget build(BuildContext context) {
    _value = widget.value;
    _caseName = widget.caseName;
    screenWidth = MediaQuery.of(context).size.width / 540;
    screenHeight = MediaQuery.of(context).size.height / 1200;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    switch (_caseName) {
      case "title":
        return TitleandLocationFrame(context, '일정 제목 수정');
      case "date":
        return DateTimeDurationFrame(context, '날짜 수정');
      case "time":
        return DateTimeDurationFrame(context, '시간 수정');
      case "location":
        return TitleandLocationFrame(context, '장소 수정');
      case "duration":
        return DateTimeDurationFrame(context, '이동 시간 수정');
      default:
        return Container();
    }
  }

  // 예시로 2초간 대기하는 비동기 함수
  static Future<void> _delayedFuture() async {
    await Future.delayed(Duration(seconds: 2));
  }

  Widget TitleandLocationFrame(BuildContext context, String text) {
    return Container(
      width: 347 * screenWidth,
      height: 320 * screenHeight,
      padding: EdgeInsets.only(
        top: 25 * screenHeight,
        left: 23 * screenWidth,
        right: 23 * screenWidth,
        bottom: 31 * screenHeight,
      ),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x2D000000),
            blurRadius: 6.30,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 32 * screenWidth,
                  height: 32 * screenHeight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            width: 32 * screenWidth,
                            height: 32 * screenHeight,
                            child: SvgPicture.asset(
                              'assets/icons/blackxbutton.svg',
                              width: 32 * screenWidth,
                              height: 32 * screenHeight,
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 22 * screenHeight),
          Container(
            width: double.infinity,
            height: 22 * screenHeight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: double.infinity,
                    child: Text(
                      'Edit',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 13 * screenHeight,
                        fontFamily: 'Apple',
                        fontWeight: FontWeight.w100,
                        height: 0.18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 301 * screenWidth,
            height: 35 * screenHeight,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF1A1A1A),
                fontSize: 20 * screenHeight,
                fontFamily: 'Apple',
                fontWeight: FontWeight.w100,
                height: 0.07,
              ),
            ),
          ),
          SizedBox(height: 22 * screenHeight),
          Container(
            width: 283 * screenWidth,
            height: 52 * screenHeight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.all(10 * min(screenWidth, screenHeight)),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      // Add border for input-like appearance
                      borderRadius: BorderRadius.circular(
                          8), // Adjust border radius as needed
                    ),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: _value, // Placeholder text
                          hintStyle: TextStyle(
                            color: Color(0xFF1A1A1A),
                            fontSize: 20 * screenHeight,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none, // Hide the default border
                        ),
                        style: TextStyle(
                          color: Color(0xFF1A1A1A),
                          fontSize: 20 * screenHeight,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                        onSaved: (result) {
                          if (result != null && result.isNotEmpty) {
                            setState(() {
                              _value = result;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey),
          SeletedBtn(context)
        ],
      ),
    );
  }

  Widget SeletedBtn(BuildContext context) {
    return Container(
        width: 301 * screenWidth,
        height: 47 * screenHeight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(70),
            ),
            backgroundColor: Color(0xFF1A1A1A),
            // You can customize other button properties here
          ),
          onPressed: () {
            if (_caseName == "date" ||
                _caseName == "duration" ||
                _caseName == "time") {
              _value = tempDateTime;
              print(_value);
              print(tempDateTime);
              Navigator.pop(context, _value);
            } else {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
              }
              print('입력값: $_value');
              Navigator.pop(context, _value);
            }
          },
          child: SizedBox(
            width: 236 * screenWidth,
            height: 37 * screenHeight,
            child: Text(
              '저장',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFF2F2F2),
                fontSize: 18 * screenHeight,
                fontFamily: 'AppleSDGothicNeoM00',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
        ));
  }

  Widget DateTimeDurationFrame(BuildContext context, String text) {
    return Container(
      width: 347 * screenWidth,
      height: 377.11 * screenHeight,
      padding: EdgeInsets.only(
        top: 25 * screenHeight,
        left: 23 * screenWidth,
        right: 23 * screenWidth,
        bottom: 31 * screenHeight,
      ),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x2D000000),
            blurRadius: 6.30,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 32 * screenWidth,
                    height: 32 * screenHeight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              width: 32 * screenWidth,
                              height: 32 * screenHeight,
                              child: SvgPicture.asset(
                                'assets/icons/blackxbutton.svg',
                                width: 32 * screenWidth,
                                height: 32 * screenHeight,
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 22 * screenHeight),
            Container(
              width: double.infinity,
              height: 22 * screenHeight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: double.infinity,
                      child: Text(
                        'Edit',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF1A1A1A),
                          fontSize: 13 * screenHeight,
                          fontFamily: 'Apple',
                          fontWeight: FontWeight.w100,
                          height: 0.18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 301 * screenWidth,
              height: 35 * screenHeight,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF1A1A1A),
                  fontSize: 20 * screenHeight,
                  fontFamily: 'Apple',
                  fontWeight: FontWeight.w100,
                  height: 0.07,
                ),
              ),
            ),
            SizedBox(height: 22 * screenHeight),
            SizedBox(
              child: _caseName == "date"
                  ? DateCupertino() // Replace with the widget for the "date" case
                  : (_caseName == "time"
                      ? TimeCupertino() // Replace with the widget for the "time" case
                      : DurationCupertino()), // Replace with the default case
            ),
            SizedBox(
              height: 10 * screenHeight,
            ),
            SeletedBtn(context),
          ]),
    );
  }

  Widget DurationCupertino() {
    RegExp regExp = RegExp(r'(\d+) 시간 (\d+)분 이동');
    RegExpMatch? match = regExp.firstMatch(_value);
    DateTime resultDateTime = DateTime.now();
    if (match != null) {
      // 추출한 시간과 분을 정수로 변환
      int hours = int.parse(match.group(1)!);
      int minutes = int.parse(match.group(2)!);

      // 현재 시간을 가져와서 시간과 분을 더한 DateTime 객체 생성
      DateTime now = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          0, // 시간을 0으로 설정
          0);
      resultDateTime = now.add(Duration(hours: hours, minutes: minutes));
    }
    return Container(
      width: 233.68 * screenWidth,
      height: 110.06 * screenHeight,
      child: CupertinoDatePicker(
          initialDateTime: _value == ''
              ? DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  0, // 시간을 0으로 설정
                  0, // 분을 0으로 설정
                )
              : resultDateTime,
          mode: CupertinoDatePickerMode.time,
          use24hFormat: true,
          onDateTimeChanged: (value) {
            tempDateTime = DateFormat('HH 시간 mm분 이동').format(value);
          }),
    );
  }

  Widget TimeCupertino() {
    final koreanTimeFormatter = DateFormat('a h시 mm분', 'ko_KR');
    return Container(
      width: 233.68 * screenWidth,
      height: 110.06 * screenHeight,
      child: CupertinoDatePicker(
        initialDateTime: koreanTimeFormatter.parse(_value), // 분을 0으로 설정
        mode: CupertinoDatePickerMode.time,
        use24hFormat: false,
        onDateTimeChanged: (value) {
          tempDateTime =
              koreanTimeFormatter.format(value); // 모달 내에서 시간 변경이 일어나면 임시 변수에 저장
        },
      ),
    );
  }

  Widget DateCupertino() {
    final koreanDateFormatter = DateFormat('yyyy년 M월 d일 E', 'ko_KR');
    DateTime now = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        0, // 시간을 0으로 설정
        0);
    return Container(
        height: 110.06 * screenHeight,
        child: CupertinoDatePicker(
          initialDateTime:
              DateTime.now().isAfter(koreanDateFormatter.parse(_value))
                  ? now
                  : koreanDateFormatter.parse(_value),
          mode: CupertinoDatePickerMode.date,
          use24hFormat: false,
          minimumDate: now,
          onDateTimeChanged: (value) {
            tempDateTime = koreanDateFormatter.format(value);
          },
        ));
  }
}
