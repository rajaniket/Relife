class PaymentModel {
  PaymentModel({
    required this.message,
    required this.details,
  });

  String message;
  Details details;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        message: json["message"],
        details: Details.fromJson(json["details"]),
      );
}

class Details {
  Details({
    required this.shortUrl,
  });

  String shortUrl;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        shortUrl: json["short_url"],
      );
}
