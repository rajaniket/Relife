import 'package:flutter/material.dart';
import 'package:relife/model/service%20model/referral_register_model.dart';
import 'package:relife/services/API/referral_register_service.dart';

class ReferralRegisterProvider extends ChangeNotifier {
  String _referalId = 'xyz';

  ReferralRegisterModel referralRegisterModel = ReferralRegisterModel(
    firstName: 'firstName',
    username: 'username',
    password: 'password',
    confirmPassword: 'confirmPassword',
    lastName: 'lastName',
  );

  String get refferalId => _referalId;

  Future<int?> referralRegisterFun() async {
    final response = await ReferralRegisterService()
        .referralRegister(referralRegisterModel, _referalId);

    return response;
  }

  void setReferralId(String val) {
    _referalId = val;
    notifyListeners();
  }
}
