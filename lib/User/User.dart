class User {
  final int? userId;
  final String? userEmail;
  final String? password;
  final String? userNickName; // 사용자 정보
  final String? userType;

  User({
    required this.userId,
    required this.userEmail,
    required this.password,
    required this.userNickName,
    required this.userType,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userId: json['userId'],
        userEmail: json['userEmail'],
        password: json['password'],
        userNickName: json['userNickname'],
        userType: json['userType']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
      'password': password,
      'userNickname': userNickName,
      'userType': userType,
    };
  }
}
