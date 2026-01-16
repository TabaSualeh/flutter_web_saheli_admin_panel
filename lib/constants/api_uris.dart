import '../environment/environment_class.dart';

class ApiUri {
  static get https => 'https://';

  static get http => 'http://';
  // static get admin => '/admin';

  static bool useHttps = Environment().config!.useHttps;
  static String get _baseUrl {
    final protocol = useHttps ? https : http;
    return '$protocol${Environment().config!.apiHost}/app';
  }

  // ================= DASHBOARD =================
  static String getAllUsers({required int page, required int limit}) => '$_baseUrl/admin/getAllUsers?page=$page&limit=$limit';

  static String get getAllOnGoingCycles => '$_baseUrl/admin/getAllOnGoingCycles';
  // ================= AUTH =================
  static String get continueWithEmail => '$_baseUrl/admin/auth';
  static String get verifyOtp => '$_baseUrl/admin/verifyOtp';
  // ================= AUTH =================
  static String get getAiDiagnosis => '$_baseUrl/admin/getAiDiagnosis';
  static String get getDiagnosisUserStats => '$_baseUrl/admin/getDiagnosisUserStats';
}
