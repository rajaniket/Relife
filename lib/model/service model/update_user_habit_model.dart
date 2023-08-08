import 'dart:convert';

class UpdateHabitRequestModel {
  List<int> reminderDays;
  String habitDetails;
  String reminderHabit;
  String exactBehaviour;
  String reward;
  String reminderTime;
  String daysPerMonth;
  String punishment;
  String accountabilityPartnerName;
  String accountabilityPartnerPhoneNumber;

  UpdateHabitRequestModel({
    required this.reminderDays,
    required this.habitDetails,
    required this.reminderHabit,
    required this.exactBehaviour,
    required this.reward,
    required this.reminderTime,
    required this.daysPerMonth,
    required this.punishment,
    required this.accountabilityPartnerName,
    required this.accountabilityPartnerPhoneNumber,
  });

  Map<String, dynamic> toJson() => {
        'reminderDays': jsonEncode(reminderDays),
        'habitDetails': habitDetails,
        'reminderHabit': reminderHabit,
        'exactBehaviour': exactBehaviour,
        'reward': reward,
        'reminderTime': reminderTime,
        'daysPerMonth': daysPerMonth,
        'punishment': punishment,
        'accountabilityPartnerName': accountabilityPartnerName,
        'accountabilityPartnerPhoneNumber': accountabilityPartnerPhoneNumber,
      };
}
