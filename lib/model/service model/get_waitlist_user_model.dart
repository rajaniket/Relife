class GetWaitlistUserModel {
  GetWaitlistUserModel({
    required this.message,
    required this.details,
  });

  String? message;
  Details details;

  factory GetWaitlistUserModel.fromJson(Map<String, dynamic> json) =>
      GetWaitlistUserModel(
        message: json["message"],
        details: Details.fromJson(json["details"]),
      );
}

class Details {
  Details({
    required this.firstName,
    this.lastName,
    required this.username,
    this.phoneNumber,
    this.countryCode,
  });

  String firstName;
  String? lastName;
  String username;
  int? phoneNumber;
  int? countryCode;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        firstName: json["firstName"],
        lastName: json["lastName"],
        username: json["username"],
        phoneNumber: json["phoneNumber"],
        countryCode: json["countryCode"],
      );
}
