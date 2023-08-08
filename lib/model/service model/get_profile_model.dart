class ViewProfileResponseModel {
  final String message;
  final ProfileDetails details;

  ViewProfileResponseModel({
    required this.message,
    required this.details,
  });

  factory ViewProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      ViewProfileResponseModel(
        message: json['message'],
        details: ProfileDetails.fromJson(json['details']),
      );
}

class ProfileDetails {
  final String firstName;
  final String lastName;
  final String username;
  final String? phoneNUmber;
  // final String? countryCode;
  final String? profilePicture;
  final String? bio;
  final String? referralLink;
  List<Graph>? graph;
  List<Habit> habits;

  ProfileDetails(
      {this.referralLink,
      required this.firstName,
      required this.lastName,
      required this.username,
      required this.phoneNUmber,
      // required this.countryCode,
      required this.profilePicture,
      required this.bio,
      required this.habits,
      this.graph});

  factory ProfileDetails.fromJson(Map<String, dynamic> json) => ProfileDetails(
        firstName: json['firstName'],
        lastName: json['lastName'],
        username: json['username'],
        phoneNUmber: json['phoneNUmber'],
        // countryCode: json['countryCode'],
        profilePicture: json['profilePicture'],
        bio: json['bio'],
        referralLink: json['referralLink'],
        habits: List<Habit>.from(json["habits"].map((x) => Habit.fromJson(x))),
        graph: List<Graph>.from(json["graph"].map((x) => Graph.fromJson(x))),
      );
}

class Graph {
  Graph({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.value,
  });

  String date;
  int startTime;
  int endTime;
  double value;

  factory Graph.fromJson(Map<String, dynamic> json) => Graph(
        date: json["date"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        value: json["value"].toDouble(),
      );
}

class Habit {
  Habit({
    required this.habitDetails,
  });
  HabitDetails habitDetails;

  factory Habit.fromJson(Map<String, dynamic> json) => Habit(
        habitDetails: HabitDetails.fromJson(json["habitDetails"]),
      );
}

class HabitDetails {
  HabitDetails({
    required this.name,
    required this.leaderboardRank,
  });
  String name;
  int leaderboardRank;

  factory HabitDetails.fromJson(Map<String, dynamic> json) => HabitDetails(
        name: json["name"],
        leaderboardRank: json["leaderboardRank"],
      );
}
