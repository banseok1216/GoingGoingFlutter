import 'package:flutter/material.dart';
import 'package:goinggoing_flutterapp/Calender/CalenderScreen.dart';
import 'package:goinggoing_flutterapp/HomeScreen.dart';
import 'package:goinggoing_flutterapp/LoadingViewModel.dart';
import 'package:goinggoing_flutterapp/ProviderPage.dart';
import 'package:goinggoing_flutterapp/Schedule/ScheduleViewModel.dart';
import 'package:provider/provider.dart';

import '../Calender/CustomCalenderController.dart';
import '../PageServuce.dart';
import '../Schedule/ScheduleDetailScreen.dart';
import '../Schedule/ScheduleAddScreen.dart';
import 'UserViewModel.dart';
List<TextEditingController> textControllers = List.generate(3, (index) => TextEditingController());


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  static double screenWidth = 0;
  static double screenHeight = 0;
  final GlobalKey<FormState> _formKeyEmail = GlobalKey<FormState>();
  String _textFieldValueEmail = ''; // final로 표시
  final GlobalKey<FormState> _formKeyPassword = GlobalKey<FormState>();
  String _textFieldValuePassword = ''; // final로 표시

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width / 540;
    screenHeight = MediaQuery.of(context).size.height / 1200;
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: 540 * screenWidth,
          height: 1200 * screenHeight,
          padding: EdgeInsets.symmetric(vertical: 48 * screenHeight),
          decoration: BoxDecoration(color: Color(0xFFF2F2F2)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              emailtext(context),
              SizedBox(height: 307 * screenHeight),
              Container(
                width: 482 * screenWidth,
                height: 400 * screenHeight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                      key: _formKeyEmail,
                      child: inputbox(
                          "이메일을 입력해주세요.", 'assets/images/Group16.png', 1),
                    ),
                    SizedBox(height: 30 * screenHeight),
                    Form(
                      key: _formKeyPassword,
                      child: inputbox(
                          "비밀번호를 6자 이상 입력해주세요.", 'assets/images/lock.png', 2),
                    ),
                    SizedBox(height: 30 * screenHeight),
                    login_button(context),
                    SizedBox(height: 30 * screenHeight),
                    Container(
                      height: 22.43 * screenHeight,
                      child: Stack(
                        children: [
                          Positioned(
                            child: Text(
                              textAlign: TextAlign.center,
                              '새로운 계정을 만들고 싶어요.',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.black,
                                fontSize: 11 * screenHeight,
                                fontFamily: 'Apple',
                                fontWeight: FontWeight.w100,
                                height: 0,
                              ),
                            ),
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
    );
  }

  Widget emailtext(BuildContext context) {
    return Container(
      width: 540 * screenWidth,
      height: 67 * screenHeight,
      padding: EdgeInsets.symmetric(horizontal: 30 * screenWidth),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 35 * screenWidth,
            height: 35 * screenHeight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/images/back_vector.png',width: 35 * screenWidth,
                      height: 35 * screenHeight,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
              fit: FlexFit.tight, child: SizedBox(width: 80 * screenWidth)),
          Container(
            width: 216 * screenWidth,
            height: 48 * screenHeight,
            alignment: Alignment.center,
            child: Text(
              '이메일로 로그인',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18 * screenHeight,
                fontFamily: 'Apple',
                fontWeight: FontWeight.w100,
                height: 0,
              ),
            ),
          ),
          Flexible(
              fit: FlexFit.tight, child: SizedBox(width: 80 * screenWidth)),
          Container(
            width: 35 * screenWidth,
            height: 35 * screenHeight,
          ),
        ],
      ),
    );
  }

  Widget inputbox(String text, String path, int index) {
    return Container(
      width: 482 * screenWidth,
      height: 88 * screenHeight,
      padding: EdgeInsets.symmetric(horizontal: 26 * screenWidth),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.70 * screenWidth),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 35 * screenWidth,
            height: 35 * screenHeight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 16.40 * screenWidth,
                  height: 22.47 * screenHeight,
                  child: Image.asset(
                    path,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 20 * screenWidth),
          Container(
            width: 300 * screenWidth,
            alignment: Alignment.center,
            child: TextFormField(
              controller: textControllers[index],
              validator: (value) {
                if (index == 1 && (value == null || value.isEmpty)) {
                  return '이메일을 입력하세요.';
                }
                // 추가적인 유효성 검사를 원하는 대로 수행할 수 있습니다.
                if (index == 2 && (value == null || value.isEmpty)) {
                  return '비밀번호를 입력하세요.';
                }
                // 추가적인 유효성 검사를 원하는 대로 수행할 수 있습니다.
                return null;
              },
              obscureText: index == 2 ? true : false,
              onSaved: (value) {
                if (index == 1) {
                  _textFieldValueEmail = value!;
                }
                if (index == 2) {
                  _textFieldValuePassword = value!;
                }
              },
              style: TextStyle(
                color: Colors.black,
                fontSize: 15 * screenHeight,
                fontFamily: 'Apple',
                fontWeight: FontWeight.w100,
                height: 0,
              ),
              decoration: InputDecoration(
                hintText: text,
                // 플레이스홀더 텍스트
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 15 * screenHeight,
                  fontFamily: 'Apple',
                  fontWeight: FontWeight.w100,
                  height: 0,
                ),
                errorStyle: TextStyle(
                  color: Colors.red, // 에러 메시지의 글자 색상
                  fontSize: 10 * screenHeight, // 에러 메시지의 글자 크기
                  fontFamily: 'Apple', // 에러 메시지의 글꼴
                ),
                enabledBorder: InputBorder.none,
                // 비활성화 상태의 선을 없앰
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 8), // 여유 공간
          // 에러 메시지를 표시할 상자
          Container(
            width: 35 * screenWidth,
            height: 35 * screenHeight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    textControllers[index].clear();
                  },
                  child: Container(
                    width: 22 * screenWidth,
                    height: 22 * screenWidth,
                    child: Image.asset(
                      'assets/images/xbutton.png',
                      width: 22 * screenWidth,
                      height: 22 * screenWidth,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget login_button(BuildContext context) {
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    ScheduleViewModel scheduleViewModel = Provider.of<ScheduleViewModel>(context);
LoadingViewModel loadingViewModel =Provider.of<LoadingViewModel>(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
            horizontal: 157 * screenWidth, vertical: 27 * screenHeight),
        backgroundColor: Color(0xFFFF4F4F),
        shape: RoundedRectangleBorder(
            //모서리를 둥글게
            borderRadius: BorderRadius.circular(7)),
        minimumSize: Size(
          482 * screenWidth,
          97 * screenHeight,
        ),
        alignment: Alignment.center,
      ),
      onPressed: () async {
        if (_formKeyEmail.currentState!.validate() &&
            _formKeyPassword.currentState!.validate()) {
          _formKeyEmail.currentState!.save();
          _formKeyPassword.currentState!.save();

          print('입력 값: $_textFieldValuePassword');
          print('입력 값: $_textFieldValueEmail');
          String? result = await userViewModel.getJwtToken(_textFieldValueEmail,_textFieldValuePassword);
          if (result != null) {
            bool success = await userViewModel.getUserProfile();
            await scheduleViewModel.getScheduleList();
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainProvider()),
            );
          } else {
            // 실패 시 처리
            print('Token 발급 실패: $result');
          }
        }
      },
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 70 * screenWidth,
                  height: 30 * screenHeight,
                  child: Text(
                    '로그인',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Apple',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFFF2F2F2),
                      fontSize: 15,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
          ]),
    );
  }
}
