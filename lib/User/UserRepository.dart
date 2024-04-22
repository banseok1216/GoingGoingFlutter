import 'package:goinggoing_flutterapp/User/User.dart';

import '../DataSource/RemoteDataSource.dart';

class UserRepository {
  final RemoteDataSource _remoteDataSource = RemoteDataSource();
  Future<User?> getUserProfile(String? token) {
    return _remoteDataSource.getUserProfile(token!);
  }
  Future<bool> addUser(User user) async {
    final bool success = await _remoteDataSource.addUser(user);
    return success;
  }
}
