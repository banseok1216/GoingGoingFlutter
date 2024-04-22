import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goinggoing_flutterapp/Schedule/ScheduleViewModel.dart';
import 'package:goinggoing_flutterapp/Timer/TimerDetailView.dart';
import 'package:goinggoing_flutterapp/Timer/TimerMainView.dart';
import 'package:goinggoing_flutterapp/Timer/TimerViewModel.dart';
import 'package:goinggoing_flutterapp/User/UserViewModel.dart';
import 'package:provider/provider.dart';

import '../Group/GroupViewModel.dart';

class TimerControllScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TimerViewModel timerViewModel = Provider.of<TimerViewModel>(context);
      return timerViewModel.difference.inSeconds == 0 || timerViewModel.start ||timerViewModel.nearestSchedule.id==null
          ? TimerDetailView()
          : TimerMainView();
  }
}

