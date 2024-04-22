import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../Schedule/ScheduleViewModel.dart';
import 'UserViewModel.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  static double screenWidth = 0;
  static double screenHeight = 0;
  String _textFieldValueEmail = ''; // final로 표시
  String _textFieldValuePassword = ''; // final로 표시
  String _textFieldValueCheckPassword = ''; // final로 표시
  String _textFieldValueNickName = ''; // final로 표시
  final GlobalKey<FormState> _formKeyEmail = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPassword = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyCheckPassword = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyNickName = GlobalKey<FormState>();
  List<TextEditingController> textControllers =
      List.generate(5, (index) => TextEditingController());

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
          decoration: BoxDecoration(color: Color(0xFFF2F2F2)),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 540 * screenWidth,
                    height: 1103 * screenHeight,
                    padding: EdgeInsets.only(
                        top: 74 * screenHeight,
                        left: 29 * screenWidth,
                        right: 29 * screenWidth),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        emailtext(context),
                        SizedBox(height: 33 * screenHeight),
                        SizedBox(
                          width: 63 * screenWidth,
                          height: 47 * screenHeight,
                          child: Text(
                            '이름',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Apple',
                              fontWeight: FontWeight.w100,
                              color: Colors.black,
                              fontSize: 18 * screenHeight,
                              height: 0,
                            ),
                          ),
                        ),
                        SizedBox(height: 33 * screenHeight),
                        Form(
                          key: _formKeyNickName,
                          child: inputbox("고잉고잉에서 사용할 이름을 입력해주세요.",
                              'assets/images/Group.png', 1),
                        ),
                        SizedBox(height: 33 * screenHeight),
                        SizedBox(
                          width: 83 * screenWidth,
                          height: 47 * screenHeight,
                          child: Text(
                            '이메일',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Apple',
                              fontWeight: FontWeight.w100,
                              color: Colors.black,
                              fontSize: 18 * screenHeight,
                              height: 0,
                            ),
                          ),
                        ),
                        SizedBox(height: 33 * screenHeight),
                        Form(
                          key: _formKeyEmail,
                          child: inputbox(
                              "이메일을 입력해주세요.", 'assets/images/Group16.png', 2),
                        ),
                        SizedBox(height: 33 * screenHeight),
                        SizedBox(
                          width: 99 * screenWidth,
                          height: 47 * screenHeight,
                          child: Text(
                            '비밀번호',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Apple',
                              fontWeight: FontWeight.w100,
                              color: Colors.black,
                              fontSize: 18 * screenHeight,
                              height: 0,
                            ),
                          ),
                        ),
                        SizedBox(height: 33 * screenHeight),
                        Form(
                          key: _formKeyPassword,
                          child: inputbox("비밀번호를 6자 이상 입력해주세요.",
                              'assets/images/lock.png', 3),
                        ),
                        SizedBox(height: 33 * screenHeight),
                        SizedBox(
                          width: 155 * screenWidth,
                          height: 47 * screenHeight,
                          child: Text(
                            '비밀번호 확인',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Apple',
                              fontWeight: FontWeight.w100,
                              color: Colors.black,
                              fontSize: 18 * screenHeight,
                              height: 0,
                            ),
                          ),
                        ),
                        SizedBox(height: 33 * screenHeight),
                        Form(
                          key: _formKeyCheckPassword,
                          child: inputbox("비밀번호를 한번 더 입력해주세요.",
                              'assets/images/lock.png', 4),
                        ),
                      ],
                    )),
                login_button(context)
              ]),
        ),
      ),
    );
  }

  Widget login_button(BuildContext context) {
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    ScheduleViewModel scheduleViewModel =
        Provider.of<ScheduleViewModel>(context);
    return Container(
        width: 540 * screenWidth,
        height: 97 * screenHeight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
                horizontal: 157 * screenWidth, vertical: 27 * screenHeight),
            backgroundColor: Color(0xFFFF4F4F),
            shape: RoundedRectangleBorder(
                //모서리를 둥글게
                borderRadius: BorderRadius.circular(0)),
            minimumSize: Size(
              482 * screenWidth,
              97 * screenHeight,
            ),
            alignment: Alignment.center,
          ),
          onPressed: () async {
            if (_formKeyNickName.currentState!.validate() &&
                _formKeyEmail.currentState!.validate() &&
                _formKeyPassword.currentState!.validate() &&
                _formKeyCheckPassword.currentState!.validate()) {
              print(_formKeyNickName);
              _formKeyNickName.currentState!.save();
              _formKeyEmail.currentState!.save();
              _formKeyPassword.currentState!.save();
              _formKeyCheckPassword.currentState!.save();

              print('입력 값: $_textFieldValuePassword');
              print('입력 값: $_textFieldValueEmail');
              bool? result = await userViewModel.addUser(
                  _textFieldValueNickName,_textFieldValueEmail,_textFieldValuePassword);
             Navigator.pop(context);
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
        ));
  }

  Widget emailtext(context) {
    return Container(
      width: 540 * screenWidth,
      height: 67 * screenHeight,
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
                Container(
                    height: 35 * screenHeight,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        'assets/icons/greybackbutton.svg',
                        width: 35 * screenWidth,
                        height: 35 * screenHeight,
                      ),
                    )),
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
              '이메일로 시작하기',
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
                  child: Stack(children: [
                    Image.asset(
                      path,
                    ),
                  ]),
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
                  return '이름을 입력하세요.';
                }
                // 추가적인 유효성 검사를 원하는 대로 수행할 수 있습니다.
                if (index == 2 && (value == null || value.isEmpty)) {
                  return '이메일을 입력하세요.';
                }
                if (index == 3) {
                  if ((value == null || value.isEmpty)) {
                    return '비밀번호를 입력하세요.';
                  }
                  if (value!.length < 6) {
                    return '6자 이상 입력해주세요';
                  }
                  _textFieldValuePassword = value;
                }
                if (index == 4) {
                  if (value == null || value.isEmpty) {
                    return '비밀번호를 한번 더 입력하세요.';
                  }
                  if (value.length < 6) {
                    return '6자 이상 입력해주세요';
                  } else if (value != _textFieldValuePassword) {
                    return '같은 비밀번호를 입력하세요.';
                  }
                }
                // 추가적인 유효성 검사를 원하는 대로 수행할 수 있습니다.
                return null;
              },
              obscureText: index == 3 || index == 4 ? true : false,
              inputFormatters: [
                if (index != 1)
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^[a-zA-Z0-9!@#\$%^&*(),.?":{}|<>/~`_+-=]+$')),
              ],
              onSaved: (value) {
                if (index == 1) {
                  _textFieldValueNickName = value!;
                }
                if (index == 2) {
                  _textFieldValueEmail = value!;
                }
                if (index == 3) {
                  _textFieldValuePassword = value!;
                }
                if (index == 4) {
                  _textFieldValueCheckPassword = value!;
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
          SizedBox(width: 20 * screenWidth),
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
}
