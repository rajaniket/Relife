class ReferralRegisterModel {
  ReferralRegisterModel({
    required this.firstName,
    required this.username,
    required this.password,
    required this.confirmPassword,
    required this.lastName,
  });

  String firstName;
  String lastName;
  String username;
  String password;
  String confirmPassword;

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "username": username,
        "password": password,
        "confirmPassword": confirmPassword,
      };
}
