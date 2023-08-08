import 'package:flutter/material.dart';
import 'package:relife/model/service%20model/forgot_password_model.dart';
import 'package:relife/services/API/forgot_password_service.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  String _message = '';

  String get message => _message;
  ForgortPasswordRequestModel forgortPasswordRequestModel =
      ForgortPasswordRequestModel(email: 'email');

  ForgotPasswordResponseModel? forgotPasswordResponseModel;
  Future<int?> forgotPassword() async {
    forgotPasswordResponseModel = await ForgotPasswordService()
        .forgotPassword(forgortPasswordRequestModel);

    if (forgotPasswordResponseModel != null) {
      setMessage(forgotPasswordResponseModel!.message);
      // debugPrint('mail sent');
      return 200;
    } else {
      setMessage('something went wrong');
    }
    notifyListeners();
  }

  void setMessage(String value) {
    _message = value;
    notifyListeners();
  }
}
