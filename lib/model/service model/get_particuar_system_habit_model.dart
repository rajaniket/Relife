class GetParticularSysytemHabitModel {
  GetParticularSysytemHabitModel({
    required this.message,
    required this.details,
  });

  String message;
  Details details;

  factory GetParticularSysytemHabitModel.fromJson(Map<String, dynamic> json) =>
      GetParticularSysytemHabitModel(
        message: json["message"],
        details: Details.fromJson(json["details"]),
      );
}

class Details {
  Details({
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
    required this.detailsId,
    required this.totalUsersInThisHabit,
    required this.usersDoneThisToday,
    required this.leaderboard,
  });

  List<String> reminderHabits;
  List<String> exactBehaviour;
  List<dynamic> reward;
  bool active;
  bool deleted;
  String id;
  String name;
  String code;
  int createdAt;
  int updatedAt;
  int v;
  String detailsId;
  int totalUsersInThisHabit;
  int usersDoneThisToday;
  List<Leaderboard> leaderboard;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        reminderHabits: List<String>.from(json["reminderHabits"].map((x) => x)),
        exactBehaviour: List<String>.from(json["exactBehaviour"].map((x) => x)),
        reward: List<dynamic>.from(json["reward"].map((x) => x)),
        active: json["active"],
        deleted: json["deleted"],
        id: json["_id"],
        name: json["name"],
        code: json["code"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
        detailsId: json["id"],
        totalUsersInThisHabit: json["totalUsersInThisHabit"],
        usersDoneThisToday: json["usersDoneThisToday"],
        leaderboard: List<Leaderboard>.from(
            json["leaderboard"].map((x) => Leaderboard.fromJson(x))),
      );
}

class Leaderboard {
  Leaderboard({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.postsCountInCurrentMonth,
    this.profilePicture,
  });

  String id;
  String firstName;
  String lastName;
  int postsCountInCurrentMonth;
  String? profilePicture;

  factory Leaderboard.fromJson(Map<String, dynamic> json) => Leaderboard(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        postsCountInCurrentMonth: json["postsCountInCurrentMonth"],
        profilePicture: json["profilePicture"],
      );
}
