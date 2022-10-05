class LoginResponse {
  bool? status;
  String? message;
  UserInfo? data;

  LoginResponse.toJson(Map<String, dynamic>? json) {
    status = json?['status'];
    message = json?['message'];
    data = UserInfo.fromJson(json?['data']);
  }
}

class UserInfo {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserInfo.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    name = json?['name'];
    email = json?['email'];
    phone = json?['phone'];
    image = json?['image'];
    points = json?['points'];
    credit = json?['credit'];
    token = json?['token'];
  }
}
