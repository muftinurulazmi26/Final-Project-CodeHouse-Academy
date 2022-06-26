import 'package:airsoft_app/model/user.dart';

class Auth {
  bool? success;
  String? message;
  User? results;

  Auth({
    this.success,
    this.message,
    this.results,
  });

  Auth.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (success!) {
      results = User.fromJson(json['data']);
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (results != null) {
      data['data'] = results!.toJson();
    }
    data['message'] = message;

    return data;
  }
}
