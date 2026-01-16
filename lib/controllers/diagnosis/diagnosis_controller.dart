import 'package:flutter/material.dart';

import '../../api/diagnosis_api.dart';
import '../../models/response/diagnosis.dart';
import '../../models/response/diagnosis_stats_response.dart';

class DiagnosisController extends ChangeNotifier {
  // -------------------- Loading States --------------------
  bool isDiagnosisLoading = false;
  bool isStatsLoading = false;

  // -------------------- Data --------------------
  var diagnoses = <DiagnosisItem>[];
  DiagnosisStatsData? statsData;

  // -------------------- Load AI Diagnoses --------------------
  Future<void> loadDiagnoses(String token) async {
    isDiagnosisLoading = true;
    notifyListeners();

    try {
      final response = await DiagnosisApi.getAiDiagnosis(token: token);
      final parsed = DiagnosisResponse.fromJson(response);

      diagnoses = parsed.data ?? [];
    } finally {
      isDiagnosisLoading = false;
      notifyListeners();
    }
  }

  // -------------------- Load Diagnosis User Stats --------------------
  Future<void> loadDiagnosisStats(String token) async {
    isStatsLoading = true;
    notifyListeners();

    try {
      final response = await DiagnosisApi.getDiagnosisUserStats(token: token);
      final parsed = DiagnosisStatsResponse.fromJson(response);

      statsData = parsed.data;
    } finally {
      isStatsLoading = false;
      notifyListeners();
    }
  }

  // -------------------- Load All Data --------------------
  Future<void> loadAll(String token) async {
    await Future.wait([
      loadDiagnoses(token),
      loadDiagnosisStats(token),
    ]);
  }
}
