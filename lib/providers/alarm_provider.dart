import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlarmProvider extends ChangeNotifier {
  String? hour,
      min,
      mon = '1',
      tue = '1',
      wed = '1',
      thr = '1',
      fri = '1',
      sat = '1',
      sun = '1',
      alarmId, // same as habit id
      authToken,
      habitId,
      notificationTitle,
      notificationDescription,
      fullPlanText,
      habitPlanRemainderText,
      startDays = "";
  bool cancelAlarmFlag =
      false; // when user doesnot select any days then cancel the alarm
  //List<int> days = [1, 1, 1, 1, 1, 1, 1];
  static const platform = MethodChannel('com.relife/alarm');
  //DateTime? newTime = DateTime.now();
  Future<void> cancelAlarm({required int passAlarmId}) async {
    try {
      platform.invokeMethod(
          'cancelAlarm', <String, String>{'alarmId': passAlarmId.toString()});
    } on PlatformException catch (e) {
      //print("error:________");
    }
  }

  List<int> getListOfweekDaysAlarm() {
    List<int> listOfDays = [1, 1, 1, 1, 1, 1, 1]; // mon to sun

    if (mon != '1') {
      listOfDays[0] = 0;
    }
    if (tue != '1') {
      listOfDays[1] = 0;
    }
    if (wed != '1') {
      listOfDays[2] = 0;
    }
    if (thr != '1') {
      listOfDays[3] = 0;
    }
    if (fri != '1') {
      listOfDays[4] = 0;
    }
    if (sat != '1') {
      listOfDays[5] = 0;
    }
    if (sun != '1') {
      listOfDays[6] = 0;
    }
    return listOfDays;
  }

  Future<void> setAlarm() async {
    try {
      platform.invokeMethod('setAlarm', <dynamic, dynamic>{
        'min': min!,
        'hour': hour!,
        'alarmId': alarmId!,
        'authToken': authToken!,
        'habitId': habitId!,
        'notificationTitle': notificationTitle!,
        'notificationDescription': notificationDescription!,
        'fullPlanText': fullPlanText!,
        'habitPlanRemainderText': habitPlanRemainderText!,
        'startDays': startDays,
        'mon': mon!,
        'tue': tue!,
        'wed': wed!,
        'thr': thr!,
        'fri': fri!,
        'sat': sat!,
        'sun': sun!,
      });
      // print(
      //     "__Alarm data_fitted mon: $mon, tue: $tue, wed: $wed, thr: $thr, fri: $fri, sat: $sat, sun: $sun, hour: $hour, min: $min, startDate: $startDays,  ");
      hour = null;
      min = null;

      alarmId = null;
      authToken = null;
      habitId = null;
      notificationTitle = null;
      notificationDescription = null;
      fullPlanText = null;
      habitPlanRemainderText = null;
      // startDays = null;

    } on PlatformException catch (e) {
      //print("error:________");
    }
  }

  Future<void> setAlaramDataLocally(String passAlarmId) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('min$passAlarmId', min!);
    sharedPreferences.setString('hour$passAlarmId', hour!);
    sharedPreferences.setString('alarmId$passAlarmId', alarmId!);
    sharedPreferences.setString('authToken$passAlarmId', authToken!);
    sharedPreferences.setString('habitId$passAlarmId', habitId!);
    sharedPreferences.setString(
        'notificationTitle$passAlarmId', notificationTitle!);
    sharedPreferences.setString(
        'notificationDescription$passAlarmId', notificationDescription!);
    sharedPreferences.setString('fullPlanText$passAlarmId', fullPlanText!);
    sharedPreferences.setString(
        'habitPlanRemainderText$passAlarmId', habitPlanRemainderText!);

    sharedPreferences.setString('mon$passAlarmId', mon!);
    sharedPreferences.setString('tue$passAlarmId', tue!);
    sharedPreferences.setString('wed$passAlarmId', wed!);
    sharedPreferences.setString('thr$passAlarmId', thr!);
    sharedPreferences.setString('fri$passAlarmId', fri!);
    sharedPreferences.setString('sat$passAlarmId', sat!);
    sharedPreferences.setString('sun$passAlarmId', sun!);
  }

  Future<void> fetchAlarmDataFromSharedPrefrence(String passAlarmId) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    min = sharedPreferences.getString('min$passAlarmId');
    hour = sharedPreferences.getString('hour$passAlarmId');
    alarmId = sharedPreferences.getString('alarmId$passAlarmId');
    habitId = sharedPreferences.getString('habitId$passAlarmId');
    notificationTitle =
        sharedPreferences.getString('notificationTitle$passAlarmId');
    notificationDescription =
        sharedPreferences.getString('notificationDescription$passAlarmId');
    fullPlanText = sharedPreferences.getString('fullPlanText$passAlarmId');
    habitPlanRemainderText =
        sharedPreferences.getString('habitPlanRemainderText$passAlarmId');
    mon = sharedPreferences.getString('mon$passAlarmId');
    tue = sharedPreferences.getString('tue$passAlarmId');
    wed = sharedPreferences.getString('wed$passAlarmId');
    thr = sharedPreferences.getString('thr$passAlarmId');
    fri = sharedPreferences.getString('fri$passAlarmId');
    sat = sharedPreferences.getString('sat$passAlarmId');
    sun = sharedPreferences.getString('sun$passAlarmId');
    calculateStartdate();
    authToken = await getsharedToken();
    print(
        "__Alarm data_fitted mon: $mon, tue: $tue, wed: $wed, thr: $thr, fri: $fri, sat: $sat, sun: $sun, hour: $hour, min: $min, startDate: $startDays,  ");
  }

  Future<String?> getsharedToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  void calculateStartdate() {
    List<int> daysList = getListOfweekDaysAlarm();
    int currentHour = DateTime.now().hour;
    int currentMin = DateTime.now().minute;

    // print("_recall  days $newTime");

    if (daysList.every((element) => element == 0 ? true : false)) {
      // alarmProvider.cancelAlarmFlag = true;
      // cancel alarm
    } else {
      if (int.parse(hour!) > currentHour) {
        DateTime date = DateTime.now();
        bool condition = true;
        if (daysList[date.weekday - 1] == 1) {
          startDays = null;
        } else {
          while (condition) {
            if (daysList[date.weekday - 1] == 1) {
              startDays = DateFormat('yyyy-MM-dd hh:mm:ss').format(date);
              condition = false;
            } else {
              date = date.add(const Duration(days: 1));
            }
          }
        }
      } else if (int.parse(hour!) == currentHour) {
        if (int.parse(min!) > currentMin) {
          DateTime date = DateTime.now();

          bool condition = true;
          if (daysList[date.weekday - 1] == 1) {
            startDays = null;
          } else {
            while (condition) {
              if (daysList[date.weekday - 1] == 1) {
                startDays = DateFormat('yyyy-MM-dd hh:mm:ss').format(date);
                condition = false;
              } else {
                date = date.add(const Duration(days: 1));
              }
            }
          }
        } else {
          DateTime date = DateTime.now().add(const Duration(days: 1));
          bool condition = true;

          while (condition) {
            if (daysList[date.weekday - 1] == 1) {
              startDays = DateFormat('yyyy-MM-dd hh:mm:ss').format(date);
              condition = false;
            } else {
              date = date.add(const Duration(days: 1));
            }
          }
        }
      } else {
        DateTime date = DateTime.now().add(const Duration(days: 1));
        bool condition = true;

        while (condition) {
          if (daysList[date.weekday - 1] == 1) {
            startDays = DateFormat('yyyy-MM-dd hh:mm:ss').format(date);
            condition = false;
          } else {
            date = date.add(const Duration(days: 1));
          }
        }
      }
    }
  }
}
