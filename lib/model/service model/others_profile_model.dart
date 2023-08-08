class OthersProfileModel {
  OthersProfileModel({
    required this.message,
    required this.details,
  });

  String message;
  Details details;

  factory OthersProfileModel.fromJson(Map<String, dynamic> json) =>
      OthersProfileModel(
        message: json["message"],
        details: Details.fromJson(json["details"]),
      );
}

class Details {
  Details({
    required this.firstName,
    required this.lastName,
    required this.username,
    this.phoneNumber,
    //  required this.countryCode,
    this.profilePicture,
    this.bio,
    required this.referralLink,
    this.graph,
    required this.habits,
  });

  String firstName;
  String lastName;
  String username;
  String? phoneNumber;
  //String countryCode;
  String? profilePicture;
  String? bio;
  String referralLink;
  List<Graph>? graph;
  List<Habit> habits;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        firstName: json["firstName"],
        lastName: json["lastName"],
        username: json["username"],
        phoneNumber: json["phoneNumber"],
        //  countryCode: json["countryCode"],
        profilePicture: json["profilePicture"],
        bio: json["bio"],
        referralLink: json["referralLink"],
        graph: List<Graph>.from(json["graph"].map((x) => Graph.fromJson(x))),
        habits: List<Habit>.from(json["habits"].map((x) => Habit.fromJson(x))),
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
    required this.active,
    required this.deleted,
    required this.id,
    required this.habitDetails,
    required this.reminderHabit,
    required this.exactBehaviour,
    required this.reward,
    required this.reminderTime,
    required this.daysPerMonth,
    required this.punishment,
    required this.accountabilityPartnerName,
    required this.accountabilityPartnerPhoneNumber,
    //required this.accountabilityPartnerCountryCode,
    required this.createdAt,
    required this.updatedAt,
    required this.habitId,
  });

  bool active;
  bool deleted;
  String id;
  HabitDetails habitDetails;
  String reminderHabit;
  String exactBehaviour;
  String reward;
  int reminderTime;
  int daysPerMonth;
  String punishment;
  String accountabilityPartnerName;
  String accountabilityPartnerPhoneNumber;
  //String accountabilityPartnerCountryCode;
  int createdAt;
  int updatedAt;
  String habitId;

  factory Habit.fromJson(Map<String, dynamic> json) => Habit(
        active: json["active"],
        deleted: json["deleted"],
        id: json["_id"],
        habitDetails: HabitDetails.fromJson(json["habitDetails"]),
        reminderHabit: json["reminderHabit"],
        exactBehaviour: json["exactBehaviour"],
        reward: json["reward"],
        reminderTime: json["reminderTime"],
        daysPerMonth: json["daysPerMonth"],
        punishment: json["punishment"],
        accountabilityPartnerName: json["accountabilityPartnerName"],
        accountabilityPartnerPhoneNumber:
            json["accountabilityPartnerPhoneNumber"],
        // accountabilityPartnerCountryCode:
        //     json["accountabilityPartnerCountryCode"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        habitId: json["id"],
      );
}

class HabitDetails {
  HabitDetails({
    required this.reminderHabits,
    required this.exactBehaviour,
    required this.reward,
    required this.active,
    required this.deleted,
    required this.id,
    required this.name,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.habitDetailsId,
    required this.leaderboardRank,
  });

  List<String> reminderHabits;
  List<String> exactBehaviour;
  List<String> reward;
  bool active;
  bool deleted;
  String id;
  String name;
  String code;
  int createdAt;
  int updatedAt;
  int v;
  String habitDetailsId;
  int leaderboardRank;

  factory HabitDetails.fromJson(Map<String, dynamic> json) => HabitDetails(
        reminderHabits: List<String>.from(json["reminderHabits"].map((x) => x)),
        exactBehaviour: List<String>.from(json["exactBehaviour"].map((x) => x)),
        reward: List<String>.from(json["reward"].map((x) => x)),
        active: json["active"],
        deleted: json["deleted"],
        id: json["_id"],
        name: json["name"],
        code: json["code"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
        habitDetailsId: json["id"],
        leaderboardRank: json["leaderboardRank"],
      );
}
