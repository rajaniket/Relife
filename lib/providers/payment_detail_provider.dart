import 'package:flutter/material.dart';
import 'package:relife/model/service%20model/get_payment_details.dart';
import 'package:relife/services/API/get_payment_details_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentDetailProvider extends ChangeNotifier {
  String _planName = 'trial';
  String _validTill = DateTime.now().toLocal().toString();
  int _totalReferral = 0;
  bool _showCancelButton = true;
  CurrentSub? _currentSub;

  PaymentDetailsModel? paymentDetailsModel;

  String get planName => _planName;
  String get validTill => _validTill;
  int get totalReferral => _totalReferral;
  bool get showCancleButton => _showCancelButton;
  CurrentSub? get currentSub => _currentSub;

  Future<String?> getsharedToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  Future<void> getPaymentDetials() async {
    final String? token = await getsharedToken();
    paymentDetailsModel = await GetPaymentServiceDetials()
        .getPaymentDetails(token!)
        .then((value) {
      setPlanName(value!.details.planName);
      setValidTill(value.details.validTill);
      setTotalReferral(value.details.totalReferrals);
      setShowCancleButton(value.details.showCancelButton!);
      setCurrentSub(value.details.currentSub);
    });
    notifyListeners();
    return;
  }

  void setPlanName(String val) {
    _planName = val;
    // notifyListeners();
  }

  void setValidTill(String val) {
    _validTill = val;
    // notifyListeners();
  }

  void setTotalReferral(int val) {
    _totalReferral = val;
    // notifyListeners();
  }

  void setShowCancleButton(bool val) {
    _showCancelButton = val;
    // notifyListeners();
  }

  void setCurrentSub(CurrentSub? val) {
    _currentSub = val;
    // notifyListeners();
  }
}
