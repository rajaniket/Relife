import 'package:getsocial_flutter_sdk/common/userid.dart';
import 'package:getsocial_flutter_sdk/common/useridlist.dart';
import 'package:getsocial_flutter_sdk/communities.dart';
import 'package:getsocial_flutter_sdk/communities/queries/followersquery.dart';
import 'package:getsocial_flutter_sdk/communities/queries/followquery.dart';
import 'package:getsocial_flutter_sdk/current_user.dart';
import 'package:getsocial_flutter_sdk/getsocial.dart';

class FollowService {
  CurrentUser? currentUser;

  getCurrentUser() async {
    currentUser = await GetSocial.currentUser;
  }

  followUser() async {
    await getCurrentUser();
    var query = FollowQuery.users(UserIdList.create(['']));

    try {
      int count = await Communities.follow(query);
      return count;
    } catch (error) {
      rethrow;
    }
  }

  getFollowersCount() async {
    await getCurrentUser();
    var userId = UserId.create(currentUser!.userId);
    var followersQuery = FollowersQuery.ofUser(userId);
    //var pagingQuery = PagingQuery(followersQuery);
    try {
      int count = await Communities.getFollowersCount(followersQuery);
      // print('Followers  : ${count}');
      return count;
    } catch (err) {
      rethrow;
    }
  }
}
