import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goinggoing_flutterapp/Group/GroupAddScreen.dart';
import 'package:goinggoing_flutterapp/Group/GroupViewModel.dart';
import 'package:goinggoing_flutterapp/Routine/RoutineViewModel.dart';
import 'package:goinggoing_flutterapp/Schedule/ScheduleViewModel.dart';
import 'package:goinggoing_flutterapp/User/UserViewModel.dart';
import 'package:provider/provider.dart';

import '../Schedule/Schedule.dart';
import 'Group.dart';

class ScheduleGroupWidget extends StatelessWidget {
  static double screenWidth = 0;
  static double screenHeight = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width / 540;
    screenHeight = MediaQuery.of(context).size.height / 1200;
    GroupViewModel groupViewModel = Provider.of<GroupViewModel>(context);
    return Container(
      height: 66 * screenHeight,
      child: Row(children: [
        Expanded(
          child: ListView.builder(
              itemCount: groupViewModel.scheduleGroupList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                if (groupViewModel.showAddButton &&
                    index == groupViewModel.scheduleGroupList.length - 1) {
                  return _addGroupBtn(index,context);
                } else {
                  return _groupbody(index,context);
                }
              }),
        ),
      ]),
    );
  }

  Widget _groupbody(int index,BuildContext context) {
    GroupViewModel groupViewModel = Provider.of<GroupViewModel>(context);
    ScheduleViewModel scheduleViewModel = Provider.of<ScheduleViewModel>(context);
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    RoutineViewModel routineViewModel = Provider.of<RoutineViewModel>(context);
    return Container(
        width: 66 * screenWidth,
        height: 66 * screenHeight,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50 * screenWidth,
                height: 50 * screenHeight,
                child: ElevatedButton(
                  onPressed: () async{
                    int scheduleId = scheduleViewModel.schedule!.id!;
                    ScheduleRoutineData scheduleRoutineData = await groupViewModel.getMemberScheduleRoutineList(scheduleId,groupViewModel.scheduleGroupList[index].userId!);
                    routineViewModel.getMemberScheduleRoutineList(scheduleRoutineData);
                    scheduleViewModel.getMemberScheduleDuration(scheduleRoutineData);
                    if(userViewModel.user!.userId! != groupViewModel.selectedMember) {
                      scheduleViewModel.makePutFalse();
                    }
                    // 버튼이 눌렸을 때 수행할 동작 정의
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Color(0xFFDCFF5C), // 배경색
                    shape: CircleBorder(), // 원 모양으로 설정
                  ),
                  child: Image.asset('assets/images/rabbitimo.png',
                      width: 50 * screenWidth, height: 50 * screenHeight),
                ),
              ),
              SizedBox(height: 3 * screenHeight),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 19.19 * screenWidth,
                      height: 12.79 * screenHeight,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          groupViewModel.scheduleGroupList[index].name!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFF2F2F2),
                            fontSize: 10 * screenHeight,
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
            ]));
  }

  Widget _addGroupBtn(int index,BuildContext context) {
    return SizedBox(
        child: Row(
      children: [
        _groupbody(index,context),
        SizedBox(
            width: 66 * screenWidth,
            height: 66 * screenHeight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 50 * screenWidth,
                  height: 50 * screenHeight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,  MaterialPageRoute(
                        builder: (context) => GroupAddScreen(),
                      ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent, // 투명한 배경색
                      shadowColor: Colors.transparent, // 그림자 색상도 투명하게 설정
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/addGroup.svg',
                        width: 50 * screenWidth, height: 50 * screenHeight,
                    ),
                  ),
                ),
                SizedBox(height: 3 * screenHeight),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 19.19 * screenWidth,
                        height: 12.79 * screenHeight,
                      ),
                    ],
                  ),
                ),
              ],
            ))
      ],
    ));
  }
}
