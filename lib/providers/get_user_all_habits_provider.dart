import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:relife/model/service%20model/get_particuar_system_habit_model.dart';
import 'package:relife/model/service%20model/get_user_all_habits_model.dart';
import 'package:relife/services/API/get_particual_system_habit_service.dart';
import 'package:relife/services/API/get_user_habits_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class ParticularHabitDetail {
//   String habitName;
//   String habitid;
//   int index;
//   int noOfUserContinuedTheirStreak;
//   List<Leaderboard> leaderboard;
//   bool
//       isDoneForToday; // has user completed today's habit task ? (calculated on frontend)

//   ParticularHabitDetail({
//     required this.habitid,
//     required this.index,
//     required this.noOfUserContinuedTheirStreak,
//     required this.habitName,
//     required this.isDoneForToday,
//     required this.leaderboard,
//   });
// } // fetching system habit detail along with user habit show that we can show habit detail and leaderboard page without any loader

class GetUserAllHabitsProvider extends ChangeNotifier {
  List<Detail> _listOfHabitdetails = []; // habit detail, type of Class Detail
  List<Detail> get listOfHabitDetails => _listOfHabitdetails;
  GetUserAllHabitsModel? getUserAllHabitsModel;
  // List<ParticularHabitDetail> listOfSystemHabit = [];

  Future<String?> getsharedToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  Future<GetUserAllHabitsModel?> getUserAllHabits(BuildContext context) async {
    final String? token = await getsharedToken();
    getUserAllHabitsModel =
        await GetUSerAllHabitsService().getUserHabits(token!, context);

    setHabitDetials(getUserAllHabitsModel!.details);
    notifyListeners();
    return getUserAllHabitsModel;
  }

  // Future<String?> getUserAllHabitsAndAddSystemHabitData(BuildContext context) async {
  //   final String? token = await getsharedToken();
  //   getUserAllHabitsModel =
  //       await GetUSerAllHabitsService().getUserHabits(token!, context);

  //   setHabitDetials(getUserAllHabitsModel!.details);
  //   // doing this beacuse of habit tab (system habit data is also fetched along with user all habits)
  //   listOfSystemHabit = [];
  //   for (int index = 0;
  //       index < getUserAllHabitsModel!.details.length;
  //       index++) {
  //     ParticularHabitDetail particularHabitDetail =
  //         await particularSystemHabits(index);
  //     listOfSystemHabit.add(particularHabitDetail);
  //   }

  //   notifyListeners();
  //   return token;
  // }

  setHabitDetials(List<Detail> val) {
    _listOfHabitdetails = val;
    // notifyListeners();
  }

  // for habit tab
  // Future<ParticularHabitDetail> particularSystemHabits(
  //   int index,
  // ) async {
  //   ParticularHabitDetail particularHabitDetail = ParticularHabitDetail(
  //       habitName: "",
  //       habitid: "",
  //       index: 0,
  //       noOfUserContinuedTheirStreak: 0,
  //       isDoneForToday: false,
  //       leaderboard: []);

  //   GetParticularSysytemHabitModel? getParticularSysytemHabitModel =
  //       await getParticularSystemHabit(getUserAllHabitsModel!
  //           .details[index].habitDetails.habitDetailsId); // passing habit id
  //   if (getParticularSysytemHabitModel != null) {
  //     particularHabitDetail.habitName =
  //         getParticularSysytemHabitModel.details.name;
  //     particularHabitDetail.habitid = getParticularSysytemHabitModel.details.id;
  //     particularHabitDetail.index = index;
  //     particularHabitDetail.noOfUserContinuedTheirStreak =
  //         getParticularSysytemHabitModel.details.usersDoneThisToday;
  //     particularHabitDetail.leaderboard =
  //         getParticularSysytemHabitModel.details.leaderboard;
  //     if (getUserAllHabitsModel!.details[index].streakData!.isEmpty) {
  //       particularHabitDetail.isDoneForToday = false;
  //     } else {
  //       DateTime lastPostTime = DateTime.fromMillisecondsSinceEpoch(
  //           getUserAllHabitsModel!.details[index].streakData![0].createdAt *
  //               1000);
  //       particularHabitDetail.isDoneForToday =
  //           DateFormat("yyyy-MM-dd").format(lastPostTime) ==
  //                   DateFormat("yyyy-MM-dd").format(DateTime.now())
  //               ? true
  //               : false;
  //     }
  //   }
  //   return particularHabitDetail;
  // }

  // Future<GetParticularSysytemHabitModel?> getParticularSystemHabit(
  //     String habitId) async {
  //   final String? token = await getsharedToken();
  //   GetParticularSysytemHabitModel? getParticularSysytemHabitModel =
  //       await GetParticularSystemHabitsService()
  //           .getParticularSystemHabit(token!, habitId);
  //   return getParticularSysytemHabitModel;
  // }
}
