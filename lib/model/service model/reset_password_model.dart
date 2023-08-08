class ResetPasswordRequestModel {
  String newPassword;
  String confirmPassword;

  ResetPasswordRequestModel({
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'new_password': newPassword,
      'confirm_password': confirmPassword,
    };
    return map;
  }
}

class ResetPasswordResponseModel {
  final String message;
  final Map<String, dynamic> details;

  ResetPasswordResponseModel({
    required this.message,
    required this.details,
  });

  factory ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      ResetPasswordResponseModel(
        message: json['message'],
        details: json['details'],
      );
}
