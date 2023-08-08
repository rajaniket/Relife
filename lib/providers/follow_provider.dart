import 'package:flutter/material.dart';
import 'package:relife/services/GetSocial/follow_unfollow_service.dart';

class FollowProvider extends ChangeNotifier {
  int _follower = 0;
  int _following = 0;

  int get follower => _follower;
  int get following => _following;

  getFollowers() async {
    int count = await FollowService().getFollowersCount() as int;
    setFollower(count);
    //notifyListeners();
  }

  getFollowing() async {
    int count = await FollowService().followUser();
    setFollowing(count);
    //notifyListeners();
  }

  void setFollower(int value) {
    _follower = value;
    notifyListeners();
  }

  void setFollowing(int value) {
    _following = value;
    notifyListeners();
  }
}
