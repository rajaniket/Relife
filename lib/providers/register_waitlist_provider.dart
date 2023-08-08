import 'package:flutter/material.dart';
import 'package:relife/model/service%20model/get_waitlist_user_model.dart';
import 'package:relife/model/service%20model/waitlist_register_model.dart';
import 'package:relife/services/API/get_waitlist_user_service.dart';
import 'package:relife/services/API/waitlist_register_service.dart';

class WaitlistRegisterProvider extends ChangeNotifier {
  String _message = '';
  String _firstName = '';
  String _lastName = '';
  String _userName = '';
  String _waitistId = '';
  String _password = '';
  String _confirmPassword = '';

  String _phoneNumber = "";

  GetWaitlistUserModel? getWaitlistUserModel;
  WaitlistRegisterModel waitlistRegisterModel = WaitlistRegisterModel(
      confirmPassword: '',
      firstName: '',
      lastName: '',
      password: '',
      phoneNumber: '',
      countryCode: '91');

  String get message => _message;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get userName => _userName;
  String get waitlistId => _waitistId;
  String get phoneNumber => _phoneNumber;

  Future<void> setWaitlistUser() async {
    getWaitlistUserModel =
        await GetWaitlistUserService().getWaitlist(waitlistId);
    setFirstName(getWaitlistUserModel!.details.firstName);
    setLastName(getWaitlistUserModel!.details.lastName!);
    setUserName(getWaitlistUserModel!.details.username);
    setPhoneNumber(getWaitlistUserModel!.details.phoneNumber!.toString());
    setPassword("");
    setConfirmPassword("");
  }

  Future<int?> registerUser() async {
    var response = await WaitlistRegisterService()
        .waitlistRegister(waitlistRegisterModel, waitlistId);

    return response;
  }

  updateWaitlistRegisterModel() {
    waitlistRegisterModel.firstName = _firstName;
    waitlistRegisterModel.lastName = _lastName;
    waitlistRegisterModel.confirmPassword = _confirmPassword;
    waitlistRegisterModel.password = _password;
    waitlistRegisterModel.phoneNumber = _phoneNumber;
    waitlistRegisterModel.countryCode = "91";
  }

  void setMessage(String val) {
    _message = val;
  }

  void setFirstName(String val) {
    _firstName = val;
  }

  void setLastName(String val) {
    _lastName = val;
  }

  void setUserName(String val) {
    _userName = val;
  }

  void setWaitlistId(String val) {
    _waitistId = val;
  }

  void setPhoneNumber(String val) {
    _phoneNumber = val;
  }

  void setPassword(String val) {
    _password = val;
  }

  void setConfirmPassword(String val) {
    _confirmPassword = val;
  }
}
