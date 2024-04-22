import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goinggoing_flutterapp/Routine/RoutineScreen.dart';
import 'package:intl/intl.dart';

import 'Routine.dart';

class RoutineEditModal extends StatefulWidget {
  final RoutineDetail routineDetail;

  RoutineEditModal({super.key, required this.routineDetail});

  @override
  _RoutineEditModalState createState() => _RoutineEditModalState();
}

class _RoutineEditModalState extends State<RoutineEditModal> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static double screenWidth = 0;
  static double screenHeight = 0;
  static Duration selectedDuration = Duration(minutes: 0);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static String _ScheduleName = '';
  late RoutineDetail _routinedetail;

  @override
  void initState() {
    super.initState();
    _routinedetail = widget.routineDetail;
    selectedDuration = Duration(seconds: _routinedetail.time);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width / 540;
    screenHeight = MediaQuery.of(context).size.height / 1200;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: FutureBuilder<void>(
        // 여기서 비동기 작업을 수행합니다.
        future: _delayedFuture(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 로딩 중이면 로딩 스피너를 표시합니다.
            return Container(
              width: 347 * screenWidth,
              height: 364 * screenHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
              ),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return putModal(context);
          }
        },
      ),
    );
  }


  static Future<void> _delayedFuture() async {
    await Future.delayed(Duration(seconds: 2));
  }
  Widget putModal(BuildContext context) {
    return Container(
      width: 347 * screenWidth,
      height: 571.52 * screenHeight,
      padding: EdgeInsets.symmetric(
          horizontal: 23 * screenWidth, vertical: 23 * screenHeight),
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
                    child: SvgPicture.asset(
                      'assets/icons/greyxbutton.svg',
                      width: 32 * screenWidth,
                      height: 32 * screenHeight,
                    )),
              ],
            ),
          ),
          SizedBox(height: 16 * screenHeight),
          Container(
            width: 301 * screenWidth,
            height: 109 * screenHeight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 28 * screenHeight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 57 * screenWidth,
                        height: 28 * screenHeight,
                        child: Text(
                          'EDIT',
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
                    ],
                  ),
                ),
                SizedBox(height: 9 * screenHeight),
                Container(
                  width: double.infinity,
                  height: 62 * screenHeight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            '미션 수정',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF1A1A1A),
                              fontSize: 20 * screenHeight,
                              fontFamily: 'Apple',
                              fontWeight: FontWeight.w100,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16 * screenHeight),
          Container(
            width: 87 * screenWidth,
            height: 20 * screenHeight,
            padding: EdgeInsets.symmetric(
                horizontal: 21 * screenWidth, vertical: 2 * screenHeight),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '미션 제목',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFF2F2F2),
                    fontSize: 12 * screenHeight,
                    fontFamily: 'Apple',
                    fontWeight: FontWeight.w100,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16 * screenHeight),
          Container(
            width: 283 * screenWidth,
            height: 76 * screenHeight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10 * min(screenWidth, screenHeight)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 223 * screenWidth,
                        height: 44 * screenHeight,
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            initialValue:_routinedetail.content,
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                color: Colors.red, // 에러 메시지의 글자 색상
                                fontSize: 15 * screenHeight, // 에러 메시지의 글자 크기
                                fontFamily: 'Apple', // 에러 메시지의 글꼴
                              ),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20 * screenHeight,
                              fontFamily: 'Apple',
                              fontWeight: FontWeight.w100,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "한 글자 이상 적어 주세요";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _ScheduleName = value!;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8 * screenHeight),
              ],
            ),
          ),
          SizedBox(
            height: 16 * screenHeight,
          ),
          Container(
            width: 87 * screenWidth,
            height: 20 * screenHeight,
            padding: EdgeInsets.symmetric(
                horizontal: 21 * screenWidth, vertical: 2 * screenHeight),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '목표 시간',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFF2F2F2),
                    fontSize: 12 * screenHeight,
                    fontFamily: 'Apple',
                    fontWeight: FontWeight.w100,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16 * screenHeight,
          ),
          Container(
            width: 208.89 * screenWidth,
            height: 107.52 * screenHeight,
            child: CupertinoTimerPicker(
              mode: CupertinoTimerPickerMode.ms,
              initialTimerDuration: Duration(seconds: _routinedetail.time),// 시, 분, 초 선택 모드
              minuteInterval: 1, // 분 간격
              secondInterval: 1, // 초 간격
              onTimerDurationChanged: (Duration duration) {
                selectedDuration = duration;
              },
            ),
          ),
          SizedBox(height: 16 * screenHeight),
          Container(
            width: 301 * screenWidth,
            height: 57 * screenHeight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10 * screenHeight),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(70),
                ),
                backgroundColor: Color(0xFFFF4F4F), // 배경색 설정
              ),
              onPressed: () {
                print(_ScheduleName);
                print(_formKey.currentState!.validate());
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  print(_ScheduleName);
                  int s = selectedDuration.inSeconds;
                  int time = s;
                  print(time);
                  Navigator.pop(
                      context, {'scheduleName': _ScheduleName, 'Second': time});
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 236 * screenWidth,
                    height: 37 * screenHeight,
                    child: Text(
                      '확인',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFF2F2F2),
                        fontSize: 18 * screenHeight,
                        fontFamily: 'Apple',
                        fontWeight: FontWeight.w100,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
