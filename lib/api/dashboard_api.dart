import '../constants/api_uris.dart';
import 'api_client.dart';

class DashboardApi {
  static Future<Map<String, dynamic>> getAllUsers({
    required int page,
    required int limit,
    required String token,
  }) async {
    return await ApiClient.get(
      ApiUri.getAllUsers(page: page, limit: limit),
      token: token,
    );
  }

  static Future<Map<String, dynamic>> getAllOngoingCycles({
    required String token,
  }) async {
    return await ApiClient.get(
      ApiUri.getAllOnGoingCycles,
      token: token,
    );
  }
}
