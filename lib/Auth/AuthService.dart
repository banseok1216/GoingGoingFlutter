import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:goinggoing_flutterapp/Auth/AuthRepository.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class AuthService{

  late AuthRepository _authRepository;

  AuthService() {
    _authRepository = AuthRepository();
  }

  Future<bool> signInWithKakao() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();

      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      final url = Uri.https('kapi.kakao.com', '/v2/user/me');

      final response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
        },
      );
      final profileInfo = json.decode(response.body);
      print(profileInfo.toString());
      String nickname = profileInfo['properties']['nickname'];
      String email = profileInfo['kakao_account']['email'];
      final deviceToken = await getMyDeviceToken();
      _authRepository.postKakaoToken(nickname,email,deviceToken!);
      return true;
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');
      return false;
    }
  }
  Future<String?> getMyDeviceToken() async {
    return await FirebaseMessaging.instance.getToken();
  }
}