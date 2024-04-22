import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InitiateScheduleModal extends StatefulWidget {
  InitiateScheduleModal({super.key});

  @override
  _InitiateScheduleModalState createState() => _InitiateScheduleModalState();
}


class _InitiateScheduleModalState extends State<InitiateScheduleModal> {
  static double screenWidth = 0;
  static double screenHeight = 0;
  static bool selected = false;
  static Duration selectedDuration = Duration(minutes: 0);

  @override
  void initState() {
    super.initState();
    selected = false;
  }


  late Duration tempDuration;
  @override
  Widget build(BuildContext context) {

    screenWidth = MediaQuery.of(context).size.width / 540;
    screenHeight = MediaQuery.of(context).size.height / 1200;
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: Container(
        width: 292 * screenWidth,
        height: 467 *screenHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Color(0x2D000000),
              blurRadius: 6.30,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder<void>(
              // 여기서 비동기 작업을 수행합니다.
              future: _delayedFuture(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // 로딩 중이면 로딩 스피너를 표시합니다.
                  return Container(
                    width: 292 * screenWidth,
                    height: 467 * screenHeight,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  if (!selected) {
                    return firstModal(context);
                  } else {
                    return secondModal(context);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }



  // 예시로 2초간 대기하는 비동기 함수
  static Future<void> _delayedFuture() async {
    await Future.delayed(Duration(seconds: 2));
  }

  Widget firstModal(BuildContext context){
    return Container(
      width: 292*screenWidth,
      height: 467*screenHeight,
      padding:  EdgeInsets.symmetric(
          horizontal: 28*screenWidth, vertical: 32*screenHeight),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 226*screenWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 226*screenWidth,
                    height: 191*screenHeight,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Image.asset('assets/images/hifive.png',width: 226*screenWidth,
                      height: 191*screenHeight,)
                ),
                SizedBox(height: 11*screenHeight),
                Container(
                  width: 207*screenWidth,
                  child:FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      '새로운 일정을 생성했어요!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 20*screenHeight,
                        fontFamily: 'Apple',
                        fontWeight: FontWeight.w100,
                        height: 1.5,
                      ),
                    ),
                  )
                ),
                const SizedBox(height: 11),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 203*screenWidth,
                        height: 47*screenHeight,
                        child: Text(
                          '외출 준비 루틴을 만들면 시작 시간에 맞춰 타이머가 울릴거에요.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF1A1A1A),
                            fontSize: 13*screenHeight,
                            fontFamily: 'Apple',
                            fontWeight: FontWeight.w100,
                            height: 1.5,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24*screenHeight),
          SizedBox(
            width: 236*screenWidth,
            height: 37*screenHeight,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  selected = true;
                });
              },
              style: ElevatedButton.styleFrom(
                padding:  EdgeInsets.symmetric(vertical: 10*screenHeight),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(70),
                ),
                backgroundColor: Color(0xFFFF4F4F),
              ),
              child:FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  '확인',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFF2F2F2),
                    fontSize: 18*screenHeight,
                    fontFamily: 'Apple',
                    fontWeight: FontWeight.w100,
                    height: 0,
                  ),
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
  Widget secondModal(BuildContext context) {
    Duration tempDuration = selectedDuration;
    return Container(
      width: 308*screenWidth,
      height: 467*screenHeight,
      padding:  EdgeInsets.symmetric(horizontal: 36*screenWidth, vertical: 32*screenHeight),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 167*screenWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 85*screenHeight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 167*screenWidth,
                        height: 85*screenHeight,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(),
                        child: Stack(children: [
                          Image.asset('assets/images/car.png',width: 167*screenWidth,
                            height: 85*screenHeight,)
                            ]),
                      ),
                    ],
                  ),
                ),
                 SizedBox(height: 11*screenHeight),
                Container(
                  width: 167*screenWidth,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '약속 장소까지 가는데 얼마나 걸리나요?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF1A1A1A),
                          fontSize: 15*screenHeight,
                          fontFamily: 'Apple',
                          fontWeight: FontWeight.w100,
                          height: 1.5,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
           SizedBox(height: 35*screenHeight),
          Container(
            width: 300.89*screenWidth,
            height: 107.52*screenHeight,
            child: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.ms,
            initialTimerDuration: Duration(seconds: 0),// 시, 분, 초 선택 모드
            minuteInterval: 1, // 분 간격
            secondInterval: 1, // 초 간격
            onTimerDurationChanged: (Duration duration) {
              tempDuration = duration;
            },
          ),
            ),
           SizedBox(height: 35*screenHeight),
          Container(
            width: 236*screenWidth,
            height: 57*screenHeight,
            child:ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10 * screenHeight),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(70),
                ),
                backgroundColor: Color(0xFFFF4F4F), // 배경색 설정
              ),
              onPressed: () {
                selectedDuration=tempDuration;
                print(tempDuration);
                Navigator.pop(context,selectedDuration);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 216*screenWidth,
                    height: 37*screenHeight,
                    child:FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        '확인',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFF2F2F2),
                          fontSize: 18*screenHeight,
                          fontFamily: 'Apple',
                          fontWeight: FontWeight.w100,
                          height: 0,
                        ),
                      ),
                    )
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
