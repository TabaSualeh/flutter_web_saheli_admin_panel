import 'dart:convert';

DiagnosisStatsResponse diagnosisStatsResponseFromJson(String str) => DiagnosisStatsResponse.fromJson(json.decode(str));

String diagnosisStatsResponseToJson(DiagnosisStatsResponse data) => json.encode(data.toJson());

class DiagnosisStatsResponse {
  final bool? success;
  final DiagnosisStatsData? data;

  DiagnosisStatsResponse({
    this.success,
    this.data,
  });

  factory DiagnosisStatsResponse.fromJson(Map<String, dynamic> json) {
    return DiagnosisStatsResponse(
      success: json['success'],
      data: json['data'] != null ? DiagnosisStatsData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data?.toJson(),
      };
}

class DiagnosisStatsData {
  final int? totalUsers;
  final List<DiagnosisStat>? diagnosisStats;

  DiagnosisStatsData({
    this.totalUsers,
    this.diagnosisStats,
  });

  factory DiagnosisStatsData.fromJson(Map<String, dynamic> json) {
    return DiagnosisStatsData(
      totalUsers: json['totalUsers'],
      diagnosisStats: (json['diagnosisStats'] as List<dynamic>?)?.map((e) => DiagnosisStat.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'totalUsers': totalUsers,
        'diagnosisStats': diagnosisStats?.map((e) => e.toJson()).toList(),
      };
}

class DiagnosisStat {
  final String? diagnosis;
  final int? userCount;
  final double? percentage;

  DiagnosisStat({
    this.diagnosis,
    this.userCount,
    this.percentage,
  });

  factory DiagnosisStat.fromJson(Map<String, dynamic> json) {
    return DiagnosisStat(
      diagnosis: json['diagnosis'],
      userCount: json['userCount'],
      percentage: (json['percentage'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'diagnosis': diagnosis,
        'userCount': userCount,
        'percentage': percentage,
      };
}
