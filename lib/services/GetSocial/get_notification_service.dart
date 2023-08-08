import 'package:getsocial_flutter_sdk/getsocial_flutter_sdk.dart';

class GetNotificationService {
  Future<List> getNotificationResult() async {
    List<dynamic> notification = [];

    await Notifications.get(PagingQuery(NotificationsQuery.withStatuses(
      [NotificationStatus.unread, NotificationStatus.read],
    ))).then((value) {
      PagingResult result = value;
      notification = result.entries;
    });

    return notification;
  }
}
