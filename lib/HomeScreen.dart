import 'package:flutter/material.dart';
import 'package:goinggoing_flutterapp/Auth/AuthService.dart';
import 'package:goinggoing_flutterapp/User/LoginScreen.dart';
import 'package:goinggoing_flutterapp/User/RegisterScreen.dart';
import 'package:provider/provider.dart';

import 'PageServuce.dart';
import 'ProviderPage.dart';
import 'Schedule/ScheduleViewModel.dart';
import 'User/UserViewModel.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  static double screenWidth = 0;
  static double screenHeight = 0;
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    ScheduleViewModel scheduleViewModel = Provider.of<ScheduleViewModel>(context);
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);

    screenWidth = MediaQuery.of(context).size.width / 540;
    screenHeight = MediaQuery.of(context).size.height / 1200;
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: 540 * screenWidth,
          height: 1200 * screenHeight,
          decoration: BoxDecoration(color: Color(0xFFDCFF5C)),
          padding: EdgeInsets.symmetric(vertical: 105 * screenHeight),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 540 * screenWidth,
                height: screenHeight * 172,
                padding: EdgeInsets.symmetric(horizontal: 29 * screenWidth),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 40 * screenHeight,
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        'assets/images/Vector.png',
                        height: 40 * screenHeight,
                      ),
                    ),
                    SizedBox(
                      height: 27 * screenHeight,
                    ),
                    Container(
                      child: Text(
                        'Welcome!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25 * screenWidth,
                          fontFamily: 'Apple',
                          fontWeight: FontWeight.w100,
                          height: 0,
                        ),
                      ),
                    ),
                    Container(
                      width: 10 * screenHeight,
                    ),
                    Container(
                      height: 18 * screenHeight,
                      child: FittedBox(
                        child: Text(
                          '효율적인 외출시간 관리 서비스,',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14 * screenHeight,
                            fontFamily: 'Apple',
                            fontWeight: FontWeight.w100,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                    Container(
                        height: 18 * screenHeight,
                        child: FittedBox(
                          child: Text(
                            '고잉고잉이에요.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14 * screenHeight,
                              fontFamily: 'Apple',
                              fontWeight: FontWeight.w100,
                              height: 1.5,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                width: 540 * screenWidth,
                height: 477 * screenHeight,
                alignment: Alignment.centerRight,
                child: Image.asset(
                  'assets/images/rabbit.png',
                ),
              ),
              Container(
                width: 540 * screenWidth,
                height: 279 * screenHeight,
                padding: EdgeInsets.symmetric(
                    horizontal: 24 * screenWidth, vertical: 18 * screenHeight),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 450 * screenWidth,
                      height: 70 * screenHeight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF191919)),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 26 * screenHeight,
                              height: 26 * screenHeight,
                              child: Image.asset(
                                'assets/images/email.png',
                              ),
                            ),
                            Flexible(
                              child: Center(
                                child: Text(
                                  '이메일로 시작하기',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23.50 * screenHeight,
                                    fontFamily: 'Apple',
                                    fontWeight: FontWeight.w100,
                                    height: 0,
                                  ),
                                ),
                              ),
                              fit: FlexFit.loose,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 22 * screenHeight,
                    ),
                    Container(
                      width: 450 * screenWidth,
                      height: 70 * screenHeight,
                      child: ElevatedButton(
                        onPressed: () async{
                          if(await authService.signInWithKakao()){
                            bool success = await userViewModel.getUserProfile();
                            await scheduleViewModel.getScheduleList();
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MainProvider()),
                            );
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFFEE500)),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 26 * screenHeight,
                              height: 26 * screenHeight,
                              child: Image.asset(
                                'assets/images/KAKAO.png',
                              ),
                            ),
                            Flexible(
                              child: Center(
                                child: Text(
                                  '카카오로 시작하기',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 23.50 * screenHeight,
                                    fontFamily: 'Apple',
                                    fontWeight: FontWeight.w100,
                                    height: 0,
                                  ),
                                ),
                              ),
                              fit: FlexFit.loose,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 15.0 * screenHeight,
                    ),
                    Container(
                        width: 150 * screenWidth,
                        height: 22.0 * screenHeight,
                        child: Column(
                          children: [
                            Container(
                              width: 150 * screenWidth,
                              height: 16.0 * screenHeight,
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterScreen(),
                                      ),
                                    );
                                    print('이미 계정을 만들었어요 버튼이 클릭되었습니다!');
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Text(
                                      '이미 계정을 만들었어요.',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.grey,
                                        fontSize: 13 * screenHeight,
                                        fontFamily: 'Apple',
                                        fontWeight: FontWeight.w100,
                                        height: 0,
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget kakao_button() {
    return Container(
      width: 448 * screenWidth,
      height: 80 * screenHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFEE500),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          alignment: Alignment.centerLeft,
        ),
        onPressed: () {},
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 26,
                      height: 26,
                      child: Image.asset('assets/images/KAKAO.png')),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: screenWidth * 0.2347),
                        Text('이메일로 시작하기',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Apple',
                              fontWeight: FontWeight.w100,
                              height: 0,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
