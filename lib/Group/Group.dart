class Group {

  int? userId;
  String? name;
  Group({this.userId, this.name});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(userId: json['userId'],name: json['userNickname']);
  }
}
