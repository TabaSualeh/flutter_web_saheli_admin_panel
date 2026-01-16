// import 'package:flutter/material.dart';
// import 'package:saheli_admin_panel/constants/sharePref_constants.dart';
// import 'package:saheli_admin_panel/utils/app_model.dart';
//
// import '../../api/auth_api.dart';
//
// class LoginController extends ChangeNotifier {
//   bool isLoading = false;
//   String? loginMessage;
//   String? errorMessage;
//   int? adminId;
//
//   Future<void> login(String email) async {
//     isLoading = true;
//     errorMessage = null;
//     notifyListeners();
//
//     try {
//       final response = await AuthApi.login(email);
//       adminId = response['user']['id'];
//       loginMessage = response['message'];
//       AppModel.instance.setIntInPref(SharePrefConstants.adminId, adminId!);
//     } catch (e) {
//       errorMessage = e.toString();
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';

import '../../api/auth_api.dart';
import '../../constants/sharePref_constants.dart';
import '../../utils/app_model.dart';

class LoginController extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  String? loginMessage;

  // After login
  bool emailReadOnly = false;
  bool showOtpField = false;

  String? otp;
  int? adminId;
  String? adminName;
  String? adminEmail;
  String? adminContact;
  DateTime? otpExpiry;
  Duration otpRemaining = Duration.zero;
  Timer? _otpTimer;

  // ------------------- Login -------------------
  Future<void> login(String email) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await AuthApi.login(email);

      // Save user info
      adminId = response['user']['id'];
      adminName = response['user']['name'];
      adminContact = response['user']['contact'];
      adminEmail = response['user']['email'];
      AppModel.instance.setIntInPref(SharePrefConstants.adminId, adminId!);
      AppModel.instance.setStringInPref(SharePrefConstants.adminName, adminName!);
      AppModel.instance.setStringInPref(SharePrefConstants.adminContact, adminContact!);
      AppModel.instance.setStringInPref(SharePrefConstants.adminEmail, adminEmail!);
      loginMessage = response['message'];

      emailReadOnly = true;

      showOtpField = true;

      otpExpiry = DateTime.parse(response['otpExpiredAt']).toLocal();

      _startOtpCountdown();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ------------------- OTP Countdown -------------------
  void _startOtpCountdown() {
    _otpTimer?.cancel();

    if (otpExpiry == null) return;

    otpRemaining = otpExpiry!.difference(DateTime.now());
    notifyListeners();

    _otpTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      otpRemaining = otpExpiry!.difference(DateTime.now());
      if (otpRemaining.isNegative) {
        _otpTimer?.cancel();
      }
      notifyListeners();
    });
  }

  String get otpRemainingFormatted {
    if (otpRemaining.isNegative) return "Expired";
    final minutes = otpRemaining.inMinutes;
    final seconds = otpRemaining.inSeconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  // ------------------- Verify OTP -------------------
  Future<bool> verifyOtp(String enteredOtp) async {
    if (adminId == null) return false;

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await AuthApi.verifyOtp(adminId: adminId!, otp: int.parse(enteredOtp));

      AppModel.instance.setStringInPref(SharePrefConstants.adminToken, response['token']);

      _otpTimer?.cancel();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _otpTimer?.cancel();
    super.dispose();
  }
}
