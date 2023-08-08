class NotificationModel {
  final String message;
  final bool isRead;
  final String createdAt;
  final String notificationId;
  final String postId;
  final String notificationType;
  final int userId;
  final String userProfilel;

  NotificationModel({
    required this.message,
    required this.isRead,
    required this.createdAt,
    required this.notificationId,
    required this.postId,
    required this.notificationType,
    required this.userId,
    required this.userProfilel,
  });
}
