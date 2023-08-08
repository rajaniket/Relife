import 'package:flutter/material.dart';
import 'package:relife/model/ui%20model/notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications => _notifications;

  void addNotification(NotificationModel value) {
    _notifications.add(value);

    notifyListeners();
  }

  void setListToEmpty() {
    _notifications = [];
  }

  void setSharedNotificationCount(int count) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("notificationCount", count);
  }

  Future<int?> getSharedNotificationCount() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt('notificationCount');
  }
}
