class User {
  int? id;
  String? name;
  String? email;
  String? token;

  User({
    this.id,
    this.name,
    this.email,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'], 
      name: json['name'], 
      email: json['email'],
      token: json['token']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['token'] = token;
    return data;
  }
}
