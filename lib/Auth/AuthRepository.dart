import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:goinggoing_flutterapp/JwtToken.dart';

import '../DataSource/LocalDataSource.dart';
import '../DataSource/RemoteDataSource.dart';
import '../User/User.dart';

class AuthRepository {
  late final RemoteDataSource _remoteDataSource;
  late final LocalDataSource _localDataSource;

  AuthRepository(){
    _remoteDataSource = RemoteDataSource();
    _localDataSource = LocalDataSource();}

  Future<String?> requestAndSaveToken(User user, String? deviceToken) async {
    final jwtToken = await _remoteDataSource.requestJwtToken(user,deviceToken!);
    if (jwtToken != null) {
      await _localDataSource.saveAccessToken(jwtToken.access_token!);
      await _localDataSource.saveRefreshToken(jwtToken.refresh_token!);
    }
    print(jwtToken!.access_token);
    return jwtToken!.access_token;
  }

  Future<String?> loadToken() async {
    return await _localDataSource.loadToken();
  }
  Future<String?> requestRefreshToken() async {
    String? refreshToken= await _localDataSource.loadRefreshToken();
    final jwtToken = await _remoteDataSource.refreshToken(refreshToken!);
    if (jwtToken != null) {
      await _localDataSource.saveAccessToken(jwtToken.access_token!);
      await _localDataSource.saveRefreshToken(jwtToken.refresh_token!);
    }
    if(jwtToken ==null){
      return null;
    }
    return jwtToken!.access_token;
  }


  Future<void> deleteToken() async {
    await _localDataSource.deleteToken();
  }
  Future<String?> postKakaoToken(String userNickName, String userEmail,String deviceToken) async {
    User user = User(userId : null, userEmail: userEmail, password: null, userNickName: userNickName, userType: 'kakao');
    final jwtToken = await _remoteDataSource.postKakaoToken(user,deviceToken);
    if (jwtToken != null) {
      await _localDataSource.saveAccessToken(jwtToken.access_token!);
      await _localDataSource.saveRefreshToken(jwtToken.refresh_token!);
    }
    print(jwtToken!.access_token);
    return jwtToken!.access_token;
  }
}
