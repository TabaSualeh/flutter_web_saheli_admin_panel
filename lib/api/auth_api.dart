import '../constants/api_uris.dart';
import 'api_client.dart';

class AuthApi {
  static Future<Map<String, dynamic>> login(String email) async {
    return await ApiClient.post(
      ApiUri.continueWithEmail,
      body: {'email': email},
    );
  }

  static Future<Map<String, dynamic>> verifyOtp({
    required int adminId,
    required int otp,
  }) async {
    return await ApiClient.post(
      ApiUri.verifyOtp,
      body: {
        'id': adminId,
        'otp': otp,
      },
    );
  }
}
