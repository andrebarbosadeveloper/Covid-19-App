class LoginModel {
  final int id;
  final String password;
  final String email;

  LoginModel({this.id, this.password, this.email});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        id:json['id'], password: json['password'], email: json['email']);
  }
}
