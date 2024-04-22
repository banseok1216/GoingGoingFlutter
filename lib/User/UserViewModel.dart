import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:goinggoing_flutterapp/User/UserRepository.dart';

import '../Auth/AuthRepository.dart';
import 'User.dart';

class UserViewModel with ChangeNotifier {
  late final AuthRepository _authRepository;
  late final UserRepository _userRepository;
  late User _user  = User(
      userId: null,
      userEmail: null,
      password: null,
      userNickName: null,
      userType: null);

  User? get user => _user;

  UserViewModel() {
    _authRepository = AuthRepository();
    _userRepository = UserRepository();
  }

  Future<String?> getJwtToken(String Email, String Password) async {
    final deviceToken = await getMyDeviceToken();
    final User user = User(
       userId: null,
        userEmail: Email,
        password: Password,
        userNickName: null,
        userType: null);
    return await _authRepository.requestAndSaveToken(user,deviceToken);
  }

  Future<bool?> addUser(String Nickname, String Email, String Password) async {
    final User user = User(
        userId: null,
        userEmail: Email,
        password: Password,
        userNickName: Nickname,
        userType: 'goinggoing');
    return await _userRepository.addUser(user);
  }

  Future<bool> getUserProfile() async {
    final token = await _authRepository.loadToken();
    if(token != null) {
      User? user = await _userRepository.getUserProfile(token);
      if(user ==null){
          final token = await _authRepository.requestRefreshToken();
          if(token == null){
            return false;
          }
          user = await _userRepository.getUserProfile(token);
          if(user ==null){
            return false;
          }
          else{
            _user = user;
            return true;
          }
      }
      else{
        _user = user;
        return true;
      }
    }
    return false;
  }

  Future<String?> getMyDeviceToken() async {
    return await FirebaseMessaging.instance.getToken();
  }
}
