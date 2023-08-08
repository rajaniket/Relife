class PaymentDetailsModel {
  PaymentDetailsModel({
    required this.message,
    required this.details,
  });

  String message;
  Details details;

  factory PaymentDetailsModel.fromJson(Map<String, dynamic> json) =>
      PaymentDetailsModel(
        message: json["message"],
        details: Details.fromJson(json["details"]),
      );
}

class Details {
  Details({
    required this.planName,
    required this.validTill,
    required this.totalReferrals,
    this.currentSub,
    this.showCancelButton,
  });

  String planName;
  String validTill;
  int totalReferrals;
  CurrentSub? currentSub;
  bool? showCancelButton;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        planName: json["planName"],
        validTill: json["validTill"],
        totalReferrals: json["totalReferrals"],
        currentSub: json['currentSub'] != null
            ? CurrentSub.fromJson(json["currentSub"])
            : null,
        showCancelButton: json["showCancelButton"],
      );
}

class CurrentSub {
  CurrentSub({required this.status, required this.planName});

  String status;
  String planName;

  factory CurrentSub.fromJson(Map<String, dynamic> json) => CurrentSub(
        status: json["status"],
        planName: json["planName"],
      );
}
