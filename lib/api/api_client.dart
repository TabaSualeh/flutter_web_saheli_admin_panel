import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'api_exception.dart';

class ApiClient {
  ApiClient._();
  static const Duration _timeout = Duration(seconds: 30);

  static Map<String, String> _headers({String? token}) => {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

  // ================= POST =================
  static Future<dynamic> post(
    String url, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: _headers(token: token),
            body: jsonEncode(body),
          )
          .timeout(_timeout);

      return _processResponse(response);
    } on http.ClientException catch (e) {
      throw ApiException(e.message);
    } on SocketException {
      throw ApiException('No Internet connection');
    } on TimeoutException {
      throw ApiException('Request timeout');
    } catch (e) {
      rethrow;
    }
  }

  // ================= GET =================
  static Future<dynamic> get(
    String url, {
    String? token,
  }) async {
    try {
      final response = await http
          .get(
            Uri.parse(url),
            headers: _headers(token: token),
          )
          .timeout(_timeout);

      return _processResponse(response);
    } on SocketException {
      throw ApiException('No Internet connection');
    } on TimeoutException {
      throw ApiException('Request timeout');
    } catch (e) {
      rethrow;
    }
  }

  static dynamic _processResponse(http.Response response) {
    // Always log status code
    print('STATUS CODE: ${response.statusCode}');

    // Try to decode JSON safely
    dynamic decoded;
    try {
      decoded = jsonDecode(response.body);
    } catch (e) {
      // If response is not JSON
      print('RAW RESPONSE BODY: ${response.body}');
      throw ApiException('Invalid server response');
    }

    // Success
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decoded;
    }

    // Log API error response
    print('API ERROR RESPONSE: $decoded');

    // Extract error message safely
    final errorMessage = decoded is Map<String, dynamic> ? decoded['message']?.toString() : null;

    throw ApiException(
      errorMessage ?? 'Something went wrong',
    );
  }
}
