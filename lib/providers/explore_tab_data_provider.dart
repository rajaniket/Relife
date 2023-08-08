import 'package:flutter/cupertino.dart';
import 'package:relife/services/GetSocial/load_feed_service.dart';

class ExploreTabDataProvider extends ChangeNotifier {
  int numOfPostInReading = 0;
  int numOfPostInRunning = 0;
  int numOfPostInExercise = 0;
  int numOfPostintroduction = 0;

  latestPostCount(String groupId) async {
    var userPostList =
        await LoadFeed().getAllPosts(groupId: groupId, isThisGroup: true);
    if (userPostList != null) {
      return userPostList.length;
    } else {
      return 0;
    }
  }

  updateUnseenPostCount(String groupId) async {
    if (groupId == 'running') {
      int latestCount = await latestPostCount(groupId);

      return latestCount - numOfPostInRunning;
    } else if (groupId == 'reading') {
      int latestCount = await latestPostCount(groupId);

      return latestCount - numOfPostInReading;
    } else if (groupId == 'introduction') {
      int latestCount = await latestPostCount(groupId);

      return latestCount - numOfPostintroduction;
    } else if (groupId == 'exercise') {
      int latestCount = await latestPostCount(groupId);

      return latestCount - numOfPostInExercise;
    }
  }

  updateSeenPost(String groupId, int data) {
    if (groupId == 'running') {
      numOfPostInRunning = data;
    } else if (groupId == 'reading') {
      numOfPostInReading = data;
    } else if (groupId == 'introduction') {
      numOfPostInReading = data;
    } else if (groupId == 'exercise') {
      numOfPostInReading = data;
    }
  }
}
