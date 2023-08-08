import 'package:flutter/material.dart';
import 'package:relife/model/service%20model/create_habit_model.dart';
// Import package
import 'package:contacts_service/contacts_service.dart';
import 'package:relife/services/API/add_user_habits_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

class AddHabitsProvider extends ChangeNotifier {
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
  // List<int> _reminderDays = [0, 0, 0, 0, 0, 0, 0];

  CreateHabitRequestModel createHabitRequestModel = CreateHabitRequestModel(
    habitDetails: 'habitDetails',
    reminderHabit: 'reminderHabit',
    exactBehaviour: 'exactBehaviour',
    reward: 'reward',
    reminderTime: 'reminderTime',
    daysPerMonth: 'daysPerMonth',
    punishment: 'punishment',
    accountabilityPartnerName: 'friend',
    accountabilityPartnerPhoneNumber: '0000000000',
    // reminderDays: [0, 0, 0, 0, 0, 0, 0],
  );

  resetHabitData() {
    _habitDetails = '';
    _reminderHabit = 'select reminder habit';
    _exactBehaviour = 'select exact behaviour';
    _reward = 'select reward';
    _reminderTime = 'select time';
    _daysPerMonth = 'select days per month';
    _punishment = 'select punishment';
    _friend = 'select friend';
    _phone = "9999999999";
    _contacts = [];
    _contactsFiltered = [];
  }

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
  // List<int> get reminderdays => _reminderDays;

  Future<int> createUserHabit() async {
    String? token = await getsharedToken();
    var result = await AddUserHabitsService()
        .createHabit(createHabitRequestModel, token!);

    return result;
  }

  Future<String?> getsharedToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  getContacts() async {
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
    createHabitRequestModel.habitDetails = val;
    notifyListeners();
  }

  setReminderHabit(String val) {
    _reminderHabit = val;
    createHabitRequestModel.reminderHabit = val;
    notifyListeners();
  }

  setExactBehaviour(String val) {
    _exactBehaviour = val;
    createHabitRequestModel.exactBehaviour = val;
    notifyListeners();
  }

  setReward(String val) {
    _reward = val;
    createHabitRequestModel.reward = val;
    notifyListeners();
  }

  setReminderTime(String val) {
    _reminderTime = val;
    createHabitRequestModel.reminderTime = val;
    notifyListeners();
  }

  setDaysPerMonth(String val) {
    _daysPerMonth = val;
    createHabitRequestModel.daysPerMonth = val.split(" ").first;
    notifyListeners();
  }

  setPunishment(String val) {
    _punishment = val;
    createHabitRequestModel.punishment = val;
    notifyListeners();
  }

  setFriends(String val) {
    _friend = val;
    createHabitRequestModel.accountabilityPartnerName = val;
    notifyListeners();
  }

  setPhone(String val) {
    _phone = val;
    createHabitRequestModel.accountabilityPartnerPhoneNumber = val;
    notifyListeners();
  }

  // setReminderDays(List<int> days) {
  //   List<String> temp = ["0", "0", "0", "0", "0", "0", "0"];
  //   for (int i = 0; i < days.length; i++) {
  //     temp[i] = days[i].toString();
  //   }
  //   _reminderDays = days;
  //   createHabitRequestModel.reminderDays = days;
  //   notifyListeners();
  // }

  filteredContacts(TextEditingController editingController, String query) {
    List<Contact> contacts = [];
    contacts.addAll(_contacts);

    if (editingController.text.isNotEmpty) {
      contacts.retainWhere((contacts) {
        String contactName = contacts.displayName!.toLowerCase();
        return contactName.contains(query.toLowerCase());
      });
      _contactsFiltered = contacts;
      notifyListeners();
    }
  }
}
