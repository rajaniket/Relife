class UpdateProfileModel {
  String bio;

  UpdateProfileModel({
    required this.bio,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'bio': bio,
    };
    return map;
  }
}
