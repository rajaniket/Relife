class GetSystemHabitsModel {
  final String message;
  final List<Details>? details;

  GetSystemHabitsModel({
    required this.message,
    this.details,
  });

  factory GetSystemHabitsModel.fromJson(Map<String, dynamic> json) =>
      GetSystemHabitsModel(
        message: json['message'],
        details: List<Details>.from(json["details"].map(
          (x) => Details.fromJson(x),
        )),
      );
}

class Details {
  final List<String>? reminderHabits;
  final List<String>? exactBehaviour;
  final bool active;
  final bool deleted;
  final String id;
  final String name;
  final String code;
  int totalUsersInThisHabit;
  int usersDoneThisToday;
  List<Leaderboard> leaderboard;
  final int? createdAt;
  final int? updatedAt;

  Details({
    this.reminderHabits,
    this.exactBehaviour,
    required this.active,
    required this.deleted,
    required this.id,
    required this.name,
    required this.code,
    this.createdAt,
    required this.totalUsersInThisHabit,
    required this.usersDoneThisToday,
    required this.leaderboard,
    this.updatedAt,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        active: json['active'],
        deleted: json['deleted'],
        id: json['_id'],
        name: json['name'],
        code: json['code'],
        createdAt: json['createdAt'],
        exactBehaviour: List<String>.from(json["exactBehaviour"].map((x) => x)),
        reminderHabits: List<String>.from(json["reminderHabits"].map((x) => x)),
        updatedAt: json['updatedAt'],
        totalUsersInThisHabit: json['totalUsersInThisHabit'],
        leaderboard: List<Leaderboard>.from(
            json["leaderboard"].map((x) => Leaderboard.fromJson(x))),
        usersDoneThisToday: json["usersDoneThisToday"],
      );
}

class Leaderboard {
  Leaderboard(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.postsCountInCurrentMonth,
      required this.profilePicture});

  String id;
  String firstName;
  String lastName;
  int postsCountInCurrentMonth;
  String profilePicture;

  factory Leaderboard.fromJson(Map<String, dynamic> json) => Leaderboard(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        postsCountInCurrentMonth: json["postsCountInCurrentMonth"],
        profilePicture: json["profilePicture"],
      );
}
