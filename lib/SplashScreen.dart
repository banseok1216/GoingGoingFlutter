import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      height: screenHeight,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.06,
        vertical: screenHeight * 0.03,
      ),
      decoration: BoxDecoration(color: Color(0xFFDCFF5C)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.07,
              vertical: screenHeight * 0.07,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.015),
                Container(
                  width: screenWidth * 0.3,
                  height: screenHeight * 0.2,
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidth * 0.195,
                        height: screenHeight * 0.035,
                        child:  Image.asset('assets/images/Vector.png'),
                      ),
                      Container(
                        width: screenWidth * 0.195,
                        height: screenHeight * 0.035,
                        child: Image.asset('assets/images/going.png'),
                      ),
                      Container(
                        width: screenWidth * 0.195,
                        height: screenHeight * 0.035,
                        child: Image.asset('assets/images/going.png'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
