import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goinggoing_flutterapp/Group/ScheduleGroupWidget.dart';
import 'package:goinggoing_flutterapp/Group/TimerGroupWidget.dart';
import 'package:goinggoing_flutterapp/Routine/RoutineViewModel.dart';
import 'package:goinggoing_flutterapp/Schedule/ScheduleViewModel.dart';
import 'package:goinggoing_flutterapp/Timer/TimerViewModel.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../Group/GroupViewModel.dart';
import '../PageServuce.dart';
import '../User/UserViewModel.dart';

class TimerDetailView extends StatelessWidget {
  double screenWidth = 0;
  double screenHeight = 0;

  @override
  Widget build(context) {
    final viewModel = Provider.of<MapBottomSheetViewModel>(context);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      viewModel.update(
        MediaQuery.of(context).size.height / 1200,
        MediaQuery.of(context).size.width / 540,
      );
    });
    screenWidth = MediaQuery.of(context).size.width / 540;
    screenHeight = MediaQuery.of(context).size.height / 1200;
    final timerViewModel = Provider.of<TimerViewModel>(context);

    return Scaffold(
      body: Container(
        width: 540 * screenWidth,
        height: 1200 * screenHeight,
        color: Color(0xFF1A1A1A),
        padding: EdgeInsets.only(top: 48 * screenHeight),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            HeadFrame(context),
            SizedBox(
              height: 64 * screenHeight,
            ),
            Flexible(
              child: Container(),
              fit: FlexFit.loose,
            ),
            timerViewModel.done && timerViewModel.start
                ? DoneFrame(context)
                : RoutineTimerWidget(context),
            Flexible(
              child: Container(),
              fit: FlexFit.loose,
            ),
            Container(
              height: 34 * screenHeight,
            ),
            GroupFrame(context),
            Container(
              height: 34 * screenHeight,
            ),
            MapBottomSheetContent(),
          ],
        ),
      ),
    );
  }

  Widget DoneFrame(context) {
    final timerViewModel = Provider.of<TimerViewModel>(context);

    return Container(
      width: 361 * screenWidth,
      height: 250 * screenHeight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 206 * screenWidth,
              height: 150 * screenHeight,
              child: FittedBox(
                child: Image.asset('assets/images/hifive.png'),
              )),
          SizedBox(height: 12 * screenHeight),
          Center(
            child: SizedBox(
              child: Text(
                '${timerViewModel.schedule!.title!}\n준비를 완료했어요!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25 * screenHeight,
                  fontFamily: 'Apple',
                  fontWeight: FontWeight.w100,
                  height: 1.5,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget GroupFrame(context) {
    final timerViewModel = Provider.of<TimerViewModel>(context);

    return Center(
      child: Container(
          width: 484 * screenWidth,
          height: 94 * screenHeight,
          child: Row(
            children: [
              Container(
                width: 7 * screenWidth,
              ),
              Container(
                width: 300 * screenWidth,
                child: timerViewModel.nearestSchedule.id == null
                    ? Container()
                    : TimerGroupWidget(),
              ),
              Container(
                width: 7 * screenWidth,
              ),
              timerViewModel.done || timerViewModel.nearestSchedule.id == null
                  ? Container(
                      width: 170 * screenWidth,
                      height: 94 * screenHeight,
                    )
                  : Container(
                      width: 170 * screenWidth,
                      height: 94 * screenHeight,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/donebutton.png'),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          timerViewModel.onDoneButtonPressed();
                        },
                        child: Center(
                          child: Text(
                            'Done',
                            style: TextStyle(
                              color: Color(0xFF1A1A1A),
                              fontSize: 24 * screenHeight,
                              fontFamily: 'Apple',
                              fontWeight: FontWeight.w100,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    )
            ],
          )),
    );
  }

  Widget HeadFrame(context) {
    final timerViewModel = Provider.of<TimerViewModel>(context);
    final scheduleViewModel = Provider.of<ScheduleViewModel>(context);
    final groupViewModel = Provider.of<GroupViewModel>(context);
    final userViewModel = Provider.of<UserViewModel>(context);
    final pageViewModel = Provider.of<PageViewModel>(context);

    return Container(
        width: 484 * screenWidth,
        height: 49 * screenHeight,
        child: Row(
          children: [
            Container(
              width: 14.50 * screenWidth,
              height: 14.50 * screenWidth,
            ),
            Flexible(
              child: Container(),
              fit: FlexFit.loose,
            ),
            Center(
              child: SizedBox(
                width: 216 * screenWidth,
                child: Text(
                  timerViewModel.schedule!.title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
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
            timerViewModel.done && timerViewModel.start
                ? InkWell(
                    onTap: () async {
                      await scheduleViewModel.getScheduleList();
                      await timerViewModel
                          .getNearScheduleList(scheduleViewModel.scheduleList);
                      if(timerViewModel.nearestSchedule.id != null) {
                        await groupViewModel.getTimerGroupList(
                            timerViewModel.nearestSchedule.id!,
                            userViewModel.user!.userId!);
                      }
                      timerViewModel.updateTimerScheduleToRoutineSchedule();
                      pageViewModel.setPage(0);
                      timerViewModel.updateDoneBtn(false);
                      timerViewModel.updateStartBtn(false);
                    },
                    child: SvgPicture.asset(
                      'assets/icons/xbutton.svg',
                      width: 14.5 * screenWidth,
                      height: 14.50 * screenWidth,
                    ))
                : Container(),
          ],
        ));
  }

  Widget RoutineTimerWidget(BuildContext context) {
    final timerViewModel = Provider.of<TimerViewModel>(context);
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 18 * screenHeight,
          child: Center(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                'Mission',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFF2F2F2),
                  fontSize: 13.80 * screenHeight,
                  fontFamily: 'Apple',
                  fontWeight: FontWeight.w100,
                  height: 0,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 6 * screenHeight,
        ),
        SizedBox(
            width: double.infinity,
            height: 45 * screenHeight,
            child: Center(
              child: Text(
                timerViewModel.scheduleRoutineList.isNotEmpty
                    ? timerViewModel
                        .scheduleRoutineList[timerViewModel.currentIndex]
                        .content
                    : '00:00:00',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFF2F2F2),
                  fontSize: 20 * screenHeight,
                  fontFamily: 'Apple',
                  fontWeight: FontWeight.w100,
                  height: 0,
                ),
              ),
            )),
        SizedBox(
          height: 63 * screenHeight,
        ),
        Container(
          width: 484 * screenWidth,
          height: 18 * screenHeight,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              'Rest of time',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFF2F2F2),
                fontSize: 13.80 * screenHeight,
                fontFamily: 'Apple',
                fontWeight: FontWeight.w100,
                height: 0,
              ),
            ),
          ),
        ),
        Container(
          width: 484 * screenWidth,
          height: 104 * screenHeight,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              timerViewModel
                  .formatDuration(timerViewModel.remainingRoutineTime),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 80 * screenHeight,
                fontFamily: 'Apple',
                fontWeight: FontWeight.w100,
                height: 0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MapBottomSheetViewModel extends ChangeNotifier {
  double _height = 0;
  double _lowLimit = 0;
  double _highLimit = 0;
  double _upThresh = 0;
  double _boundary = 0;
  double _downThresh = 0;

  bool _longAnimation = false;
  bool isheight = false;

  double get height => _height;

  MapBottomSheetViewModel() {
    isheight = false;
  }

  void update(double height, double width) {
    if (!isheight) {
      _height = 106 * height;
      _lowLimit = 106 * height;
      _highLimit = 311 * height;
      _upThresh = 126 * height;
      _boundary = 208 * height;
      _downThresh = 291 * height;
      isheight = true;
      notifyListeners();
    }
  }

  void updateHeight(double delta) {
    print(_height);
    if (_longAnimation ||
        (_height <= _lowLimit && delta > 0) ||
        (_height >= _highLimit && delta < 0)) return;

    if (_upThresh <= _height && _height <= _boundary) {
      _height = _highLimit;
      _longAnimation = true;
    } else if (_boundary <= _height && _height <= _downThresh) {
      _height = _lowLimit;
      _longAnimation = true;
    } else {
      _height -= delta;
    }

    if (_longAnimation) {
      _longAnimation = false;
      notifyListeners();
    }
  }
}

class MapBottomSheetContent extends StatelessWidget {
  double screenWidth = 0;
  double screenHeight = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width / 540;
    screenHeight = MediaQuery.of(context).size.height / 1200;
    final viewModel = Provider.of<MapBottomSheetViewModel>(context);
    final timerViewModel = Provider.of<TimerViewModel>(context);
    final UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    return Container(
        decoration: const BoxDecoration(
          color: Color(0xFF2B2B2B),
          borderRadius: BorderRadius.vertical(top: Radius.circular(27)),
        ),
        child: Column(
          children: [
            GestureDetector(
              onVerticalDragUpdate: (details) {
                double delta = details.primaryDelta ?? 0;
                viewModel.updateHeight(delta);
              },
              child: AnimatedContainer(
                curve: Curves.bounceOut,
                onEnd: () {
                  if (viewModel._longAnimation) {
                    viewModel._longAnimation = false;
                  }
                },
                duration: const Duration(milliseconds: 400),
                decoration: const BoxDecoration(
                  color: Color(0xFF2B2B2B),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(27)),
                ),
                width: MediaQuery.of(context).size.width,
                height: viewModel.height,
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(), // 추가된 부분
                  child: Column(
                    children: [
                      SizedBox(height: 31 * screenHeight),
                      Container(
                        width: 38 * screenWidth,
                        height: 4.5 * screenHeight,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      SizedBox(height: 30 * screenHeight),
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          timerViewModel.done && timerViewModel.start
                              ? '${userViewModel.user!.userNickName!}님은 외출 준비를 완료했어요!'
                              : '${userViewModel.user!.userNickName!}님은 현재 ${timerViewModel.currentIndex}번째 미션을 진행중이에요!',
                          style: TextStyle(
                            color: Color(0xFFF2F2F2),
                            fontSize: 20 * screenHeight,
                            fontFamily: 'Apple',
                            fontWeight: FontWeight.w100,
                            height: 0,
                          ),
                        ),
                      ),
                      SizedBox(height: 30 * screenHeight),
                      Container(
                        height: 183 * screenHeight,
                        child: Row(children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount:
                                    timerViewModel.scheduleRoutineList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index == timerViewModel.currentIndex) {
                                    return CurrentRoutine(index, context);
                                  } else {
                                    return NotCurrentRoutine(index, context);
                                  }
                                }),
                          ),
                        ]),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30 * screenHeight),
            lastRidingProgress(context),
            SizedBox(height: 31 * screenHeight),
          ],
        ));
  }

  Widget CurrentRoutine(int index, BuildContext context) {
    final timerViewModel = Provider.of<TimerViewModel>(context);

    return Container(
      width: 164 * screenWidth,
      padding: EdgeInsets.symmetric(horizontal: 7 * screenWidth),
      child: Container(
        decoration: ShapeDecoration(
          color: Color(0xFF1A1A1A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19),
          ),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: 8 * screenWidth, vertical: 14 * screenHeight),
        child: Container(
          width: 134 * screenWidth,
          height: 80 * screenHeight,
          padding: EdgeInsets.symmetric(horizontal: 3 * screenWidth),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  color: Color(0xFFF2F2F2).withOpacity(0.19),
                ),
                width: 30.0 * screenWidth,
                height: 30.0 * screenHeight,
                child: Center(
                  child: Text(
                    (index + 1).toString(),
                    style: TextStyle(
                      color: Color(0xFFF2F2F2),
                      fontSize: 14.48 * screenHeight,
                      fontFamily: 'Apple',
                      fontWeight: FontWeight.w100,
                      height: 0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 4 * screenHeight,
              ),
              Container(
                width: 103 * screenWidth,
                padding: EdgeInsets.all(5 * screenHeight),
                child: Text(
                  timerViewModel.scheduleRoutineList[index].content,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15 * screenHeight,
                    fontFamily: 'Apple',
                    fontWeight: FontWeight.w100,
                    height: 0,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Flexible(
                child: Container(),
                fit: FlexFit.loose,
              ),
              Container(
                width: 134 * screenWidth,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${timerViewModel.scheduleRoutineList[index].time ~/ 60}m ' +
                          '${timerViewModel.scheduleRoutineList[index].time % 60}s',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15 * screenHeight,
                        fontFamily: 'Apple',
                        fontWeight: FontWeight.w100,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget NotCurrentRoutine(int index, BuildContext context) {
    final timerViewModel = Provider.of<TimerViewModel>(context);
    return Container(
      width: 139 * screenWidth,
      padding: EdgeInsets.symmetric(
          horizontal: 7 * screenWidth, vertical: 20 * screenHeight),
      child: Container(
        decoration: ShapeDecoration(
          color: Color(0x4C7D7D7D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19),
          ),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: 8 * screenWidth, vertical: 14 * screenHeight),
        child: Opacity(
          opacity: 0.30,
          child: Container(
            width: 109 * screenWidth,
            height: 80 * screenHeight,
            padding: EdgeInsets.symmetric(horizontal: 3 * screenWidth),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: ShapeDecoration(
                    shape: CircleBorder(),
                    color: Color(0xFFF2F2F2).withOpacity(0.19),
                  ),
                  width: 30.0 * screenWidth,
                  height: 30.0 * screenHeight,
                  child: Center(
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(
                        color: Color(0xFFF2F2F2),
                        fontSize: 14.48 * screenHeight,
                        fontFamily: 'Apple',
                        fontWeight: FontWeight.w100,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4 * screenHeight,
                ),
                Container(
                  width: 103 * screenWidth,
                  padding: EdgeInsets.all(5 * screenHeight),
                  child: Text(
                    timerViewModel.scheduleRoutineList[index].content,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12 * screenHeight,
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
                  width: 109 * screenWidth,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${timerViewModel.scheduleRoutineList[index].time ~/ 60}m ' +
                            '${timerViewModel.scheduleRoutineList[index].time % 60}s',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12 * screenHeight,
                          fontFamily: 'Apple',
                          fontWeight: FontWeight.w100,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget lastRidingProgress(BuildContext context) {
    final timerViewModel = Provider.of<TimerViewModel>(context);

    return Container(
      width: 484 * screenWidth,
      height: 95 * screenHeight,
      child: LinearPercentIndicator(
        padding: EdgeInsets.zero,
        percent: timerViewModel.percentage,
        lineHeight: 95 * screenHeight,
        backgroundColor: Color(0xFFFF4F4F),
        progressColor: Color(0x4CF8F8F8),
        barRadius: const Radius.circular(21),
        animateFromLastPercent: true,
        animation: true,
        width: 484 * screenWidth,
        center: Container(
          padding: EdgeInsets.symmetric(horizontal: 20 * screenWidth),
          child: Row(
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                        width: 21 * screenWidth,
                        height: 24 * screenHeight,
                        child: SvgPicture.asset(
                            'assets/icons/blackwhiteflag.svg')),
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          textAlign: TextAlign.center,
                          'Total',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24 * screenHeight,
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
              Flexible(
                child: Container(),
                fit: FlexFit.loose,
              ),
              Text(
                '${timerViewModel.getTotalTime().inSeconds ~/ 60}m ' +
                    '${timerViewModel.getTotalTime().inSeconds % 60}s',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20 * screenHeight,
                  fontFamily: 'Apple',
                  fontWeight: FontWeight.w100,
                  height: 0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
