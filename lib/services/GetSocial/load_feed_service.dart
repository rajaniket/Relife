import 'package:getsocial_flutter_sdk/common/pagingquery.dart';
import 'package:getsocial_flutter_sdk/common/userid.dart';
import 'package:getsocial_flutter_sdk/communities.dart';
import 'package:getsocial_flutter_sdk/communities/activity.dart';
import 'package:getsocial_flutter_sdk/communities/queries/activitiesquery.dart';

class LoadFeed {
  Future<List<GetSocialActivity>?> getAllPosts(
      {bool isThisGroup = false,
      String groupId = 'timeline',
      bool getPostByUser = false,
      UserId? userId}) async {
    var query = isThisGroup
        ? ActivitiesQuery.inGroup(groupId)
        : getPostByUser
            ? ActivitiesQuery.inAllTopics().byUser(userId!)
            : ActivitiesQuery.inAllTopics(); // Create query

    var pagingQuery = PagingQuery(query);
    //pagingQuery.limit = 10;
    List<GetSocialActivity> activities = [];
    try {
      var pagingActivities = await Communities.getActivities(pagingQuery);
      activities = pagingActivities.entries;
      return activities;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetSocialActivity> getPostById(String postId) async {
    try {
      var singlePost = Communities.getActivity(postId);
      return singlePost;
    } catch (e) {
      rethrow;
    }
  }

  Future getAllCommentsOfPost(String postId) async {
    var query = ActivitiesQuery.commentsToActivity(postId); // Create query
    var pagingQuery = PagingQuery(query);
    List<GetSocialActivity> activities = [];
    try {
      var pagingActivities = await Communities.getActivities(pagingQuery);
      activities = pagingActivities.entries;
      return activities;
    } catch (e) {
      rethrow;
    }
  }

  Future setRecation(String postId) async {
    try {
      Communities.addReaction('like', postId);
      return;
    } catch (e) {
      rethrow;
    }
  }

  Future removeRecation(String postId) async {
    try {
      Communities.removeReaction('like', postId);
      return;
    } catch (e) {
      rethrow;
    }
  }
}
