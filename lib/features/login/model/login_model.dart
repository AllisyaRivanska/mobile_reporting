class LoginModel {
  bool? success;
  String? message;
  LoginData? data;

  LoginModel({this.success, this.message, this.data});
  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? LoginData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class LoginData {
  String? accessToken;
  String? tokenType;
  User? user;

  LoginData({this.accessToken, this.tokenType, this.user});
  LoginData.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? nim;
  String? email;
  String? role;

  User({this.id, this.name, this.nim, this.email, this.role});
  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nim = json['nim'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['nim'] = nim;
    data['email'] = email;
    data['role'] = role;
    return data;
  }
}