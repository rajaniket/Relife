import 'package:getsocial_flutter_sdk/getsocial_flutter_sdk.dart';

class GroupServices {
  joinGroup({required String groupId}) {
    var query = JoinGroupQuery.create(groupId);
    try {
      Communities.joinGroup(query);
    } catch (e) {
      rethrow;
    }
  }

  checkGroupMember({required List<String> groupIds}) {
    //var userIdList = UserIdList.create([userId]);
    try {
      //  var result = Communities.areGroupMembers(groupId, userIdList);
      var result = Communities.isFollowing(
          UserId.currentUser(), FollowQuery.groups(groupIds));

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future removeMemberFromGroup({
    required String groupId,
  }) async {
    try {
      UserIdList userIds = UserId.currentUser().asUserIdList();
      RemoveGroupMembersQuery query =
          RemoveGroupMembersQuery.create(groupId, userIds);
      Communities.removeGroupMembers(query);
    } catch (e) {
      rethrow;
    }
  }
}
