class LoginResponseModel {
  final String? message;
  final Map<String, dynamic> details;

  LoginResponseModel({
    required this.message,
    required this.details,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(message: json['message'], details: json['details']);
}

class Details {
  final String? token;
  final String name;
  final String type;
  final String referralLink;

  Details({
    required this.token,
    required this.name,
    required this.type,
    required this.referralLink,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
      token: json['token'],
      name: json['name'],
      type: json['type'],
      referralLink: json['referralLink']);
}

class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': email.trim(),
      'password': password.trim(),
    };
    return map;
  }
}
