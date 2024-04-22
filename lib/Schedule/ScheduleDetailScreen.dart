import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goinggoing_flutterapp/Group/GroupViewModel.dart';
import 'package:goinggoing_flutterapp/Group/ScheduleGroupWidget.dart';
import 'package:goinggoing_flutterapp/Routine/Routine.dart';
import 'package:goinggoing_flutterapp/Routine/RoutineViewModel.dart';
import 'package:goinggoing_flutterapp/Schedule/IntitateScheduleDetailModal.dart';
import 'package:goinggoing_flutterapp/Schedule/RoutineInScheduleModal.dart';
import 'package:goinggoing_flutterapp/Schedule/ScheduleEditModal.dart';
import 'package:goinggoing_flutterapp/Timer/TimerViewModel.dart';
import 'package:goinggoing_flutterapp/User/UserViewModel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Routine/RoutineScreen.dart';
import 'ScheduleViewModel.dart';

class ScheduleDetailsScreen extends StatelessWidget {
  static double screenWidth = 0;
  static double screenHeight = 0;

  @override
  Widget build(BuildContext context) {
    final ScheduleViewModel scheduleViewModel =
        Provider.of<ScheduleViewModel>(context, listen: false);
    final RoutineViewModel routineViewModel =
    Provider.of<RoutineViewModel>(context, listen: false);
    if (!scheduleViewModel.isAlready) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        scheduleViewModel.isAlreaySchedule(true);
        final result = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return InitiateScheduleModal();
          },
        );
        print(result);
        if (result is Duration) {
          scheduleViewModel.updatePersonalSchedule(result,routineViewModel.getScheduleRoutineTotalTime());
          print(scheduleViewModel.personalSchedule!.duration!);
        }
      });
    }
    screenWidth = MediaQuery.of(context).size.width / 540;
    screenHeight = MediaQuery.of(context).size.height / 1200;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: 540 * screenWidth,
          height: 1200 * screenHeight,
          padding: EdgeInsets.only(
              top: 48 * screenHeight,
              left: 28 * screenWidth,
              right: 28 * screenWidth),
          decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                firstframe(context),
                SizedBox(height: 15 * screenHeight),
                secondframe(context),
                SizedBox(height: 15 * screenHeight),
                Container(
                  width: 484 * screenWidth,
                  height: 27 * screenHeight,
                  padding: EdgeInsets.only(left: 33 * screenWidth),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 27 * screenHeight,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'My Routine',
                            style: TextStyle(
                              color: const Color(0xFF1A1A1A),
                              fontSize: 14 * screenHeight,
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
                SizedBox(height: 15 * screenHeight),
                thirdframe(context),
                SizedBox(height: 15 * screenHeight),
                _RoutineTimeBtn(context),
                Flexible(
                  child: Container(),
                  fit: FlexFit.tight,
                ),
              ]),
        ));
  }

  Widget firstframe(context) {
    final ScheduleViewModel scheduleViewModel =
        Provider.of<ScheduleViewModel>(context);
    final TimerViewModel timerViewModel =
    Provider.of<TimerViewModel>(context);
    final UserViewModel userViewModel =
    Provider.of<UserViewModel>(context);
    final GroupViewModel groupViewModel =
    Provider.of<GroupViewModel>(context);
    return SizedBox(
        width: 484 * screenWidth,
        height: 49 * screenHeight,
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 49 * screenHeight,
                  child: InkWell(
                    onTap: () async{
                       scheduleViewModel.makePutFalse();
                      await scheduleViewModel.getScheduleList();
                      await timerViewModel.getNearScheduleList(scheduleViewModel.scheduleList);
                       if(timerViewModel.nearestSchedule.id != null) {
                         await groupViewModel.getTimerGroupList(
                             timerViewModel.nearestSchedule.id!,
                             userViewModel.user!.userId!);
                       }
                      Navigator.pop(context);
                      if (timerViewModel.nearestSchedule != null) {
                        if (timerViewModel.nearestSchedule!.id != null) {
                          timerViewModel.getScheduleRoutineList();
                        }
                      }
                    },
                    child: SvgPicture.asset(
                      'assets/icons/greybackbutton.svg',
                      width: 35 * screenWidth,
                      height: 35 * screenHeight,
                    ),
                  )),
              Flexible(
                child: Container(),
                fit: FlexFit.loose,
              ),
              Container(
                height: 49 * screenHeight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: scheduleViewModel.isPutRunning && userViewModel.user!.userId! == groupViewModel.selectedMember
                          ? null
                          : () {
                              scheduleViewModel.statePutRunning();
                            },
                      child: Container(
                        width: 37 * screenWidth,
                        height: 37 * screenHeight,
                        child: Visibility(
                          visible: !scheduleViewModel.isPutRunning && userViewModel.user!.userId! == groupViewModel.selectedMember,
                          child: SvgPicture.asset(
                            'assets/icons/puticon.svg',
                            width: 26.45 * screenWidth,
                            height: 27.07 * screenHeight,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]));
  }

  Widget secondframe(BuildContext context) {
    final ScheduleViewModel scheduleViewModel =
        Provider.of<ScheduleViewModel>(context);
    return Container(
      width: 484 * screenWidth,
      height: 384 * screenHeight,
      padding: EdgeInsets.symmetric(
          horizontal: 28 * screenWidth, vertical: 22 * screenHeight),
      decoration: ShapeDecoration(
        color: const Color(0xFF1A1A1A),
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
              width: 428 * screenWidth,
              height: 69 * screenHeight,
              padding: EdgeInsets.all(10 * min(screenWidth, screenHeight)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Text(
                      scheduleViewModel.schedule!.title!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 37.31 * screenHeight,
                        fontFamily: 'Apple',
                        fontWeight: FontWeight.w100,
                        height: 0,
                      ),
                    ),
                  ),
                  SizedBox(width: 10 * screenWidth),
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: scheduleViewModel.isPutRunning
                              ? () async {
                                  final result = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ScheduleEditModal(
                                        caseName: "title",
                                        value:
                                            scheduleViewModel.schedule!.title!,
                                      );
                                    },
                                  );
                                  scheduleViewModel.updateScheduleTitle(result);
                                  // Handle button press, add your logic here
                                }
                              : null,
                          child: Visibility(
                            visible: scheduleViewModel.isPutRunning,
                            //true이면 나타냅니다.
                            child: SvgPicture.asset(
                              'assets/icons/redpen.svg', // SVG 파일 경로
                              width: 28.05 * screenWidth,
                              height: 27.71 * screenHeight,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 11 * screenHeight),
            Container(
              width: 428 * screenWidth,
              height: 28 * screenHeight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _editInfBtn(
                      "date",
                      DateFormat('yyyy년 M월 d일 E', 'ko_KR')
                          .format(scheduleViewModel.schedule!.date!),
                      context),
                  SizedBox(width: 6 * screenWidth),
                  _editInfBtn(
                      "time",
                      DateFormat('a h시 mm분', 'ko_KR')
                          .format(scheduleViewModel.schedule!.date!),
                      context),
                ],
              ),
            ),
            SizedBox(height: 8 * screenHeight),
            _editInfBtn(
                "location", scheduleViewModel.schedule!.location!, context),
            SizedBox(height: 8 * screenHeight),
            (scheduleViewModel.personalSchedule!.duration != null)
                ? _editInfBtn(
                    "duration",
                    '${scheduleViewModel.personalSchedule!.duration! ~/ 60}시간 ${scheduleViewModel.personalSchedule!.duration! % 60}분',
                    context,
                  )
                : _editInfBtn("duration", '', context),
            SizedBox(height: 4 * screenHeight),
            Divider(
              color: Colors.grey,
            ),
            SizedBox(height: 4 * screenHeight),
            Container(
              width: 428 * screenWidth,
              height: 36 * screenHeight,
              padding: EdgeInsets.all(10 * min(screenWidth, screenHeight)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Party',
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
            ScheduleGroupWidget(),
          ]),
    );
  }

  Widget thirdframe(BuildContext context) {
    final ScheduleViewModel scheduleViewModel =
        Provider.of<ScheduleViewModel>(context);
    final RoutineViewModel routineViewModel =
        Provider.of<RoutineViewModel>(context);
    final UserViewModel userViewModel =
    Provider.of<UserViewModel>(context);
    GroupViewModel groupViewModel = Provider.of<GroupViewModel>(context);

    return Container(
        height: 485 * screenHeight,
        child: ReorderableListView.builder(
          buildDefaultDragHandles: false,
          onReorder: (oldIndex, newIndex) {
            if (scheduleViewModel.isPutRunning) {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }
              routineViewModel.moveScheduleRoutineList(oldIndex, newIndex);
            }
          },
          proxyDecorator: (widget, animation, proxy) {
            return Material(
              child: widget,
              color: Colors.transparent,
            );
          },
          itemCount: scheduleViewModel.isPutRunning || userViewModel.user!.userId! != groupViewModel.selectedMember
              ? routineViewModel.scheduleRoutineList.length
              : routineViewModel.scheduleRoutineList.length + 1,
          itemBuilder: (context, index) {
            if (index < routineViewModel.scheduleRoutineList.length) {
              return ReorderableDragStartListener(
                enabled: scheduleViewModel.isPutRunning,
                key: ValueKey(index),
                index: index,
                child: _RoutineBtn(index, context),
              );
            } else if (!scheduleViewModel.isPutRunning && userViewModel.user!.userId! == groupViewModel.selectedMember) {
              return _addRoutineBtn(context, ValueKey(ObjectKey("add")));
            }
            return Container();
          },
        ));
  }

  Widget _editInfBtn(String key, String text, context) {
    final ScheduleViewModel scheduleViewModel =
        Provider.of<ScheduleViewModel>(context);
    return Container(
        height: 28 * screenHeight,
        width: 150* screenWidth,
        child: ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(
                  horizontal: 13 * screenWidth, vertical: 6 * screenHeight),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
                scheduleViewModel.isPutRunning
                    ? const Color(0xFFFF4F4F)
                    : const Color(0xFF4D4D4D)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          onPressed: scheduleViewModel.isPutRunning
              ? () async {
                  final result = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ScheduleEditModal(
                        caseName: key,
                        value: text,
                      );
                    },
                  );
                  if (key == 'duration') {
                    scheduleViewModel.updateScheduleDuration(result);
                  }
                  if (key == "location") {
                    scheduleViewModel.updateScheduleLocation(result);
                  }
                  if (key == "time") {
                    scheduleViewModel.updateScheduleTime(result);
                  }
                  if (key == "date") {
                    scheduleViewModel.updateScheduleDate(result);
                  }
                  if (key == "title") {
                    scheduleViewModel.updateScheduleTitle(result);
                  }
                }
              : null,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFFF2F2F2),
              fontSize: 15 * screenHeight,
              fontFamily: 'Apple',
              fontWeight: FontWeight.w100,
              height: 0,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ));
  }

  Widget _addRoutineBtn(BuildContext context, ValueKey<ObjectKey> valueKey) {
    final ScheduleViewModel scheduleViewModel =
        Provider.of<ScheduleViewModel>(context);
    final RoutineViewModel routineViewModel =
        Provider.of<RoutineViewModel>(context);
    return Column(
      key: valueKey,
      children: [
        SizedBox(height: 15 * screenHeight),
        SizedBox(
          height: 114.35 * screenHeight,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              final result = await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return RoutineScheduleModal(
                    second: false,
                  );
                },
              );
              print(result);
              if (result != null) {
                if (result == 1) {
                  routineViewModel.getRoutineList();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RoutineScreen(),
                    ),
                  );
                } else {
                  print(result['scheduleName']);
                  await routineViewModel.addScheduleRoutineList(ScheduleRoutine(
                      content: result['scheduleName'],
                      time: result['Second'],
                      scheduleId: null,
                      index: routineViewModel.routineList.length),scheduleViewModel.personalSchedule.id!);
                  scheduleViewModel.updatePersonalSchedule(Duration(
                      seconds: scheduleViewModel.personalSchedule.duration),
                      await routineViewModel.getScheduleRoutineTotalTime());
                                  }
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 22.35 * screenWidth,
                  height: 22.35 * screenHeight,
                  child:
                      SvgPicture.asset('assets/icons/add_Routine_Button.svg'),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _RoutineBtn(int index, context) {
    final ScheduleViewModel scheduleViewModel =
        Provider.of<ScheduleViewModel>(context);
    final RoutineViewModel routineViewModel =
        Provider.of<RoutineViewModel>(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7 * screenHeight),
      width: double.infinity,
      child: Container(
        child: Row(
          children: [
            AnimatedContainer(
                width: scheduleViewModel.isPutRunning ? 64 * screenWidth : 0,
                duration: Duration(milliseconds: 1000),
                child: Visibility(
                  visible: scheduleViewModel.isPutRunning,
                  child: InkWell(
                    onTap: () {
                      print(routineViewModel.scheduleRoutineList.length);
                      routineViewModel.removeScheduleRoutineList(index);
                    },
                    child: Container(
                        width: 40 * screenWidth,
                        height: 40 * screenHeight,
                        child: SvgPicture.asset(
                          'assets/icons/redxbutton.svg',
                        )),
                  ),
                )),
            AnimatedContainer(
              width: scheduleViewModel.isPutRunning
                  ? 420 * screenWidth
                  : 484 * screenWidth,
              duration: Duration(milliseconds: 1000),
              child: ElevatedButton(
                onPressed: () {
                  // Handle button press, you can add your logic here
                  print('Button pressed for index $index');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF404040)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(
                      horizontal: 20 * screenWidth,
                      vertical: 13 * screenHeight,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 150 * screenWidth,
                      height: 72 * screenHeight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: (routineViewModel
                                              .scheduleRoutineList[index]
                                              .time ~/
                                          60)
                                      .toString(),
                                  style: TextStyle(
                                    color: const Color(0xFFF2F2F2),
                                    fontSize: 30 * screenHeight,
                                    fontFamily: 'Apple',
                                    fontWeight: FontWeight.w100,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: 'm',
                                  style: TextStyle(
                                    color: const Color(0xFFF2F2F2),
                                    fontSize: 15 * screenHeight,
                                    fontFamily: 'Apple',
                                    fontWeight: FontWeight.w100,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: (routineViewModel
                                              .scheduleRoutineList[index].time %
                                          60)
                                      .toString(),
                                  style: TextStyle(
                                    color: const Color(0xFFF2F2F2),
                                    fontSize: 30 * screenHeight,
                                    fontFamily: 'Apple',
                                    fontWeight: FontWeight.w100,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: 's',
                                  style: TextStyle(
                                    color: const Color(0xFFF2F2F2),
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
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Container(),
                    ),
                    Container(
                      width: 230 * screenWidth,
                      padding:
                          EdgeInsets.symmetric(vertical: 10 * screenHeight),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                textAlign: TextAlign.center,
                                routineViewModel
                                    .scheduleRoutineList[index].content,
                                style: TextStyle(
                                  color: const Color(0xFFF2F2F2),
                                  fontSize: 20.68 * screenHeight,
                                  fontFamily: 'Apple',
                                  fontWeight: FontWeight.w100,
                                  height: 1.5, // 줄 간격 조절
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _RoutineTimeBtn(context) {
    final ScheduleViewModel scheduleViewModel =
        Provider.of<ScheduleViewModel>(context);
    final RoutineViewModel routineViewModel =
        Provider.of<RoutineViewModel>(context);
        // timerViewModel 사용
        return Container(
            width: 476 * screenWidth,
            height: 137 * screenHeight,
            child: ElevatedButton(
              onPressed: scheduleViewModel.isPutRunning
                  ? () async{
                await scheduleViewModel.updateSchedule();
                bool updateScheduleRoutine = await routineViewModel.updateScheduleRoutine(scheduleViewModel.personalSchedule.id!);
                      scheduleViewModel.statePutRunning();
                scheduleViewModel.updatePersonalSchedule(Duration(seconds: scheduleViewModel.personalSchedule.duration!),routineViewModel.getScheduleRoutineTotalTime());
              }
                  : null,
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  EdgeInsets.only(
                    top: 23 * screenHeight,
                    left: 55 * screenWidth,
                    right: 55 * screenWidth,
                    bottom: 23 * screenHeight,
                  ),
                ),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return scheduleViewModel.isPutRunning
                        ? const Color(0xFFFF4F4F)
                        : routineViewModel.scheduleRoutineList.isEmpty || scheduleViewModel.personalSchedule.scheduleDone
                            ? const Color(0xFF4D4D4D)
                            : Colors.white;
                  },
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(143),
                  ),
                ),
                shadowColor: MaterialStateProperty.all(
                  const Color(0x3F000000),
                ),
                elevation: MaterialStateProperty.all(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  scheduleViewModel.isPutRunning
                      ? putrunnig(context)
                      : routineViewModel.scheduleRoutineList.isEmpty || scheduleViewModel.personalSchedule.scheduleDone
                          ? noneroutine(context)
                          : hasroutine(context)
                ],
              ),
            )
    );
  }

  Widget putrunnig(context) {
    return SizedBox(
      child: Text(
        '저장',
        style: TextStyle(
          color: const Color(0xFFF2F2F2),
          fontSize: 20 * screenHeight,
          fontFamily: 'Apple',
          fontWeight: FontWeight.w100,
          height: 1.5,
        ),
        textAlign: TextAlign.center,
        softWrap: true,
      ),
    );
  }

  Widget noneroutine(context) {
    final ScheduleViewModel scheduleViewModel =
    Provider.of<ScheduleViewModel>(context);
    return Container(
        width: 262 * screenWidth,
          child: Text(
            scheduleViewModel.personalSchedule.scheduleDone?'미션이 종료 되었어요':'미션을 추가해서 나만의 외출 루틴을 만들어볼까요?',
            style: TextStyle(
              color: const Color(0xFFF2F2F2),
              fontSize: 21 * screenHeight,
              fontFamily: 'Apple',
              fontWeight: FontWeight.w100,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
            softWrap: true,
            maxLines: 2,
          ),
        );
  }

  Widget hasroutine(BuildContext context) {
    final ScheduleViewModel scheduleViewModel =
        Provider.of<ScheduleViewModel>(context);
    final RoutineViewModel routineViewModel =
        Provider.of<RoutineViewModel>(context);
    late int totaltime = routineViewModel.getScheduleRoutineTotalTime();
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            child: Row(
          children: [
            SvgPicture.asset('assets/icons/whiteblackflag.svg'),
            SizedBox(
              width: 37 * screenWidth,
            ),
            Container(
              alignment: Alignment.center,
              width: 91 * screenWidth,
              height: 40 * screenHeight,
              child: FittedBox(
                child: Text(
                  textAlign: TextAlign.center,
                  '목표 완료 시간',
                  style: TextStyle(
                    color: const Color(0xFF404040),
                    fontSize: 14 * screenHeight,
                    fontFamily: 'Apple',
                    fontWeight: FontWeight.w100,
                    height: 0.15,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 37 * screenWidth,
            ),
            Text.rich(
              TextSpan(
                children: [
                  if (totaltime ~/ 3600 != 0)
                    TextSpan(
                      text: (totaltime ~/ 3600).toString(),
                      style: TextStyle(
                        color: const Color(0xFF404040),
                        fontSize: 25 * screenHeight,
                        fontFamily: 'Apple',
                        fontWeight: FontWeight.w100,
                        height: 0,
                      ),
                    ),
                  if (totaltime ~/ 3600 != 0)
                    TextSpan(
                      text: 'h',
                      style: TextStyle(
                        color: const Color(0xFF404040),
                        fontSize: 15 * screenHeight,
                        fontFamily: 'Apple',
                        fontWeight: FontWeight.w100,
                        height: 0,
                      ),
                    ),
                  if (totaltime % 3600 ~/ 60 != 0)
                    TextSpan(
                      text: (totaltime % 3600 ~/ 60).toString(),
                      style: TextStyle(
                        color: const Color(0xFF404040),
                        fontSize: 25 * screenHeight,
                        fontFamily: 'Apple',
                        fontWeight: FontWeight.w100,
                        height: 0,
                      ),
                    ),
                  if (totaltime % 3600 ~/ 60 != 0)
                    TextSpan(
                      text: 'm',
                      style: TextStyle(
                        color: const Color(0xFF404040),
                        fontSize: 15 * screenHeight,
                        fontFamily: 'Apple',
                        fontWeight: FontWeight.w100,
                        height: 0,
                      ),
                    ),
                  if (totaltime % 60 != 0 || totaltime == 0)
                    TextSpan(
                      text: (totaltime % 60).toString(),
                      style: TextStyle(
                        color: const Color(0xFF404040),
                        fontSize: 25 * screenHeight,
                        fontFamily: 'Apple',
                        fontWeight: FontWeight.w100,
                        height: 0,
                      ),
                    ),
                  if (totaltime % 60 != 0 || totaltime == 0)
                    TextSpan(
                      text: 's',
                      style: TextStyle(
                        color: const Color(0xFF404040),
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
        )),
        Container(
            child: Row(
          children: [
            SvgPicture.asset('assets/icons/blacktimer.svg'),
            SizedBox(
              width: 37 * screenWidth,
            ),
            Container(
              alignment: Alignment.center,
              width: 91 * screenWidth,
              height: 40 * screenHeight,
              child: FittedBox(
                child: Text(
                  textAlign: TextAlign.center,
                  '루틴 시작 시간',
                  style: TextStyle(
                    color: const Color(0xFF404040),
                    fontSize: 14 * screenHeight,
                    fontFamily: 'Apple',
                    fontWeight: FontWeight.w100,
                    height: 0.15,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 37 * screenWidth,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                scheduleViewModel.personalSchedule.duration != null ?
                DateFormat('a h : mm').format(
                    scheduleViewModel.schedule!.date!
                        .subtract(Duration(seconds: totaltime)).subtract(
                        Duration(
                            seconds: scheduleViewModel.personalSchedule!
                                .duration! * 60))) :
                DateFormat('a h : mm')
                    .format(scheduleViewModel.schedule!.date!
                    .subtract(Duration(seconds: totaltime))),
                style: TextStyle(
                  color: const Color(0xFF404040),
                  fontSize: 25.74 * screenHeight,
                  fontFamily: 'Apple',
                  fontWeight: FontWeight.w100,
                  height: 0,
                ),
              ),
            ),
          ],
        )),
      ],
    ));
  }
}
