import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goinggoing_flutterapp/Routine/RoutineViewModel.dart';
import 'package:goinggoing_flutterapp/User/UserViewModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../Group/GroupViewModel.dart';
import '../Group/ScheduleGroupWidget.dart';
import '../Group/TimerGroupWidget.dart';
import '../Schedule/ScheduleDetailScreen.dart';
import '../Schedule/ScheduleViewModel.dart';
import 'TimerViewModel.dart';

class TimerMainView extends StatelessWidget {
  double screenWidth = 0;
  double screenHeight = 0;

  @override
  Widget build(context) {
    screenWidth = MediaQuery.of(context).size.width / 540;
    screenHeight = MediaQuery.of(context).size.height / 1200;
    TimerViewModel timerViewModel = Provider.of<TimerViewModel>(context);

    return Scaffold(
      body: Container(
        width: 540 * screenWidth,
        height: 1103 * screenHeight,
        padding: EdgeInsets.only(
            top: 40 * screenHeight,
            left: 28 * screenWidth,
            right: 28 * screenWidth),
        child: Column(
          children: [
            HeadFrame(),
            SizedBox(
              height: 15 * screenHeight,
            ),
            SecondFrame(context, timerViewModel),
            SizedBox(
              height: 15 * screenHeight,
            ),
            ThirdFrame(context, timerViewModel),
            SizedBox(
              height: 15 * screenHeight,
            ),
            StartButton(context),
            SizedBox(
              height: 15 * screenHeight,
            ),
            TextBox(context),
          ],
        ),
      ),
    );
  }

