import 'package:flutter/material.dart';
import 'package:relife/model/service%20model/reset_password_model.dart';
import 'package:relife/services/API/reset_password_service.dart';

class ResetPasswordProvider extends ChangeNotifier {
  String _message = '';

  ResetPasswordResponseModel? resetPasswordResponseModel;
  ResetPasswordRequestModel resetPasswordRequestModel =
      ResetPasswordRequestModel(
          newPassword: 'newPassword', confirmPassword: 'confirmPassword');

  //getters
  String get message => _message;
  void resetPassword(String token) async {
    resetPasswordResponseModel = await ResetPasswordService()
        .resetPassword(resetPasswordRequestModel, token);

    if (resetPasswordResponseModel != null) {
      setMessage(resetPasswordResponseModel!.message);
    } else {
      setMessage('something went wrong');
    }
    notifyListeners();
  }

  //setters
  void setMessage(String val) {
    _message = val;
    notifyListeners();
  }
}
