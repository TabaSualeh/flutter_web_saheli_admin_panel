import '../constants/api_uris.dart';
import 'api_client.dart';

class DiagnosisApi {
  static Future<Map<String, dynamic>> getAiDiagnosis({
    required String token,
  }) async {
    return await ApiClient.get(
      ApiUri.getAiDiagnosis,
      token: token,
    );
  }

  static Future<Map<String, dynamic>> getDiagnosisUserStats({
    required String token,
  }) async {
    return await ApiClient.get(
      ApiUri.getDiagnosisUserStats,
      token: token,
    );
  }
}
