import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goinggoing_flutterapp/Group/GroupViewModel.dart';
import 'package:goinggoing_flutterapp/HomeScreen.dart';
import 'package:goinggoing_flutterapp/LoadingViewModel.dart';
import 'package:goinggoing_flutterapp/Routine/RoutineViewModel.dart';
import 'package:goinggoing_flutterapp/Schedule/ScheduleAddViewModel.dart';
import 'package:goinggoing_flutterapp/Schedule/ScheduleViewModel.dart';
import 'package:provider/provider.dart';

import 'Calender/CalenderViewModel.dart';
import 'PageServuce.dart';
import 'Timer/TimerDetailView.dart';
import 'Timer/TimerMainView.dart';
import 'Timer/TimerViewModel.dart';
import 'User/UserViewModel.dart';

class MainProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PageViewModel>(
            create: (context) => PageViewModel()),
        ChangeNotifierProvider<TimerViewModel>(
            create: (context) => TimerViewModel(Provider.of<ScheduleViewModel>(context, listen: false),
            )),
        ChangeNotifierProvider<GroupViewModel>(
            create: (context) => GroupViewModel()),
        ChangeNotifierProvider<CalendarViewModel>(
            create: (context) => CalendarViewModel()),
        ChangeNotifierProvider(
          create: (context) => MapBottomSheetViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => RoutineViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ScheduleAddViewModel(),
        ),
      ],
      child: MaterialApp(
        home: MyBottomNavigationBar(),
      ),
    );
  }
}

