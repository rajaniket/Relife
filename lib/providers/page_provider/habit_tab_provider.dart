import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/service model/get_system_habits_model.dart';
import '../../model/service model/get_user_all_habits_model.dart';
import '../../services/API/get_system_habits.dart';
import '../../services/API/get_user_habits_service.dart';

class ParticularSystemHabitDetail {
  String habitName;
  String habitid;
  int index;
  int noOfUserContinuedTheirStreak;
  List<Leaderboard> leaderboard;
  bool
      isDoneForToday; // has user completed today's habit task ? (calculated on frontend)

  ParticularSystemHabitDetail({
    required this.habitid,
    required this.index,
    required this.noOfUserContinuedTheirStreak,
    required this.habitName,
    required this.isDoneForToday,
    required this.leaderboard,
  });
}

class HabitTabProvider extends ChangeNotifier {
  GetUserAllHabitsModel? getUserAllHabitsModel;
  GetSystemHabitsModel? getSystemHabitsModel;
  List<ParticularSystemHabitDetail>
      listParticularSystemHabitDetailAsPerUserHabit = [];
  List<Detail> listOfUserHabitdetails = [];
  List<Details> listOfSystemHabitDetail = [];
  bool loading = false;
  Future<String?> getsharedToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  Future<GetUserAllHabitsModel?> getUserAllHabits(BuildContext context) async {
    final String? token = await getsharedToken();
    getUserAllHabitsModel =
        await GetUSerAllHabitsService().getUserHabits(token!, context);
    listOfUserHabitdetails = getUserAllHabitsModel!.details;
    listOfUserHabitdetails.sort((a, b) {
      return a.habitDetails.name.compareTo(b.habitDetails.name.toLowerCase());
    });
    return getUserAllHabitsModel;
  }

  Future<GetSystemHabitsModel?> getSystemHabits(BuildContext context) async {
    final token = await getsharedToken();
    getSystemHabitsModel =
        await GetSystemHabitsService().getSystemHabit(token!, context);
    listOfSystemHabitDetail = getSystemHabitsModel!.details!;
    listOfSystemHabitDetail.sort((a, b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
    return getSystemHabitsModel;
  }

  Future<void> getHabitTabData(
      {bool isLoadingRequired = false, required BuildContext context}) async {
    // isLoadingRequired is added because we want progress indicator only when app starts
    loading = isLoadingRequired;

    listParticularSystemHabitDetailAsPerUserHabit = [];
    await Future.wait([getUserAllHabits(context), getSystemHabits(context)]);
    ParticularSystemHabitDetail particularHabitDetail =
        ParticularSystemHabitDetail(
            habitName: "",
            habitid: "",
            index: 0,
            noOfUserContinuedTheirStreak: 0,
            isDoneForToday: false,
            leaderboard: []);

    for (int i = 0; i < listOfUserHabitdetails.length; i++) {
      var habitId = listOfUserHabitdetails[i].habitDetails.habitDetailsId;
      for (int j = 0; j < listOfSystemHabitDetail.length; j++) {
        if (listOfSystemHabitDetail[j].id == habitId) {
          particularHabitDetail.habitName = listOfSystemHabitDetail[j].name;
          particularHabitDetail.habitid = listOfSystemHabitDetail[j].id;
          particularHabitDetail.index = i;
          particularHabitDetail.noOfUserContinuedTheirStreak =
              listOfSystemHabitDetail[j].usersDoneThisToday;
          particularHabitDetail.leaderboard =
              listOfSystemHabitDetail[j].leaderboard;
          if (listOfUserHabitdetails[i].streakData!.isEmpty) {
            particularHabitDetail.isDoneForToday = false;
          } else {
            DateTime lastPostTime = DateTime.fromMillisecondsSinceEpoch(
                listOfUserHabitdetails[i].streakData![0].createdAt * 1000);
            particularHabitDetail.isDoneForToday =
                DateFormat("yyyy-MM-dd").format(lastPostTime) ==
                        DateFormat("yyyy-MM-dd").format(DateTime.now())
                    ? true
                    : false;
          }
          listParticularSystemHabitDetailAsPerUserHabit
              .add(particularHabitDetail);
        }
      }
      particularHabitDetail = ParticularSystemHabitDetail(
          habitName: "",
          habitid: "",
          index: 0,
          noOfUserContinuedTheirStreak: 0,
          isDoneForToday: false,
          leaderboard: []);
    }
    loading = false;
    notifyListeners();
  }
}
