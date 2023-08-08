import 'package:flutter/material.dart';
import 'package:relife/model/service%20model/get_particuar_system_habit_model.dart';
import 'package:relife/services/API/get_particual_system_habit_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParticuarSystemHabitProvider extends ChangeNotifier {
  List<Leaderboard> _leaderBoard = [];
  bool _isLoading = false;

  GetParticularSysytemHabitModel? getParticularSysytemHabitModel;

  bool get isLoading => _isLoading;
  List<Leaderboard> get leaderboard => _leaderBoard;

  Future<String?> getsharedToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  Future<GetParticularSysytemHabitModel> getParticularSystemHabit(
      String habitId) async {
    final String? token = await getsharedToken();

    getParticularSysytemHabitModel = await GetParticularSystemHabitsService()
        .getParticularSystemHabit(token!, habitId);
    setLeaderBoard(getParticularSysytemHabitModel!.details.leaderboard);
    // notifyListeners();
    return getParticularSysytemHabitModel!;
  }

  // setLoading(bool val) {
  //   _isLoading = val;
  //   notifyListeners();
  // }

  setLeaderBoard(List<Leaderboard> val) {
    _leaderBoard = val;
    notifyListeners();
  }
}
