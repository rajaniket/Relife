import 'package:getsocial_flutter_sdk/communities.dart';
import 'package:getsocial_flutter_sdk/communities/activitycontent.dart';
import 'package:getsocial_flutter_sdk/communities/postactivitytarget.dart';

class PostCommentService {
  postComment(String activityId, String comment) async {
    var activityContent = ActivityContent();
    PostActivityTarget target = PostActivityTarget.comment(activityId);
    activityContent.text = comment;
    Communities.postActivity(activityContent, target).then((result) {
      // print(
      //     'Posted activity______________: $result ________________$activityContent');
    }).catchError((error) {
      //print('Failed to post activity, error________________: $error');
    });
  }
}
