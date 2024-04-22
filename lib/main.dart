import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:goinggoing_flutterapp/Calender/CalenderDetailsScreen.dart';
import 'package:goinggoing_flutterapp/HomeScreen.dart';
import 'package:goinggoing_flutterapp/User/LoginScreen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'LoadingViewModel.dart';
import 'Schedule/ScheduleViewModel.dart';
import 'User/UserViewModel.dart';
import 'firebase_options.dart';
import 'ProviderPage.dart';
import 'SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initiailizeNotification();
  await initializeDateFormatting('ko_KR', null);
  KakaoSdk.init(
    nativeAppKey: '71c6525734351dbbe4e154f37d24e801',
  );
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("백그라운드 메시지 처리 ${message.notification!.body}");
}

void initiailizeNotification() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(const AndroidNotificationChannel(
          'high_importance_channel', 'high_importance_notification',
          importance: Importance.max));
  await flutterLocalNotificationPlugin.initialize(const InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  ));
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  void getMyDeviceToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print("내 디바이스 토큰: $token");
  }

  @override
  Widget build(BuildContext context) {
    getMyDeviceToken();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserViewModel(),
        ),
        ChangeNotifierProvider<ScheduleViewModel>(
            create: (context) => ScheduleViewModel()),
        ChangeNotifierProvider(
          create: (context) => LoadingViewModel(),
        ),
      ],
      child: MaterialApp(
        // MaterialApp으로 앱 감싸기
        home: FutureBuilder<Object>(
          future: Future.delayed(Duration(seconds: 3), () => 100),
          builder: (context, snapshot) {
            return _splashLoadingWidget(context, snapshot);
          },
        ),
      ),
    );
  }

  // FutureBuilder<List<void>> _splashLoadingWidget(
  //     BuildContext context, AsyncSnapshot<Object> snapshot) {
  //   UserViewModel userViewModel =
  //       Provider.of<UserViewModel>(context, listen: false);
  //   ScheduleViewModel scheduleViewModel =
  //       Provider.of<ScheduleViewModel>(context, listen: false);
  //   return FutureBuilder(
  //     future: Future.wait([
  //       userViewModel.getUserProfile(),
  //     ]),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasError) {
  //         print('에러발생');
  //         return Text('Error');
  //       } else if (userViewModel.user!.userId != null) {
  //         scheduleViewModel.getScheduleList();
  //         return MainProvider();
  //       } else if (snapshot.hasData) {
  //         return HomeScreen();
  //       } else {
  //         return SplashScreen();
  //       }
  //     },
  //   );
  // }
  Widget _splashLoadingWidget(BuildContext context, AsyncSnapshot snapshot) {
    UserViewModel userViewModel = Provider.of<UserViewModel>(context, listen: false);
    ScheduleViewModel scheduleViewModel = Provider.of<ScheduleViewModel>(context, listen: false);
    if (snapshot.connectionState == ConnectionState.waiting) {
      return SplashScreen();
    } else {
      userViewModel.getUserProfile().then((isLoggedIn) {
        if (isLoggedIn) {
          scheduleViewModel.getScheduleList().then((success) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MainProvider()),
            );
          });
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      });
      return SplashScreen();
    }
  }

}
