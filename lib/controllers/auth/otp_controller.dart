import 'package:flutter/material.dart';

import '../../api/auth_api.dart';

class OtpController extends ChangeNotifier {
  bool isLoading = false;
  String? token;
  String? error;

  Future<void> verifyOtp(int adminId, int otp) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await AuthApi.verifyOtp(
        adminId: adminId,
        otp: otp,
      );
      token = response['token'];
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
