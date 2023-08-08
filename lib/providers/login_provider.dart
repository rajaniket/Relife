import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:getsocial_flutter_sdk/getsocial_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:relife/model/service%20model/login_model.dart';
import 'package:relife/providers/profile_provider.dart';
import 'package:relife/services/API/login_service.dart';
import 'package:relife/services/GetSocial/create_identity_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isloginSuccess = false;
  String _message = '';
  String _firstName = '';
  String _userId = '';
  String _referralLink = "";
  LoginResponseModel? responseModel;
  LoginRequestModel requestModel =
      LoginRequestModel(email: 'email', password: 'password');

  bool get isLoading => _isLoading;
  String get message => _message;
  String get firstName => _firstName;
  String get userId => _userId;
  bool get isLoginSuccess => _isloginSuccess;
  String get referralLink => _referralLink;

  Future<bool> login(BuildContext context) async {
    setLoading(true);
    responseModel = await ApiService().login(requestModel);

    if (responseModel!.message == '') {
      setMessage('Login SuccessFul');
      await setSharedService();
      final String token =
          responseModel!.details['token'].toString().split(' ')[1];
      setFirstName(responseModel!.details['name']);
      setUserId(responseModel!.details['userId']);
      seRreferralLink(responseModel!.details['referralLink']);
      await Provider.of<ProfileProvider>(context, listen: false)
          .getProfile(context);
      await CreateIdentity().updateUserState(token);
      await updateUser(context);
      setLoginSuccess(true);
      // await GetSystemHabitsService().getSystemHabit(token);
      setLoading(false);
    } else {
      setLoginSuccess(false);
      setMessage(responseModel!.message!);
      setLoading(false);
    }

    notifyListeners();
    return _isloginSuccess;
  }

  Future<void> updateUser(BuildContext context) async {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    var user = await GetSocial.currentUser;

    if (!user!.isAnonymous) {
      var batchUpdate = UserUpdate();
      batchUpdate.updateDisplayName(
          profileProvider.firstName + ' ' + profileProvider.lastName);
      batchUpdate.updateAvatarUrl(
          'https://relife.co.in/api/${profileProvider.profilePicture}');

      log("https://relife.co.in/api/${profileProvider.profilePicture}");

      await user.updateDetails(batchUpdate);
      var userDetail = await GetSocial.currentUser;
      log("getSocial display name : ${userDetail!.displayName}");
      log("getSocial userId : ${userDetail.userId}");
      log("getSocial  pic : ${userDetail.avatarUrl}");
      log("getSocial display name : ${userDetail.publicProperties["relife_userId"]}");
    } else {
      log("user is anonymous so, couldn't able to update batch");
    }
    return;
  }

  Future<void> logOut() async {
    await removeSharedService();
    //await removeSharedServiceId();
    await CreateIdentity().removeIndentity();
    return;
  }

  Future<void> setSharedService() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('token', responseModel!.details['token']);
    sharedPreferences.setString('userId', responseModel!.details['userId']);
    sharedPreferences.setString(
        'referralLink', responseModel!.details['referralLink']);
  }

  Future<void> removeSharedService() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove('token');
    sharedPreferences.remove('userId');
    sharedPreferences.remove('isPostedToday');
  }

  void setMessage(String value) {
    _message = value;
    notifyListeners();
  }

  Future<String?> getUserId() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('userId');
  }

  void setFirstName(String value) {
    _firstName = value;
    notifyListeners();
  }

  void setUserId(String value) {
    _userId = value;
    notifyListeners();
  }

  void seRreferralLink(String val) {
    _referralLink = val;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setLoginSuccess(bool value) {
    _isloginSuccess = value;
    notifyListeners();
  }
}
