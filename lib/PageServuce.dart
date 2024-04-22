import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goinggoing_flutterapp/Calender/CalenderDetailsScreen.dart';
import 'package:goinggoing_flutterapp/Calender/CalenderScreen.dart';
import 'package:goinggoing_flutterapp/Timer/TimerViewModel.dart';
import 'package:goinggoing_flutterapp/User/UserViewModel.dart';
import 'package:provider/provider.dart';
import 'Group/GroupViewModel.dart';
import 'Schedule/ScheduleAddScreen.dart';
import 'Schedule/ScheduleViewModel.dart';
import 'Timer/TimerControllScreen.dart';
import 'Timer/TimerDetailView.dart';
import 'Timer/TimerMainView.dart';
import 'ProviderPage.dart';


class MyBottomNavigationBar extends StatelessWidget {

  static double screenHeight = 0;
  static double screenWidth = 0;

  final List<Widget> _screenData =  [CalenderScreen(),CalenderDetailsScreen(),CalenderScreen(),TimerControllScreen(),CalenderScreen()];

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height / 1200;
    screenWidth = MediaQuery.of(context).size.width / 540;
    GroupViewModel groupViewModel = Provider.of<GroupViewModel>(context);
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    TimerViewModel timerViewModel = Provider.of<TimerViewModel>(context);


    return Scaffold(
        body: SafeArea(
          child: Consumer<PageViewModel>(
            builder: (_, vm, __) {
              return IndexedStack(
                index: vm.getPageNum,
                children: _screenData,
              );
            },
          ),
        ),
        bottomNavigationBar: Consumer<PageViewModel>(builder: (_, vm, __) {
          return BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: vm.getPageNum,
            onTap: (index)  {
              if (index == 2) {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScheduleScreen()));
              }
              else if(index ==3){
                groupViewModel.updateShowAddButton(false);
                if(timerViewModel.nearestSchedule.id != null) {
                  groupViewModel.getTimerGroupList(
                      timerViewModel.nearestSchedule.id!,
                      userViewModel.user!.userId!);
                }
                vm.setPage(index);
              }
              else {
                vm.setPage(index);
              }
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black,
            items: [
              BottomNavigationBarItem(
                icon: vm._pageNum == 0
                    ? Container(
                  width: 24.0 * min(screenWidth, screenHeight), // 원하는 너비 설정
                  height: 24.0 * min(screenWidth, screenHeight), // 원하는 높이 설정
                  child: SvgPicture.asset('assets/icons/redhouse.svg'),
                )
                    : Container(
                  width: 24.0 * min(screenWidth, screenHeight), // 원하는 너비 설정
                  height: 24.0 * min(screenWidth, screenHeight), // 원하는 높이 설정
                  child: SvgPicture.asset('assets/icons/greyhouse.svg'),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: vm._pageNum == 1
                    ? Container(
                  width: 24.0 * min(screenWidth, screenHeight), // 원하는 너비 설정
                  height: 24.0 * min(screenWidth, screenHeight), // 원하는 높이 설정
                  child: SvgPicture.asset('assets/icons/redbag.svg'),
                )
                    : Container(
                  width: 24.0 * min(screenWidth, screenHeight), // 원하는 너비 설정
                  height: 24.0 * min(screenWidth, screenHeight), // 원하는 높이 설정
                  child: SvgPicture.asset('assets/icons/greybag.svg'),
                ),
                label: '1',
              ),

              BottomNavigationBarItem(
                icon: Container(
                  width: 32.0 * min(screenWidth, screenHeight), // 원하는 너비 설정
                  height: 32.0 * min(screenWidth, screenHeight), // 원하는 높이 설정
                  child: SvgPicture.asset('assets/icons/Group_18.svg'),
                ),
                label: '2',
              ),
              BottomNavigationBarItem(
                icon: vm._pageNum == 3
                    ? Container(
                  width: 24.0 * min(screenWidth, screenHeight), // 원하는 너비 설정
                  height: 24.0 * min(screenWidth, screenHeight), // 원하는 높이 설정
                  child: SvgPicture.asset('assets/icons/redtimer.svg'),
                )
                    : Container(
                  width: 24.0 * min(screenWidth, screenHeight), // 원하는 너비 설정
                  height: 24.0 * min(screenWidth, screenHeight), // 원하는 높이 설정
                  child: SvgPicture.asset('assets/icons/greytimer.svg'),
                ),
                label: '3',
              ),
              BottomNavigationBarItem(
                icon: vm._pageNum == 4
                    ? Container(
                  width: 24.0 * min(screenWidth, screenHeight), // 원하는 너비 설정
                  height: 24.0 * min(screenWidth, screenHeight), // 원하는 높이 설정
                  child: SvgPicture.asset('assets/icons/redrabbit.svg'),
                )
                    : Container(
                  width: 24.0 * min(screenWidth, screenHeight), // 원하는 너비 설정
                  height: 24.0 * min(screenWidth, screenHeight), // 원하는 높이 설정
                  child: SvgPicture.asset('assets/icons/greyrabbit.svg'),
                ),
                label: '4',
              ),
            ],
          );
        },
    ),
    );
  }
}
class PageViewModel extends ChangeNotifier {
  int _pageNum = 0;
  int get getPageNum => _pageNum;
  void setPage(int index) {
    _pageNum = index;
    print(index);
    notifyListeners();
  }
}