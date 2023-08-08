import 'package:flutter/material.dart';
import 'package:relife/model/service%20model/get_system_habits_model.dart';
import 'package:relife/services/API/get_system_habits.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SystemHabitsProvider extends ChangeNotifier {
  List<String> _remainderHabits = [];
  List<String> _exactBehaviour = [];
  List<Leaderboard> _leaderBoard = [];
  String _systemdetails = '';
  int _totalUsersInThisHabit = 0;
  bool _isLoading = false;

  GetSystemHabitsModel? getSystemHabitsModel;

  List<String> get remainderHabits => _remainderHabits;
  List<String> get exactBehaviour => _exactBehaviour;
  String get habitDetails => _systemdetails;
  int get totalUsersInThisHabit => _totalUsersInThisHabit;
  bool get isLoading => _isLoading;
  List<Leaderboard> get leaderboard => _leaderBoard;
  void getSystemHabits(int index, BuildContext context) async {
    setLoading(true);
    final token = await getsharedToken();
    getSystemHabitsModel =
        await GetSystemHabitsService().getSystemHabit(token!, context);
    setLoading(false);

    setRemainderHabits(getSystemHabitsModel!.details![index].reminderHabits!);
    setExactBehaviour(getSystemHabitsModel!.details![index].exactBehaviour!);
    setHabitsDetials(getSystemHabitsModel!.details![index].id);
    setTotalUsersInThisHabit(
        getSystemHabitsModel!.details![index].totalUsersInThisHabit);
    setLeaderBoard(getSystemHabitsModel!.details![index].leaderboard);

    notifyListeners();
  }

  void getSystemHabitFun(BuildContext context) async {
    final token = await getsharedToken();
    getSystemHabitsModel =
        await GetSystemHabitsService().getSystemHabit(token!, context);

    for (var i = 0; i < getSystemHabitsModel!.details!.length; i++) {
      setLeaderBoard(getSystemHabitsModel!.details![i].leaderboard);
    }

    notifyListeners();
  }

  Future<String?> getsharedToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  setRemainderHabits(List<String> value) {
    _remainderHabits = value;

    notifyListeners();
  }

  setExactBehaviour(List<String> value) {
    _exactBehaviour = value;
    notifyListeners();
  }

  setHabitsDetials(String val) {
    _systemdetails = val;
    notifyListeners();
  }

  setTotalUsersInThisHabit(int val) {
    _totalUsersInThisHabit = val;
    notifyListeners();
  }

  setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  setLeaderBoard(List<Leaderboard> val) {
    _leaderBoard = val;
    notifyListeners();
  }
}
