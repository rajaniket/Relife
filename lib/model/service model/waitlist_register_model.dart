class WaitlistRegisterModel {
  WaitlistRegisterModel({
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.confirmPassword,
    required this.phoneNumber,
    required this.countryCode,
  });

  String firstName;
  String lastName;
  String password;
  String confirmPassword;
  String phoneNumber;
  String countryCode;

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "password": password,
        "confirmPassword": confirmPassword,
        "phoneNumber": phoneNumber,
        "countryCode": countryCode
      };
}
