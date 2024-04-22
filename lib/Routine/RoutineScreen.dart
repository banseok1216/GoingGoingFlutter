import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goinggoing_flutterapp/Routine/RoutineAddScreen.dart';
import 'package:provider/provider.dart';

import '../Schedule/RoutineInScheduleModal.dart';
import '../Schedule/ScheduleDetailScreen.dart';
import '../Schedule/ScheduleViewModel.dart';
import 'Routine.dart';
import 'RoutineViewModel.dart';

class RoutineScreen extends StatelessWidget {
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
          height: 1200 * screenHeight,
          decoration: BoxDecoration(color: Color(0xFFF2F2F2)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Mainframe(context),
              Bottomframe(context),
              Flexible(
                child: Container(),
                fit: FlexFit.tight,
              ),
            ],
          ),
        ));
  }

  Widget Mainframe(BuildContext context) {
    final routineViewModel = Provider.of<RoutineViewModel>(context);
    return Container(
      width: 540 * screenWidth,
      height: 1103 * screenHeight,
      padding: EdgeInsets.only(
          top: 58 * screenHeight,
          left: 28 * screenWidth,
          right: 28 * screenWidth),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: 484 * screenWidth,
              height: 49 * screenHeight,
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        routineViewModel.makePutFalse();
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        'assets/icons/greybackbutton.svg',
                        width: 35 * screenWidth,
                        height: 35 * screenHeight,
                      ),
                    ),
                    Flexible(
                      child: Container(),
                      fit: FlexFit.tight,
                    ),
                    Container(
                      height: 49 * screenHeight,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: routineViewModel.isPutRunning
                                ? null
                                : () {
                                    routineViewModel.statePutRunning();
                                  },
                            child: Container(
                              width: 37 * screenWidth,
                              height: 37 * screenHeight,
                              child: Visibility(
                                visible: !routineViewModel.isPutRunning,
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
                  ])),
          SizedBox(
            height: 29 * screenHeight,
          ),
          Container(
            width: 484 * screenWidth,
            height: 49 * screenHeight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 43 * screenWidth,
                  height: double.infinity,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/blackbag.svg',
                        width: 25 * screenWidth,
                        height: 25 * screenHeight,
                      )
                    ],
                  ),
                ),
                SizedBox(width: 4 * screenWidth),
                Container(
                  padding: EdgeInsets.only(left: 8 * screenWidth),
                    child: Text(
                      '저장된 루틴을 불러올 수 있어요.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16 * screenHeight,
                        fontFamily: 'Apple',
                        fontWeight: FontWeight.w100,
                        height: 0,
                      ),
                    ),
                  ),
                Flexible(child: Container(),fit: FlexFit.loose,)
              ],
            ),
          ),
          Container(
            height: 10 * screenHeight, // 상단에 10 픽셀 간격 추가
          ),
          Divider(
            color: Colors.grey,
          ),
          Container(
            height: 10 * screenHeight, // 상단에 10 픽셀 간격 추가
          ),
          bodyframe(context),
          SizedBox(
            height: 29 * screenHeight,
          ),
          Flexible(
            child: Container(),
            fit: FlexFit.tight,
          ),
        ],
      ),
    );
  }

  Widget bodyframe(BuildContext context) {
    final routineViewModel = Provider.of<RoutineViewModel>(context);

    return Container(
      height: 800 * screenHeight,
      child: ReorderableListView(
        buildDefaultDragHandles: false,
        onReorder: (oldIndex, newIndex) {
          if (routineViewModel.isPutRunning) {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            routineViewModel.moveRoutineList(oldIndex, newIndex);
          }
        },
        proxyDecorator: (widget, animation, proxy) {
          return Material(
            child: widget,
            color: Colors.transparent,
          );
        },
        children: [
          for (int index = 0;
              index < routineViewModel.routineList.length;
              index++)
            ReorderableDragStartListener(
              enabled: routineViewModel.isPutRunning ? true : false,
              key: Key('$index'),
              index: index,
              child: _RoutineBtn(index, context),
            ),
          if (!routineViewModel.isPutRunning)
            _addRoutineBtn(context, ValueKey(ObjectKey("add"))),
          if (routineViewModel.routineList.isEmpty &&
              !routineViewModel.isPutRunning) ...[
            Container(
              key: ObjectKey("text"),
              width: 484 * screenWidth,
              height: 48 * screenHeight,
              child: Text(
                '저장된 루틴이 없네요. 루틴을 저장하고 쉽게 꺼내보세요!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF4D4D4D),
                  fontSize: 16 * screenHeight,
                  fontFamily: 'Apple',
                  fontWeight: FontWeight.w100,
                  height: 0,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _RoutineBtn(int index, context) {
    final routineViewModel = Provider.of<RoutineViewModel>(context);
    late int totaltime = routineViewModel.getRoutineTotalTime(index);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 13.5 * screenHeight),
      width: 484 * screenWidth,
      child: Container(
        child: Row(
          children: [
            AnimatedContainer(
                width: routineViewModel.isPutRunning ? 64 * screenWidth : 0,
                duration: Duration(milliseconds: 500),
                child: Visibility(
                  visible: routineViewModel.isPutRunning,
                  child: InkWell(
                    onTap: () {
                      routineViewModel.removeRoutineList(index);
                    },
                    child: Container(
                        width: 40 * screenWidth,
                        height: 40 * screenHeight,
                        child: SvgPicture.asset(
                          'assets/icons/redxbutton.svg',
                          allowDrawingOutsideViewBox: true,
                        )),
                  ),
                )),
            AnimatedContainer(
                width: routineViewModel.isPutRunning
                    ? 420 * screenWidth
                    : 484 * screenWidth,
                duration: Duration(milliseconds: 500),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print(index);
                        routineViewModel.updateSelectedRoutineIndex(index);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            routineViewModel.selectedRoutineIndex == index
                                ? Color(0xFFD6F36D)
                                : Color(0xFF282828)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(21),
                          ),
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.all(30 * min(screenWidth, screenHeight)),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 157 * screenWidth,
                            child: Text(
                              routineViewModel.routineList[index].title!,
                              textAlign: TextAlign.start,
                              // Align the text within the Text widget
                              style: TextStyle(
                                color: routineViewModel.selectedRoutineIndex ==
                                        index
                                    ? Color(0xFF1A1A1A)
                                    : Color(0xFFF2F2F2),
                                fontSize: 20 * screenHeight,
                                fontFamily: 'Apple',
                                fontWeight: FontWeight.w100,
                                height: 1.5,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Container(),
                          ),
                          SizedBox(width: 8 * screenWidth),
                          Container(
                            width: 28 * screenWidth,
                            height: 46 * screenHeight,
                            child: SvgPicture.asset(
                              routineViewModel.selectedRoutineIndex == index
                                  ? 'assets/icons/greydownbutton.svg'
                                  : 'assets/icons/greyupbutton.svg',
                              width: 28 * screenWidth,
                              height: 46 * screenHeight,
                            ),
                          ),
                          SizedBox(width: 8 * screenWidth),
                          Container(
                            width: 169 * screenWidth,
                            height: 118 * screenHeight,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16 * screenWidth,
                                vertical: 6 * screenHeight),
                            decoration: ShapeDecoration(
                              color:
                                  routineViewModel.selectedRoutineIndex == index
                                      ? Color(0x720E0E0E)
                                      : Color(0x720E0E0E),
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
                                    padding:
                                        EdgeInsets.only(left: 5 * screenWidth),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              if (totaltime ~/ 3600 != 0)
                                                TextSpan(
                                                  text: (totaltime ~/ 3600)
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Color(0xFFF2F2F2),
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
                                                    color: Color(0xFFF2F2F2),
                                                    fontSize: 15 * screenHeight,
                                                    fontFamily: 'Apple',
                                                    fontWeight: FontWeight.w100,
                                                    height: 0,
                                                  ),
                                                ),
                                              if (totaltime % 3600 ~/ 60 != 0)
                                                TextSpan(
                                                  text: (totaltime % 3600 ~/ 60)
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Color(0xFFF2F2F2),
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
                                                    color: Color(0xFFF2F2F2),
                                                    fontSize: 15 * screenHeight,
                                                    fontFamily: 'Apple',
                                                    fontWeight: FontWeight.w100,
                                                    height: 0,
                                                  ),
                                                ),
                                              if (totaltime % 60 != 0 ||
                                                  totaltime == 0)
                                                TextSpan(
                                                  text: (totaltime % 60)
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Color(0xFFF2F2F2),
                                                    fontSize: 25 * screenHeight,
                                                    fontFamily: 'Apple',
                                                    fontWeight: FontWeight.w100,
                                                    height: 0,
                                                  ),
                                                ),
                                              if (totaltime % 60 != 0 ||
                                                  totaltime == 0)
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
                          )
                        ],
                      ),
                    ),
                    routineViewModel.selectedRoutineIndex == index
                        ? RoutineDetailScreen(
                            routineViewModel.routineList[index].details!)
                        : Container(
                            height: 0,
                          )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _addRoutineBtn(BuildContext context, ValueKey<ObjectKey> valueKey) {
    final routineViewModel = Provider.of<RoutineViewModel>(context);

    return Column(
      key: valueKey,
      children: [
        SizedBox(height: 15 * screenHeight),
        SizedBox(
          height: 114.35 * screenHeight,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              routineViewModel.getEmptyRoutineList();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RoutineAddScreen(),
                ),
              );
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

  Widget Bottomframe(context) {
    final routineViewModel = Provider.of<RoutineViewModel>(context);
    final scheduleViewModel = Provider.of<ScheduleViewModel>(context);

    return Container(
      width: 540 * screenWidth,
      height: 97 * screenHeight,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color?>(
            routineViewModel.isPutRunning
                ? Color(0xFFFF4F4F)
                : routineViewModel.selectedRoutineIndex == -1
                    ? Color(0xFFB3B3B3)
                    : Color(0xFFFF4F4F),
          ),
        ),
        onPressed: routineViewModel.isPutRunning
            ? () {
                routineViewModel.updateSelectedRoutineIndex(-1);
                routineViewModel.statePutRunning();
              }
            : routineViewModel.selectedRoutineIndex == -1
                ? null
                : () async{
                    await routineViewModel.addRoutineToSchedule(
                        routineViewModel.selectedRoutineIndex,
                        scheduleViewModel.personalSchedule!.id!);
                    await scheduleViewModel.updatePersonalSchedule(Duration(
                        seconds: scheduleViewModel.personalSchedule.duration),
                        await routineViewModel.getScheduleRoutineTotalTime());
                    routineViewModel.makePutFalse();
                    Navigator.pop(context);
                  },
        child: SizedBox(
          width: 109 * screenWidth,
          height: 42 * screenHeight,
          child: Text(
            routineViewModel.isPutRunning ? '저장' : '불러오기',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: routineViewModel.isPutRunning
                  ? Color(0xFFF2F2F2)
                  : routineViewModel.selectedRoutineIndex == -1
                      ? Color(0xFF666666)
                      : Color(0xFFF2F2F2),
              fontSize: 16 * screenHeight,
              fontFamily: 'Apple',
              fontWeight: FontWeight.w100,
              height: 0,
            ),
          ),
        ),
      ),
    );
  }

  Widget RoutineDetailScreen(List<RoutineDetail> routineDetailList) {
    return Container(
      width: 484 * screenWidth,
      padding: EdgeInsets.symmetric(vertical: 11 * screenWidth),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (var routine in routineDetailList)
            Container(
              padding: EdgeInsets.symmetric(vertical: 8 * screenHeight),
              child: Container(
                width: 460 * screenWidth,
                padding: EdgeInsets.only(
                  top: 11 * screenHeight,
                  left: 42 * screenWidth,
                  right: 11 * screenWidth,
                  bottom: 11 * screenHeight,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Color(0xFF646464),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(46.50),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8 * screenWidth),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 25 * screenWidth,
                            height: 25 * screenHeight,
                            child: SvgPicture.asset(
                              'assets/icons/greythreeline.svg',
                              width: 25 * screenWidth,
                              height: 25 * screenHeight,
                            ),
                          ),
                          SizedBox(width: 8 * screenWidth),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.all(
                                  10 * min(screenWidth, screenHeight)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    routine.content,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20 * screenHeight,
                                      fontFamily: 'Apple',
                                      fontWeight: FontWeight.w100,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            fit: FlexFit.loose,
                          )
                        ],
                      ),
                    ),
                    Flexible(fit: FlexFit.loose, child: Container()),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 19 * screenWidth,
                          vertical: 18 * screenHeight),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Color(0xFF4D4D4D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.50),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 70 * screenHeight,
                            padding: EdgeInsets.symmetric(
                                horizontal: 13 * screenWidth,
                                vertical: 5 * screenHeight),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: (routine.time ~/ 60).toString(),
                                        style: TextStyle(
                                          color: Color(0xFFF2F2F2),
                                          fontSize: 25 * screenHeight,
                                          fontFamily: 'Apple',
                                          fontWeight: FontWeight.w100,
                                          height: 0,
                                        ),
                                      ),
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
                                      TextSpan(
                                        text: (routine.time % 60).toString(),
                                        style: TextStyle(
                                          color: Color(0xFFF2F2F2),
                                          fontSize: 25 * screenHeight,
                                          fontFamily: 'Apple',
                                          fontWeight: FontWeight.w100,
                                          height: 0,
                                        ),
                                      ),
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
    );
  }
}
