import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../Schedule/RoutineInScheduleModal.dart';
import '../Schedule/ScheduleViewModel.dart';
import 'Routine.dart';
import 'RoutineEditModal.dart';
import 'RoutineViewModel.dart';

class RoutineAddScreen extends StatelessWidget {
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Mainframe(context),
          FinishBtn(context),
          Flexible(child: Container(),fit: FlexFit.tight,),
        ],
      ),
    ));
  }

  Widget FinishBtn(BuildContext context) {
    final routineViewModel = Provider.of<RoutineViewModel>(context);

    return Container(
        width: 540 * screenWidth,
        height: 97 * screenHeight,
        child: ElevatedButton(
            onPressed: (routineViewModel.emptyRoutine!.details!.isNotEmpty &&
                routineViewModel.emptyRoutine!.title != '' &&
                    !routineViewModel.isPutRunning)
                ? () async{
                    await routineViewModel.addRoutineDetailToRoutine();

                    routineViewModel.makePutFalse();
                    Navigator.pop(context);
                  }
                : null,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  routineViewModel.emptyRoutine!.details!.isNotEmpty &&
                      routineViewModel.emptyRoutine!.title != '' &&
                          !routineViewModel.isPutRunning
                      ? Color(0xFFFF4F4F)
                      : Color(0xFFC1C1C1)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      0.0), // BorderRadius.circular(0)은 직사각형 모양
                ),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                routineViewModel.emptyRoutine!.details!.length != 0 &&
                    routineViewModel.emptyRoutine!.title != ''
                    ? '루틴 추가하기'
                    : '미션을 한가지 이상 추가해주세요.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: (routineViewModel.emptyRoutine!.details!.length != 0 &&
                      routineViewModel.emptyRoutine!.title != '' ||
                          routineViewModel.isPutRunning)
                      ? Color(0xFFF2F2F2)
                      : Color(0xFF808080),
                  fontSize: 16 * screenHeight,
                  fontFamily: 'Apple',
                  fontWeight: FontWeight.w100,
                  height: 0,
                ),
              ),
            )));
  }

  Widget Mainframe(BuildContext context) {
    final routineViewModel = Provider.of<RoutineViewModel>(context);
    return Container(
      width: 540 * screenWidth,
      height: 1103 * screenHeight,
      padding: EdgeInsets.only(
          top: 48 * screenHeight,
          left: 28 * screenWidth,
          right: 28 * screenWidth),
      color: Colors.black,
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
                        Navigator.pop(context);
                        routineViewModel.makePutFalse();
                      },
                      child: SvgPicture.asset(
                        'assets/icons/whitebackbutton.svg',
                        width: 25 * screenWidth,
                        height: 25 * screenHeight,
                      ),
                    )
                  ])),
          Container(
            width: 484 * screenWidth,
            height: 49 * screenHeight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
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
                        'assets/icons/whiteplusbag.svg',
                        width: 31.60 * screenWidth,
                        height: 35.69 * screenHeight,
                      )
                    ],
                  ),
                ),
                SizedBox(width: 4 * screenWidth),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    padding: EdgeInsets.only(left: 8 * screenWidth),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                            '새로운 루틴을 만들 수 있어요.',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16 * screenHeight,
                              fontFamily: 'Apple',
                              fontWeight: FontWeight.w100,
                              height: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
          NewRoutineFrame(context),
          SizedBox(
            height: 29 * screenHeight,
          ),
          InputBox(context),
          SizedBox(
            height: 29 * screenHeight,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 31 * screenWidth),
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      height: 26 * screenHeight,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        textAlign: TextAlign.left,
                        '미션 추가하기',
                        style: TextStyle(
                          color: Color(0xFFF2F2F2),
                          fontSize: 14 * screenHeight,
                          fontFamily: 'Apple',
                          fontWeight: FontWeight.w100,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      routineViewModel.statePutRunning();
                    },
                    child: Image.asset(
                      'assets/images/whiteputicon.png',
                      width: 26 * screenWidth,
                      height: 26 * screenHeight,
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: 12.5 * screenHeight,
          ),
          MainFrame(context),
        ],
      ),
    );
  }

  Widget MainFrame(BuildContext context) {
    final routineViewModel = Provider.of<RoutineViewModel>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 31 * screenWidth),
      height: 500 * screenHeight,
      child: ReorderableListView(
        buildDefaultDragHandles: false,
        onReorder: (oldIndex, newIndex) {
          if (routineViewModel.isPutRunning) {
            routineViewModel.moveRoutineDetailList(oldIndex, newIndex);
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
              index < routineViewModel.emptyRoutine!.details!.length;
              index++)
            ReorderableDragStartListener(
              enabled: routineViewModel.isPutRunning ? true : false,
              key: Key('$index'),
              index: index,
              child: _RoutineBtn(index, context),
            ),
          if (!routineViewModel.isPutRunning)
            _addRoutineBtn(context, ValueKey(ObjectKey("add"))),
        ],
      ),
    );
  }

  Widget _RoutineBtn(int index, BuildContext context) {
    final routineViewModel = Provider.of<RoutineViewModel>(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.5 * screenHeight),
      width: 422 * screenWidth,
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
                      routineViewModel.removeRoutineDetail(index);
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
                    ? 355 * screenWidth
                    : 422 * screenWidth,
                duration: Duration(milliseconds: 500),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: routineViewModel.isPutRunning
                          ? () async {
                              final result = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return RoutineEditModal(
                                    routineDetail: routineViewModel
                                        .emptyRoutine!.details![index],
                                  );
                                },
                              );
                              print(result);
                              if (result != null) {
                                  routineViewModel.updateRoutineDetail(index, RoutineDetail(routineDetailId: 0, content: result['scheduleName'], time: result['Second'], index: index));
                              } // Handle button press, add your logic here
                            }
                          : null,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFF282828)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(46.5),
                          ),
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                              horizontal: 19 * screenWidth,
                              vertical: 18 * screenHeight),
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
                              routineViewModel
                                  .emptyRoutine!.details![index].content,
                              textAlign: TextAlign.start,
                              // Align the text within the Text widget
                              style: TextStyle(
                                color: Color(0xFFF2F2F2),
                                fontSize: 15 * screenHeight,
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
                          Container(
                            width: 119 * screenWidth,
                            height: 70 * screenHeight,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Color(0xFF1D1D1D),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.50),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: (routineViewModel.emptyRoutine!
                                                    .details![index].time ~/
                                                60)
                                            .toString(),
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
                                        text: (routineViewModel.emptyRoutine!
                                                    .details![index].time %
                                                60)
                                            .toString(),
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
        SizedBox(height: 12.5 * screenHeight),
        SizedBox(
          height: 91 * screenHeight,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              final result = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return RoutineScheduleModal(
                    second: true,
                  );
                },
              );
              print(result);
              if (result != null) {
                routineViewModel.addRoutineDetail(RoutineDetail(
                    routineDetailId: 1,
                    content: result['scheduleName'],
                    time: result['Second'],index:routineViewModel.routineList.length),);
              }
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                EdgeInsets.all(10 * min(screenWidth, screenHeight)),
              ),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(83),
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

  Widget NewRoutineFrame(context) {
    final routineViewModel = Provider.of<RoutineViewModel>(context);
    int totaltime = routineViewModel.getRoutineDetailTotalTime();
    return Container(
        width: 484 * screenWidth,
        height: 156 * screenHeight,
        padding: EdgeInsets.all(14 * min(screenWidth, screenHeight)),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Color(0xFF4D4D4D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Container(
                width: 223 * screenWidth,
                alignment: Alignment.centerLeft,
                child: Text(
                  routineViewModel.emptyRoutine!.title == '' ? '새로운 루틴' :  routineViewModel.emptyRoutine!.title!,
                  style: TextStyle(
                    color: Color(0xFFF2F2F2),
                    fontSize: 20 * screenHeight,
                    fontFamily: 'Apple',
                    fontWeight: FontWeight.w100,
                    height: 0,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(),
              fit: FlexFit.loose,
            ),
            Container(
              width: 157 * screenWidth,
              height: 128 * screenHeight,
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
                          child: Text(
                            textAlign: TextAlign.center,
                            'Total',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15 * screenHeight,
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
                    width: 130 * screenWidth,
                    padding: EdgeInsets.only(left: 5 * screenWidth),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              if (totaltime ~/ 3600 != 0)
                                TextSpan(
                                  text: (totaltime ~/ 3600).toString(),
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
                                  text: (totaltime % 3600 ~/ 60).toString(),
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
                              if (totaltime % 60 != 0 || totaltime == 0)
                                TextSpan(
                                  text: (totaltime % 60).toString(),
                                  style: TextStyle(
                                    color: Color(0xFFF2F2F2),
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
        ));
  }

  Widget InputBox(context) {
    final routineViewModel = Provider.of<RoutineViewModel>(context);

    return Container(
      width: 484 * screenWidth,
      height: 108 * screenHeight,
      padding: EdgeInsets.symmetric(horizontal: 31 * screenWidth),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 30 * screenHeight,
            alignment: Alignment.centerLeft,
            child: Text(
              '루틴 제목을 입력해주세요.',
              style: TextStyle(
                color: Color(0xFFF2F2F2),
                fontSize: 14 * screenHeight,
                fontFamily: 'Apple',
                fontWeight: FontWeight.w100,
                height: 0,
              ),
            ),
          ),
          SizedBox(height: 12 * screenHeight),
          Container(
            width: 422 * screenWidth,
            height: 45.38 * screenHeight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Form(
                  child: SizedBox(
                    width: 366.62 * screenWidth,
                    height: 28 * screenHeight,
                    child: TextFormField(
                      onChanged: (value) {
                        print(value);
                        routineViewModel.updateEmptyRoutineTitle(value);
                      },
                      style: TextStyle(
                        color: Color(0xFFF2F2F2),
                        fontSize: 16 * screenHeight,
                        fontFamily: 'Apple',
                        fontWeight: FontWeight.w100,
                        height: 0,
                      ),
                      decoration: InputDecoration(
                        hintText: '루틴 제목', // 플레이스홀더 텍스트
                        hintStyle: TextStyle(
                          color: Color(0xFFF2F2F2).withOpacity(0.5),
                          fontSize: 16 * screenHeight,
                          fontFamily: 'Apple',
                          fontWeight: FontWeight.w100,
                          height: 0,
                        ),
                        enabledBorder: InputBorder.none, // 비활성화 상태의 선을 없앰
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10 * screenHeight),
                Container(
                  child:  routineViewModel.emptyRoutine!.title == ''
                      ? SvgPicture.asset(
                          'assets/icons/checkpoint.svg',
                          width: 45.38 * screenWidth,
                          height: 45.38 * screenHeight,
                        )
                      : SvgPicture.asset(
                          'assets/icons/completepoint.svg',
                          width: 45.38 * screenWidth,
                          height: 45.38 * screenHeight,
                        ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12 * screenHeight),
          Container(
            height: 1.0 * screenHeight,
            color: Colors.grey,
            margin:
                EdgeInsets.symmetric(horizontal: 1 * screenHeight), // 좌우 여백 조절
          )
        ],
      ),
    );
  }
}
