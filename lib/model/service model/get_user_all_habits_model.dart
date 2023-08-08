class GetUserAllHabitsModel {
  GetUserAllHabitsModel({
    required this.message,
    required this.details,
  });

  String message;
  List<Detail> details;

  factory GetUserAllHabitsModel.fromJson(Map<String, dynamic> json) =>
      GetUserAllHabitsModel(
        message: json["message"],
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
      );
}

class Detail {
  Detail({
    required this.reminderDays,
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
    required this.accountabilityPartnerPhoneNumber,
    required this.accountabilityPartnerName,
    required this.createdAt,
    required this.updatedAt,
    required this.detailId,
    required this.currentStreak,
    required this.longestStreak,
    required this.thisMonth,
    required this.tillDate,
    required this.toReachYourGoal,
    this.streakData,
  });
  List<int> reminderDays;
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
  String accountabilityPartnerPhoneNumber;
  String accountabilityPartnerName;
  int createdAt;
  int updatedAt;
  String detailId;
  int currentStreak;
  int longestStreak;
  int thisMonth;
  int tillDate;
  int toReachYourGoal;
  List<StreakDatum>? streakData;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        reminderDays: json['reminderDays'].cast<int>(),
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
        accountabilityPartnerPhoneNumber:
            json["accountabilityPartnerPhoneNumber"],
        accountabilityPartnerName: json["accountabilityPartnerName"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        detailId: json["id"],
        currentStreak: json['currentStreak'],
        longestStreak: json['longestStreak'],
        thisMonth: json['thisMonth'],
        tillDate: json['tillDate'],
        toReachYourGoal: json['toReachYourGoal'],
        streakData: List<StreakDatum>.from(
            json["streakData"].map((x) => StreakDatum.fromJson(x))),
      );
}

class StreakDatum {
  StreakDatum({
    required this.author,
    //  required this.commentsCount,
    required this.content,
    required this.contentType,
    required this.createdAt,
    required this.id,
    // required this.myReactions,
    //  required this.reactionsCount,
    required this.source,
    required this.status,
    required this.statusUpdatedAt,
  });

  Author author;
  // int? commentsCount;
  List<Content> content;
  String contentType;
  int createdAt;
  String id;
  // dynamic myReactions;
  // ReactionsCount? reactionsCount;
  Source source;
  String status;
  int statusUpdatedAt;

  factory StreakDatum.fromJson(Map<String, dynamic> json) => StreakDatum(
        author: Author.fromJson(json["author"]),
        //commentsCount: json["comments_count"],
        content:
            List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
        contentType: json["content_type"],
        createdAt: json["created_at"],
        id: json["id"],
        //  myReactions: json["my_reactions"],
        // reactionsCount: json["reactions_count"] == null
        //     ? null
        //     : ReactionsCount.fromJson(json["reactions_count"]),
        source: Source.fromJson(json["source"]),
        status: json["status"],
        statusUpdatedAt: json["status_updated_at"],
      );
}

class Author {
  Author({
    required this.user,
  });

  User user;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        user: User.fromJson(json["user"]),
      );
}

class User {
  User({
    required this.authIdentities,
    required this.id,
    required this.avatarUrl,
    required this.displayName,
  });

  AuthIdentities authIdentities;
  String id;
  String avatarUrl;
  String displayName;

  factory User.fromJson(Map<String, dynamic> json) => User(
        authIdentities: AuthIdentities.fromJson(json["auth_identities"]),
        id: json["id"],
        avatarUrl: json["avatar_url"],
        displayName: json["display_name"],
      );
}

class AuthIdentities {
  AuthIdentities({
    required this.relifeUserId,
  });

  String relifeUserId;

  factory AuthIdentities.fromJson(Map<String, dynamic> json) => AuthIdentities(
        relifeUserId: json["relife_userId"],
      );
}

class Content {
  Content({
    // required this.attachments,
    required this.language,
    required this.text,
  });

  // List<Attachment> attachments;
  String language;
  String? text;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        // attachments: List<Attachment>.from(
        //     json["attachments"].map((x) => Attachment.fromJson(x))),
        language: json["language"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        //   "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
        "language": language,
        "text": text,
      };
}

class Attachment {
  Attachment({
    required this.image,
  });

  String image;

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
      };
}

class ReactionsCount {
  ReactionsCount({
    required this.like,
  });

  int like;

  factory ReactionsCount.fromJson(Map<String, dynamic> json) => ReactionsCount(
        like: json["like"],
      );

  Map<String, dynamic> toJson() => {
        "like": like,
      };
}

class Source {
  Source({
    required this.id,
  });

  Id id;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: Id.fromJson(json["id"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id.toJson(),
      };
}

class Id {
  Id({
    required this.id,
    required this.type,
  });

  String id;
  String type;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        id: json["id"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
      };
}

class AtedAt {
  AtedAt();

  factory AtedAt.fromJson(Map<String, dynamic> json) => AtedAt();

  Map<String, dynamic> toJson() => {};
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
      );
}