  Widget TextBox(context) {
    TimerViewModel timerViewModel = Provider.of<TimerViewModel>(context);
    return Container(
      width: 484 * screenWidth,
      height: 136 * screenHeight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 26 * screenHeight,
            padding: EdgeInsets.only(left: 22 * screenWidth),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '루틴 시작까지',
                    style: TextStyle(
                      color: Color(0xFF4C4C4C),
                      fontSize: 15 * screenHeight,
                      fontFamily: 'Apple',
                      fontWeight: FontWeight.w100,
                      height: 0,
                    ),
                  ),
                ),
                SizedBox(width: 15 * screenWidth),
                Image.asset(
                  'assets/images/Vector.png',
                  height: 20 * screenHeight,
                )
              ],
            ),
          ),
          SizedBox(height: 9 * screenHeight),
          Container(
            padding: EdgeInsets.only(
                left: 25 * screenWidth, right: 10 * screenWidth),
            alignment: Alignment.centerLeft,
            child: Text(
              timerViewModel.remainingTime,
              style: TextStyle(
                color: Color(0xFF1A1A1A),
                fontSize: 40 * screenHeight,
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

  Widget ThirdFrame(context, TimerViewModel timerViewModel) {
    return Container(
      width: 505 * screenWidth,
      height: 515.83 * screenHeight,
      padding: EdgeInsets.symmetric(
          horizontal: 29 * screenWidth, vertical: 21 * screenHeight),
      decoration: ShapeDecoration(
        color: Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23),
        ),
      ),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40*screenWidth,
              padding: EdgeInsets.zero, // 또는 EdgeInsets.all(0)으로 설정 가능
              child: Divider(
                color: Colors.grey,
                thickness: 2, // 굵기 조정
                height: 2*screenHeight,
              ),
            ),
            Flexible(fit: FlexFit.tight,child: Container(),),
            Text(
              'Schedule Report',
              style: TextStyle(
                color: Color(0xFFF2F2F2),
                fontSize: 16 * screenHeight,
                fontFamily: 'Apple',
                fontWeight: FontWeight.w100,
                height: 0,
              ),
            ),
            Flexible(fit: FlexFit.tight,child: Container(),),
            buildScheduleInfo(
                1,
                context,
                timerViewModel
                    .formatScheduleDate(timerViewModel.nearestSchedule!.date!),
                'assets/icons/greyclock.svg'),
            Flexible(fit: FlexFit.tight,child: Container(),),
            buildScheduleInfo(
                2,
                context,
                timerViewModel.formatScheduleLocation(
                    timerViewModel.nearestSchedule!.location!),
                'assets/icons/greylocation.svg'),
            Flexible(fit: FlexFit.tight,child: Container(),),
            buildGroupScheduleInfo(3, context, 'assets/icons/greyrabbit.svg'),
            Flexible(fit: FlexFit.tight,child: Container(),),
            buildScheduleInfo(
                4, context, '루틴 보러 가기', 'assets/icons/greyschedule.svg'),
          ]),
    );
  }

  Widget buildGroupScheduleInfo(int index, context, String SvgPath) {
    return Container(
      width: 426 * screenWidth,
      height: 91 * screenHeight,
      padding: EdgeInsets.only(
        top: 11 * screenHeight,
        left: 22 * screenWidth,
        right: 11 * screenWidth,
        bottom: 11 * screenHeight,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Color(0xFF2B2B2B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 24 * screenWidth,
                height: 25 * screenHeight,
                child: rabbitIconWidget(context)),
            Container(
              width: 250 * screenWidth,
              child: TimerGroupWidget(),
            ),
            SizedBox(width: 10 * screenWidth),
            Container(
                child: Text(
              '와 함께 만나요.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17 * screenHeight,
                fontFamily: 'Apple',
                fontWeight: FontWeight.w100,
                height: 0,
              ),
            ))
          ]),
    );
  }

  Widget buildScheduleInfo(int index, context, String text, String SvgPath) {
    final ScheduleViewModel scheduleViewModel =
    Provider.of<ScheduleViewModel>(context);
    TimerViewModel timerViewModel = Provider.of<TimerViewModel>(context);
    RoutineViewModel routineViewModel = Provider.of<RoutineViewModel>(context);
    GroupViewModel groupViewModel = Provider.of<GroupViewModel>(context);
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);



    return Container(
      width: 426 * screenWidth,
      height: 91 * screenHeight,
      child: ElevatedButton(
        onPressed: index == 4
            ? () async{
          scheduleViewModel.getSelectSchedule(timerViewModel.nearestSchedule!);
          routineViewModel
              .getScheduleRoutineList(timerViewModel.nearestSchedule!.id!);
          await groupViewModel.getScheduleGroupList(timerViewModel.nearestSchedule!.id!,userViewModel.user!.userId!);
          scheduleViewModel.isAlreaySchedule(true);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ScheduleDetailsScreen()),
          );
              }
            : null,
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
            EdgeInsets.symmetric(
              vertical: 11 * screenHeight,
              horizontal: 22 * screenWidth,
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF2B2B2B)),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 24 * screenWidth,
                height: 25 * screenHeight,
                child: SvgPicture.asset(
                  SvgPath,
                  height: 25 * screenHeight,
                ),
              ),
              Container(
                width: 12 * screenWidth,
                height: 25 * screenHeight,
              ),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17 * screenHeight,
                  fontFamily: 'Apple',
                  fontWeight: FontWeight.w100,
                  height: 0,
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Container(),
              )
            ]), // 버튼에 표시될 텍스트를 추가하세요.
      ),
    );
  }

  Widget SecondFrame(context, TimerViewModel timerViewModel) {
    return Container(
      width: 484 * screenWidth,
      height: 160 * screenHeight,
      padding: EdgeInsets.all(14 * min(screenWidth, screenHeight)),
      decoration: ShapeDecoration(
        color: Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(21),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 243 * screenWidth,
            height: 67 * screenHeight,
            padding: EdgeInsets.all(10 * min(screenWidth, screenHeight)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 223 * screenWidth,
                  child: Text(
                    '${timerViewModel.nearestSchedule!.title}',
                    style: TextStyle(
                      color: Color(0xFFF2F2F2),
                      fontSize: 30 * screenHeight,
                      fontFamily: 'Apple',
                      fontWeight: FontWeight.w100,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 56 * screenWidth),
          Container(
            width: 157 * screenWidth,
            height: 132 * screenHeight,
            padding: EdgeInsets.symmetric(
                horizontal: 16 * screenWidth, vertical: 6 * screenHeight),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Color(0x720E0E0E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(19),
              ),
            ),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 137 * screenWidth,
                      height: 34 * screenHeight,
                      child: Row(children: [
                        Container(
                            width: 21 * screenWidth,
                            height: 24 * screenHeight,
                            child: SvgPicture.asset(
                                'assets/icons/blackwhiteflag.svg')),
                        Container(
                          width: 11*screenWidth,
                        ),
                        Container(
                          child: Text(
                            textAlign: TextAlign.center,
                            'Total',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20 * screenHeight,
                              fontFamily: 'Apple',
                              fontWeight: FontWeight.w100,
                              height: 0,
                            ),
                          ),
                        ),
                      ])),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(),
                  ),
                  Container(
                    width: 137 * screenWidth,
                    height: 34 * screenHeight,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 5 * screenWidth),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              if (timerViewModel.getTotalTime().inSeconds ~/
                                      3600 !=
                                  0)
                                TextSpan(
                                  text: (timerViewModel
                                              .getTotalTime()
                                              .inSeconds ~/
                                          3600)
                                      .toString(),
                                  style: TextStyle(
                                    color: Color(0xFFF2F2F2),
                                    fontSize: 30 * screenHeight,
                                    fontFamily: 'Apple',
                                    fontWeight: FontWeight.w100,
                                    height: 0,
                                  ),
                                ),
                              if (timerViewModel.getTotalTime().inSeconds ~/
                                      3600 !=
                                  0)
                                TextSpan(
                                  text: 'h',
                                  style: TextStyle(
                                    color: Color(0xFFF2F2F2),
                                    fontSize: 15 * screenHeight,
                                    fontFamily: 'Apple',
                                    fontWeight: FontWeight.w100,
                                    height: 0,
                                  ),
                                ),
                              if (timerViewModel.getTotalTime().inSeconds %
                                      3600 ~/
                                      60 !=
                                  0)
                                TextSpan(
                                  text:
                                      (timerViewModel.getTotalTime().inSeconds %
                                              3600 ~/
                                              60)
                                          .toString(),
                                  style: TextStyle(
                                    color: Color(0xFFF2F2F2),
                                    fontSize: 30 * screenHeight,
                                    fontFamily: 'Apple',
                                    fontWeight: FontWeight.w100,
                                    height: 0,
                                  ),
                                ),
                              if (timerViewModel.getTotalTime().inSeconds %
                                      3600 ~/
                                      60 !=
                                  0)
                                TextSpan(
                                  text: 'm',
                                  style: TextStyle(
                                    color: Color(0xFFF2F2F2),
                                    fontSize: 15 * screenHeight,
                                    fontFamily: 'Apple',
                                    fontWeight: FontWeight.w100,
                                    height: 0,
                                  ),
                                ),
                              if (timerViewModel.getTotalTime().inSeconds %
                                          60 !=
                                      0 ||
                                  timerViewModel.getTotalTime().inSeconds == 0)
                                TextSpan(
                                  text:
                                      (timerViewModel.getTotalTime().inSeconds %
                                              60)
                                          .toString(),
                                  style: TextStyle(
                                    color: Color(0xFFF2F2F2),
                                    fontSize: 30 * screenHeight,
                                    fontFamily: 'Apple',
                                    fontWeight: FontWeight.w100,
                                    height: 0,
                                  ),
                                ),
                              if (timerViewModel.getTotalTime().inSeconds %
                                          60 !=
                                      0 ||
                                  timerViewModel.getTotalTime().inSeconds == 0)
                                TextSpan(
                                  text: 's',
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
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                ]),
          ),
        ],
      ),
    );
  }

  Widget HeadFrame() {
    return Row(
      children: [
        Container(
          width: 55 * screenWidth,
          height: 49 * screenHeight,
          padding: EdgeInsets.all(10 * min(screenWidth, screenHeight)),
        ),
        Flexible(
          child: Container(),
          fit: FlexFit.loose,
        ),
        SizedBox(
          width: 216 * screenWidth,
          height: 48 * screenHeight,
          child: Text(
            '타이머',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20 * screenHeight,
              fontFamily: 'Apple',
              fontWeight: FontWeight.w100,
              height: 0,
            ),
          ),
        ),
        Flexible(
          child: Container(),
          fit: FlexFit.loose,
        ),
        Container(
          width: 55 * screenWidth,
          height: 49 * screenHeight,
          padding: EdgeInsets.all(10 * min(screenWidth, screenHeight)),
        ),
      ],
    );
  }

  Widget rabbitIconWidget(context) {
    GroupViewModel groupViewModel = Provider.of<GroupViewModel>(context);
    return Container(
      width: 23.40 * screenWidth,
      height: 22.47 * screenHeight,
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 23.40 * screenWidth,
              height: 22.47 * screenHeight,
              child: Stack(
                children: [
                  SvgPicture.asset(
                    'assets/icons/greyrabbit.svg',
                  ),
                  Positioned(
                    // 조절하고 싶은 위치로 설정
                    left: 10.2 * screenWidth, // 조절하고 싶은 위치로 설정
                    child: Container(
                      width: 14 * screenWidth,
                      height: 14 * screenHeight,
                      decoration: ShapeDecoration(
                        color: Color(0xFFFF4F4F),
                        shape: CircleBorder(), // 모양을 조절할 수 있음
                      ),
                      child: Center(
                        child: Text(
                          '${groupViewModel.timerGroupList.length}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8 * screenHeight,
                            fontFamily: 'Apple',
                            fontWeight: FontWeight.w100,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }

  Widget StartButton(BuildContext context) {
    TimerViewModel timerViewModel = Provider.of<TimerViewModel>(context);

    return GestureDetector(
      onTap: () {
        timerViewModel.startTimerRunning();
      },
      child: Container(
          width: 484 * screenWidth,
          height: 97 * screenHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Rectangle33.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 30 * screenWidth,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '지금 바로 시작하기',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17 * screenHeight,
                    fontFamily: 'Apple',
                    fontWeight: FontWeight.w100,
                    height: 0,
                  ),
                ),
              )
            ],
          )),
    );
  }
}
