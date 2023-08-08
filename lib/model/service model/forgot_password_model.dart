class ForgortPasswordRequestModel {
  String email;

  ForgortPasswordRequestModel({
    required this.email,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.trim(),
    };
    return map;
  }
}

class ForgotPasswordResponseModel {
  final String message;
  final Map<String, dynamic> details;

  ForgotPasswordResponseModel({
    required this.message,
    required this.details,
  });

  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResponseModel(
        message: json['message'],
        details: json['details'],
      );
}
