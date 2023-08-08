import 'dart:math';

import 'package:flutter/material.dart';
import 'package:relife/model/service%20model/others_profile_model.dart';
import 'package:relife/services/API/others_view_profile_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OthersProfileProvider extends ChangeNotifier {
  bool _isloading = true;
  String _message = '';
  String _firstName = '';
  String _lastName = '';
  String _profilePicture =
      'https://www.bsn.eu/wp-content/uploads/2016/12/user-icon-image-placeholder.jpg';
  String _bio = 'Hello, there i am ...';
  String _key = '';
  String _userId = '';
  OthersProfileModel? othersProfileModel;
  List<Ranking> _ranking = [];

  String get key => _key;

  //GETTER:
  String get message => _message;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get profilePicture => _profilePicture;
  String get bio => _bio;
  String get userId => _userId;
  List<Ranking> get rankingList => _ranking;
  bool get isLoading => _isloading;

  Future<String?> getsharedToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  Future<void> getProfile(String id) async {
    setLoading(true);
    String? token = await getsharedToken();
    othersProfileModel =
        await OthersProfileViewService().getOthersProfile(id, token!);
    setFirstName(othersProfileModel!.details.firstName);
    setLastName(othersProfileModel!.details.lastName);
    setprofilePic(othersProfileModel!.details.profilePicture!);
    setMessage(othersProfileModel!.message);
    setBio(othersProfileModel!.details.bio!);

    for (var i = 0; i < othersProfileModel!.details.habits.length; i++) {
      _ranking.add(Ranking(
          habitName: othersProfileModel!.details.habits[i].habitDetails.name,
          rank: othersProfileModel!
              .details.habits[i].habitDetails.leaderboardRank));
    }
    setLoading(false);
    notifyListeners();
    // return othersProfileModel;
  }

  void setMessage(String value) {
    _message = value;
    notifyListeners();
  }

  void setFirstName(String value) {
    _firstName = value;
    notifyListeners();
  }

  void setLastName(String value) {
    _lastName = value;
    notifyListeners();
  }

  void setprofilePic(String value) {
    _profilePicture = value;
    Random random = Random();
    int randomNumber = random.nextInt(100);
    _key = randomNumber.toString() + value;
    notifyListeners();
  }

  void setBio(String value) {
    _bio = value;
    notifyListeners();
  }

  void setUserId(String value) {
    _userId = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }
}

class Ranking {
  final String habitName;
  final int rank;

  Ranking({required this.habitName, required this.rank});
}
