import 'package:flutter/material.dart';
// Import package
import 'package:contacts_service/contacts_service.dart';
import 'package:relife/model/service%20model/update_user_habit_model.dart';
import 'package:relife/services/API/update_user_habits_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

class UpdateHabitsProvider extends ChangeNotifier {
  String _habitDetails = '';
  String _reminderHabit = 'select reminder habit';
  String _exactBehaviour = 'select exact behaviour';
  String _reward = 'select reward';
  String _reminderTime = 'select time';
  String _daysPerMonth = 'select days per month';
  String _punishment = 'select punishment';
  String _friend = 'select friend';
  String _phone = "9999999999";
  List<Contact> _contacts = [];
  List<Contact> _contactsFiltered = [];
  //List<String> _reminderDays = ["0", "0", "0", "0", "0", "0", "0"];
  List<int> _reminderDays = [0, 0, 0, 0, 0, 0, 0];

  UpdateHabitRequestModel updateHabitRequestModel = UpdateHabitRequestModel(
    habitDetails: 'habitDetails',
    reminderHabit: 'reminderHabit',
    exactBehaviour: 'exactBehaviour',
    reward: 'reward',
    reminderTime: 'reminderTime',
    daysPerMonth: 'daysPerMonth',
    punishment: 'punishment',
    accountabilityPartnerName: 'friend',
    accountabilityPartnerPhoneNumber: '0000000000',
    // reminderDays: ["0", "0", "0", "0", "0", "0", "0"],
    reminderDays: [0, 0, 0, 0, 0, 0, 0],
  );

  String get habitDetails => _habitDetails;
  String get reminderHabit => _reminderHabit;
  String get exactBehaviour => _exactBehaviour;
  String get reward => _reward;
  String get reminderTime => _reminderTime;
  String get daysPerMonth => _daysPerMonth;
  String get punishment => _punishment;
  String get friend => _friend;
  String get phone => _phone;
  List<Contact> get contacts => _contacts;
  List<Contact> get contactsFiltered => _contactsFiltered;
  // List<String> get reminderdays => _reminderDays;
  List<int> get reminderdays => _reminderDays;

  Future<int> updateUserHabit(String id) async {
    print("updateHabitRequestModel1: ${updateHabitRequestModel.reminderDays}");
    String? token = await getsharedToken();
    var result = await UpdateUserHabitsService()
        .updateHabit(updateHabitRequestModel, token!, id);

    return result;
  }

  Future<String?> getsharedToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  Future<void> getContacts() async {
    //TODO:
    if (await Permission.contacts.isGranted) {
      List<Contact> contacts =
          await ContactsService.getContacts(withThumbnails: false);
      _contacts = contacts;
      //print(contacts[10].displayName);
      notifyListeners();
    } else if (await Permission.contacts.request().isGranted) {
      List<Contact> contacts =
          await ContactsService.getContacts(withThumbnails: false);
      _contacts = contacts;
      notifyListeners();
    }
  }

  setHabitDetails(String val) {
    _habitDetails = val;
    updateHabitRequestModel.habitDetails = val;
    notifyListeners();
  }

  setReminderHabit(String val) {
    _reminderHabit = val;
    updateHabitRequestModel.reminderHabit = val;
    notifyListeners();
  }

  setExactBehaviour(String val) {
    _exactBehaviour = val;
    updateHabitRequestModel.exactBehaviour = val;
    notifyListeners();
  }

  setReward(String val) {
    _reward = val;
    updateHabitRequestModel.reward = val;
    notifyListeners();
  }

  setReminderTime(String val) {
    var format = val.split('').length;
    updateHabitRequestModel.reminderTime = val;
    _reminderTime = val;

    notifyListeners();
  }

  setDaysPerMonth(String val) {
    _daysPerMonth = val;
    updateHabitRequestModel.daysPerMonth = val.split(" ").first;
    notifyListeners();
  }

  setPunishment(String val) {
    _punishment = val;
    updateHabitRequestModel.punishment = val;
    notifyListeners();
  }

  setFriends(String val) {
    _friend = val;
    updateHabitRequestModel.accountabilityPartnerName = val;
    notifyListeners();
  }

  setPhone(String val) {
    _phone = val;
    updateHabitRequestModel.accountabilityPartnerPhoneNumber = val;
    notifyListeners();
  }

  setReminderDays(List<int> days) {
    List<String> temp = ["0", "0", "0", "0", "0", "0", "0"];
    for (int i = 0; i < days.length; i++) {
      temp[i] = days[i].toString();
    }
    _reminderDays = days;
    updateHabitRequestModel.reminderDays = days;
    notifyListeners();
  }

  getReminderDaysInListString() {
    List<String> temp = [];
    for (int i = 0; i < _reminderDays.length; i++) {
      temp.add(_reminderDays[i].toString());
    }
    return temp;
  }

  filteredContacts(TextEditingController editingController, String query) {
    List<Contact> contacts = [];
    List<Contact> saveAllContacts = [];
    contacts.addAll(_contacts);

    if (editingController.text.isNotEmpty) {
      contacts.retainWhere((contacts) {
        if (contacts.displayName != null) {
          String contactName = contacts.displayName!.toLowerCase();
          return contactName.contains(query.toLowerCase());
        }
        return true;
      });

      print(contacts);

      _contactsFiltered = contacts;
      notifyListeners();
    }
  }
}
