class JwtToken {
  final String? access_token;
  final String? refresh_token;// 사용자 정보

  JwtToken({
    required this.access_token,
    required this.refresh_token,
  });

  factory JwtToken.fromJson(Map<String, dynamic> json) {
    return JwtToken(
      access_token: json['access_token'],
      refresh_token: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userEmail': access_token,
      'password': refresh_token,
    };
  }
}