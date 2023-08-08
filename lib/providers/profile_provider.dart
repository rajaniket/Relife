import 'package:flutter/material.dart';
import 'package:relife/model/service%20model/get_profile_model.dart';
import 'package:relife/services/API/get_profile_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class ProfileProvider extends ChangeNotifier {
  String _message = '';
  String _firstName = '';
  String _lastName = '';
  String _profilePicture = "";
  String _bio = 'hey there 👋 i am ...';
  String _key = '';
  String _userId = '';
  ViewProfileResponseModel? viewProfileResponseModel;
  List<Ranking> _ranking = [];

  //GETTER:
  String get message => _message;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get profilePicture => _profilePicture;
  String get bio => _bio;
  String get userId => _userId;
  List<Ranking> get rankingList => _ranking;

  String get key => _key;

  Future<void> getProfile(BuildContext context) async {
    String? token = await getsharedToken();
    viewProfileResponseModel =
        await GetProfileService().getProfile(token!, context);
    setFirstName(viewProfileResponseModel!.details.firstName);
    setLastName(viewProfileResponseModel!.details.lastName);
    setprofilePic(viewProfileResponseModel!.details.profilePicture!);
    setMessage(viewProfileResponseModel!.message);
    setBio(viewProfileResponseModel!.details.bio!);
    await setUserId();

    for (var i = 0; i < viewProfileResponseModel!.details.habits.length; i++) {
      _ranking.add(Ranking(
          habitName:
              viewProfileResponseModel!.details.habits[i].habitDetails.name,
          rank: viewProfileResponseModel!
              .details.habits[i].habitDetails.leaderboardRank));
    }
    notifyListeners();
  }

  Future<String?> getsharedToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  void setMessage(String value) {
    _message = value;
    // notifyListeners();
  }

  void setFirstName(String value) {
    _firstName = value;
    // notifyListeners();
  }

  void setLastName(String value) {
    _lastName = value;
    // notifyListeners();
  }

  void setprofilePic(String value) {
    _profilePicture = value;
    Random random = Random();
    int randomNumber = random.nextInt(100);
    _key = randomNumber.toString() + value;
    // notifyListeners();
  }

  void setBio(String value) {
    _bio = value;
    // notifyListeners();
  }

  // void setUserId(String value) {
  //   _userId = value;
  //   notifyListeners();
  // }

  Future<String?> setUserId() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    _userId = sharedPreferences.getString('userId')!;
  }

  Future<List<String>?> getIsPostedToday() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getStringList('isPostedToday');
  }

  Future<void> setIsPostedToday(DateTime date, String id) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    List<String>? isPostedDetail = [];

    if (sharedPreferences.containsKey('isPostedToday')) {
      isPostedDetail = sharedPreferences.getStringList('isPostedToday')!;
    }

    isPostedDetail.add(id);
    isPostedDetail.add(date.toString());
    sharedPreferences.setStringList('isPostedToday', isPostedDetail);
  }
}

class Ranking {
  final String habitName;
  final int rank;

  Ranking({required this.habitName, required this.rank});
}
