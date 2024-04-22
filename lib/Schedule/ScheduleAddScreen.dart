import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goinggoing_flutterapp/Routine/RoutineViewModel.dart';
import 'package:goinggoing_flutterapp/Schedule/ScheduleAddViewModel.dart';
import 'package:goinggoing_flutterapp/Schedule/ScheduleViewModel.dart';
import 'package:goinggoing_flutterapp/User/UserViewModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goinggoing_flutterapp/Calender/CustomCalenderController.dart';
import 'package:goinggoing_flutterapp/Schedule/ScheduleDetailScreen.dart';
import 'package:intl/intl.dart';

import '../Group/GroupViewModel.dart';

class ScheduleScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  static double screenWidth = 0;
  static double screenHeight = 0;
  late String result;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width / 540;
    screenHeight = MediaQuery.of(context).size.height / 1200;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            width: 540 * screenWidth,
            height: 1200 * screenHeight,
            decoration: BoxDecoration(color: Color(0xFFF2F2F2)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 540 * screenWidth,
                    height: 1103 * screenHeight,
                    padding: EdgeInsets.only(
                        top: 48 * screenHeight,
                        left: 25 * screenWidth,
                        right: 25 * screenWidth),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                xbutton(context),
                              ],
                            ),
                          ),
                          SizedBox(height: 29 * screenHeight),
                          firstframe(context),
                          SizedBox(height: 29 * screenHeight),
                          SvgPicture.asset('assets/icons/line.svg'),
                          SizedBox(height: 29 * screenHeight),
                        Mainframe(context)
                        ])),
                nextbutton(context),
                Flexible(
                  child: Container(),
                  fit: FlexFit.tight,
                ),
              ],
            )));
  }
  Widget xbutton(BuildContext context){
    final ScheduleAddViewModel scheduleAddViewModel =
    Provider.of<ScheduleAddViewModel>(context, listen: true);
    return Container(
        height: 49 * screenHeight,
        child: InkWell(
          onTap: () {
            scheduleAddViewModel.resetState();
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            'assets/icons/greybackbutton.svg',
            width: 35 * screenWidth,
            height: 35 * screenHeight,
          ),
        ));
  }
  Widget Mainframe(BuildContext context){
    final ScheduleAddViewModel scheduleAddViewModel =
    Provider.of<ScheduleAddViewModel>(context, listen: true);
    return Container(
      width: 490 * screenWidth,
      height: 870 * screenHeight,
      child: Stack(
        children: [
          addschedulebutton(
              scheduleAddViewModel.firstinitate,
              1,
              context),
          SizedBox(height: 29 * screenHeight),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            top: scheduleAddViewModel.isAnimatedfirst
                ? 240 * screenHeight
                : 133 * screenHeight,
            child: addschedulebutton(
                scheduleAddViewModel.secondinitate,
                2,
                context),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            top: scheduleAddViewModel.isAnimatedfirst
                ? 377 * screenHeight
                : 269 * screenHeight,
            child: addschedulebutton(
                scheduleAddViewModel.thirdinitate,
                3,
                context),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            top: scheduleAddViewModel.isAnimatedthird
                ? 700 * screenHeight
                : scheduleAddViewModel.isAnimatedfirst
                ? 542 * screenHeight
                : 406 * screenHeight,
            child: addschedulebutton(
                scheduleAddViewModel.fourthinitate,
                4,
                context),
          ),
          Visibility(
            visible: scheduleAddViewModel.isAnimatedfirst,
            child: AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              top: scheduleAddViewModel.isAnimatedfirst
                  ? 133 * screenHeight
                  : 0,
              child: inputBox(
                  _formKey1, '일정의 제목을 지어볼까요?', context),
            ),
          ),
          Visibility(
            visible: scheduleAddViewModel.isAnimatedthird,
            child: AnimatedPositioned(
              width: 490 * screenWidth,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              top: scheduleAddViewModel.isAnimatedthird
                  ? 406 * screenHeight
                  : 0,
              child: Container(
                width: 490 * screenWidth,
                height: 300 * screenHeight,
                // 예시로 300으로 설정
                child: BirthDatePicker(
                  onDateTimeChanged: (DateTime newDate) {
                    print(newDate);
                  },
                  initTimeStr: DateTime.now().toString(),
                  context: context,
                ),
              ),
            ),
          ),
          Visibility(
            visible:
            scheduleAddViewModel.isAnimatedfourth,
            child: AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              top: scheduleAddViewModel.isAnimatedfourth
                  ? 542 * screenHeight
                  : 0,
              child: inputBox(
                  _formKey2, '약속 장소는 어디인가요?', context),
            ),
          ),
        ],
      ),
    );
  }

  Widget firstframe(BuildContext context) {
    return Container(
      width: 490 * screenWidth,
      height: 39 * screenHeight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 31.60 * screenWidth,
            height: 35.69 * screenHeight,
            child: SvgPicture.asset(
              'assets/icons/greybag.svg',
              width: 31.60 * screenWidth,
              height: 35.69 * screenHeight,
            ),
          ),
          SizedBox(width: 4 * screenWidth),
          Expanded(
            child: Container(
              height: 39 * screenHeight,
              padding: EdgeInsets.only(left: 8 * screenWidth),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 435 * screenWidth,
                    height: 39 * screenHeight,
                    child: Align(
                      alignment: Alignment.centerLeft, // 왼쪽 정렬을 위한 설정
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          '새로운 일정을 추가할 수 있어요.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15 * screenHeight,
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
          ),
        ],
      ),
    );
  }

  Widget addschedulebutton(String text, int index, BuildContext context) {
    final ScheduleAddViewModel scheduleAddViewModel =
        Provider.of<ScheduleAddViewModel>(context, listen: true);
    return Container(
        width: 490 * screenWidth,
        height: 107 * screenHeight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: (scheduleAddViewModel.isfirstComplete &&
                          index == 1) ||
                      (scheduleAddViewModel.issecondComplete && index == 2) ||
                      (scheduleAddViewModel.isthirdComplete && index == 3) ||
                      (scheduleAddViewModel.isfourthComplete && index == 4)
                  ? Colors.black
                  : Color(0xFFE6E6E6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: 22 * screenWidth, vertical: 31 * screenHeight),
              minimumSize: (Size(490 * screenWidth, 107 * screenHeight))),
          onPressed: () async {
            if (index == 2) {
              result = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    backgroundColor: Colors.transparent, // 배경을 투명으로 설정
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 479 * screenWidth, // 원하는 최대 가로 크기 설정
                        maxHeight: 849 * screenHeight,
                      ),
                      child: MyApp(),
                    ),
                  );
                },
              );
            }
            if (index == 1) {
              scheduleAddViewModel.changeAnimatedthird(false);
              scheduleAddViewModel.changeAnimatedsecond(false);
              scheduleAddViewModel.changeAnimatedfourth(false);
              if (scheduleAddViewModel.isAnimatedfirst) {
                final formKeyState = _formKey1.currentState!;
                if (formKeyState.validate()) {
                  formKeyState.save();
                }
              }
              scheduleAddViewModel
                  .changeAnimatedfirst(!scheduleAddViewModel.isAnimatedfirst);
            }
            if (index == 2) {
              scheduleAddViewModel.changeAnimatedthird(false);
              scheduleAddViewModel.changeAnimatedfirst(false);
              scheduleAddViewModel.changeAnimatedfourth(false);
              if (result != null) {
                scheduleAddViewModel.changesecondinitate(result);
                scheduleAddViewModel.changesecondComplete(true);
              }
            }
            if (index == 3) {
              scheduleAddViewModel.changeAnimatedsecond(false);
              scheduleAddViewModel.changeAnimatedfirst(false);
              scheduleAddViewModel.changeAnimatedfourth(false);
              if (scheduleAddViewModel.isAnimatedthird) {
                scheduleAddViewModel.changethirdinitate(
                    DateFormat('a h:mm', 'ko_KR')
                        .format(scheduleAddViewModel.selectedTime));
                scheduleAddViewModel.changethirdComplete(true);
              }
              scheduleAddViewModel
                  .changeAnimatedthird(!scheduleAddViewModel.isAnimatedthird);
            }
            if (index == 4) {
              scheduleAddViewModel.changeAnimatedsecond(false);
              scheduleAddViewModel.changeAnimatedfirst(false);
              scheduleAddViewModel.changeAnimatedthird(false);
              if (scheduleAddViewModel.isAnimatedfourth) {
                final formKeyState = _formKey2.currentState!;
                if (formKeyState.validate()) {
                  formKeyState.save();
                }
              }
              scheduleAddViewModel
                  .changeAnimatedfourth(!scheduleAddViewModel.isAnimatedfourth);
            }
            if (scheduleAddViewModel.isfirstComplete &&
                scheduleAddViewModel.isfirstComplete &&
                scheduleAddViewModel.isfirstComplete &&
                scheduleAddViewModel.isfourthComplete) {
              scheduleAddViewModel.changeeverythingComplete(true);
            } else {
              scheduleAddViewModel.changeeverythingComplete(false);
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          padding: EdgeInsets.only(left: 8 * screenWidth),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 25 * screenHeight,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        text,
                                        style: TextStyle(
                                          color: (scheduleAddViewModel
                                                          .isfirstComplete &&
                                                      index == 1) ||
                                                  (scheduleAddViewModel
                                                          .issecondComplete &&
                                                      index == 2) ||
                                                  (scheduleAddViewModel
                                                          .isthirdComplete &&
                                                      index == 3) ||
                                                  (scheduleAddViewModel
                                                          .isfourthComplete &&
                                                      index == 4)
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 18,
                                          fontFamily: 'Apple',
                                          fontWeight: FontWeight.w100,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 269 * screenWidth),
                      Container(
                        width: 50 * screenWidth,
                        height: 45 * screenHeight,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 36.36 * screenWidth,
                              height: 36.34 * screenHeight,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SvgPicture.asset(
                                    (scheduleAddViewModel.isfirstComplete &&
                                                index == 1) ||
                                            (scheduleAddViewModel
                                                    .issecondComplete &&
                                                index == 2) ||
                                            (scheduleAddViewModel
                                                    .isthirdComplete &&
                                                index == 3) ||
                                            (scheduleAddViewModel
                                                    .isfourthComplete &&
                                                index == 4)
                                        ? 'assets/icons/completepoint.svg'
                                        : 'assets/icons/checkpoint.svg',
                                    width: 36.36 * screenWidth,
                                    height: 36.34 * screenHeight,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget nextbutton(context) {
    final ScheduleAddViewModel scheduleAddViewModel =
        Provider.of<ScheduleAddViewModel>(context, listen: true);
    GroupViewModel groupViewModel = Provider.of<GroupViewModel>(context);
    ScheduleViewModel scheduleViewModel =
        Provider.of<ScheduleViewModel>(context);
    RoutineViewModel routineViewModel =
    Provider.of<RoutineViewModel>(context);
    UserViewModel userViewModel =
    Provider.of<UserViewModel>(context);
    return Container(
      width: 540 * screenWidth,
      height: 97 * screenHeight,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        // decoration 추가
        color: scheduleAddViewModel.iseverythingComplete
            ? Color(0xFFFF4F4F)
            : Color(0xFFB3B3B3),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // 사각형 모양을 위해 BorderRadius.zero 사용
          ),
        ),
        onPressed: scheduleAddViewModel.iseverythingComplete
            ? () async {
                scheduleViewModel.getSelectSchedule(
                    await scheduleAddViewModel.postSchedule());
                routineViewModel
                    .resetScheduleRoutineList();
                await groupViewModel.getScheduleGroupList(scheduleViewModel.schedule!.id!,userViewModel.user!.userId!);
                groupViewModel.updateShowAddButton(true);
                scheduleViewModel.isAlreaySchedule(false);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScheduleDetailsScreen()),
                );
              }
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 109 * screenWidth,
              height: 42 * screenHeight,
              child: FittedBox(
                child: Text(
                  '다음',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 18,
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
    );
  }

  Widget inputBox(
      GlobalKey<FormState> globalkey, String text, BuildContext context) {
    final ScheduleAddViewModel scheduleAddViewModel =
        Provider.of<ScheduleAddViewModel>(context, listen: true);
    return Container(
      width: 490 * screenWidth,
      height: 116 * screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 31) * screenWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 30 * screenHeight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 235.34 * screenWidth,
                  height: 25.58 * screenHeight,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        text,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
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
          SizedBox(height: 18 * screenWidth),
          SizedBox(
            width: 428 * screenWidth,
            height: 28 * screenHeight,
            child: Form(
              key: globalkey,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return '1자 이상 입력해주세요.';
                  }
                },
                onSaved: (value) {
                  print(value);
                  if (globalkey.currentState!.validate()) {
                    if (globalkey == _formKey1) {
                      scheduleAddViewModel.changefirstinitate(value!);
                      scheduleAddViewModel.changefirstComplete(true);
                    }
                    if (globalkey == _formKey2) {
                      scheduleAddViewModel.changefourthinitate(value!);
                      scheduleAddViewModel.changefourthComplete(true);
                    }
                  }
                },
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0 * screenHeight,
                  // 변경하고자 하는 폰트 크기
                  fontFamily: 'Apple',
                  fontWeight: FontWeight.w100,
                  height: 0,
                ),
                decoration: InputDecoration(
                  hintText: '한강 데이트',
                  hintStyle: TextStyle(
                    color: Color(0xFFB3B3B3),
                    fontSize: 14.0 * screenHeight,
                    // 변경하고자 하는 폰트 크기
                    fontFamily: 'Apple',
                    fontWeight: FontWeight.w100,
                    height: 0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 18 * screenHeight),
        ],
      ),
    );
  }

  Widget BirthDatePicker(
      {required void Function(DateTime) onDateTimeChanged,
      required String initTimeStr,
      required BuildContext context}) {
    final ScheduleAddViewModel scheduleAddViewModel =
        Provider.of<ScheduleAddViewModel>(context, listen: true);
    DateTime initTime = DateTime.parse(initTimeStr);
    return SizedBox(
      height: 300 * screenHeight,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        initialDateTime: initTime,
        onDateTimeChanged: (DateTime newDateTime) {
          scheduleAddViewModel.changeselectedTime(newDateTime);
        },
        use24hFormat: false, // AM/PM 형식을 사용하도록 설정
      ),
    );
  }
}
