class ErrorRes {
  bool? success;
  String? data;
  String? statusMessage;
  ErrorRes({
    this.success,
    this.data,
    this.statusMessage,
  });

  ErrorRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    statusMessage = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['data'] = this.data;
    data['message'] = statusMessage;
    return data;
  }
}
