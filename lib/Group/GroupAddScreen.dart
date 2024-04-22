import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GroupAddScreen extends StatelessWidget {
  static double screenWidth = 0;
  static double screenHeight = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width / 540;
    screenHeight = MediaQuery.of(context).size.height / 1200;
    return Scaffold(
      body: Container(
        width: 540 * screenWidth,
        height: 1200 * screenHeight,
        padding: EdgeInsets.symmetric(
            horizontal: 28 * screenWidth, vertical: 48 * screenHeight),
        child: Column(
          children: [
            firstFrame(context),
            SizedBox(
              height: 29 * screenHeight,
            ),
            secondFrame(),
            SizedBox(
              height: 29 * screenHeight,
            ),
            Container(
              padding: EdgeInsets.zero, // 또는 EdgeInsets.all(0)으로 설정 가능
              child: Divider(
                color: Color(0xFF9C9B98),
                thickness: 2, // 굵기 조정
                height: 2 * screenHeight,
              ),
            ),
            SizedBox(
              height: 29 * screenHeight,
            ),
            thirdFrame(),
            SizedBox(
              height: 29 * screenHeight,
            ),
            kakaoBtn(),
            SizedBox(
              height: 17 * screenHeight,
            ),
            linkBtn()
          ],
        ),
      ),
    );
  }

  Widget kakaoBtn() {
    return Container(
      width: 450 * screenWidth,
      height: 70 * screenHeight,
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFEE500)),
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
                  '카카오로 초대하기',
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
    );
  }

  Widget linkBtn() {
    return Container(
      width: 450 * screenWidth,
      height: 70 * screenHeight,
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF191919)),
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
                  '초대 링크 복사하기',
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
            )
          ],
        ),
      ),
    );
  }

  Widget thirdFrame() {
    return Container(
      width: 484 * screenWidth,
      height: 195.17 * screenHeight,
      padding: EdgeInsets.only(
        top: 31 * screenHeight,
        left: 22 * screenWidth,
        right: 203 * screenWidth,
        bottom: 31 * screenHeight,
      ),
      decoration: ShapeDecoration(
        color: Color(0xFFDCFF5C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: 136 * screenWidth,
            height: 53 * screenHeight,
            child: Image.asset('assets/images/3players.png'),
          ),
          SizedBox(height: 10 * screenHeight),
          Container(
            width: 263 * screenWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 86.94 * screenWidth,
                  height: 18.17 * screenHeight,
                  child: Text(
                    'going TIP!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10 * screenHeight,
                      fontFamily: 'Apple',
                      fontWeight: FontWeight.w100,
                      height: 0,
                    ),
                  ),
                ),
                SizedBox(height: 11 * screenHeight),
                SizedBox(
                  width: 263 * screenWidth,
                  height: 41 * screenHeight,
                  child: Text(
                    '일행과 외출 준비 상태를 공유하여\n약속 시간을 유연하게 조정할 수 있어요.',
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 10 * screenHeight,
                      fontFamily: 'Apple',
                      fontWeight: FontWeight.w100,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget secondFrame() {
    return Container(
      width: 484 * screenWidth,
      height: 49 * screenHeight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/blackrabbit.svg',
            width: 38 * screenWidth,
            height: 49 * screenHeight,
          ),
          const SizedBox(width: 8),
          Center(
            child: Text(
              '일행을 추가할 수 있어요.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18 * screenHeight,
                fontFamily: 'Apple',
                fontWeight: FontWeight.w100,
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget firstFrame(context) {
    return Container(
        width: 484 * screenWidth,
        height: 49 * screenHeight,
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 49 * screenHeight,
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
              Flexible(
                child: Container(),
                fit: FlexFit.loose,
              ),
            ]));
  }
}
