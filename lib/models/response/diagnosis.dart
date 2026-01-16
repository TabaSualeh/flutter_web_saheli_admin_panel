import 'dart:convert';

DiagnosisResponse diagnosisResponseFromJson(String str) => DiagnosisResponse.fromJson(json.decode(str));

String diagnosisResponseToJson(DiagnosisResponse data) => json.encode(data.toJson());

class DiagnosisResponse {
  final bool? success;
  final List<DiagnosisItem>? data;

  DiagnosisResponse({
    this.success,
    this.data,
  });

  factory DiagnosisResponse.fromJson(Map<String, dynamic> json) {
    return DiagnosisResponse(
      success: json['success'],
      data: (json['data'] as List<dynamic>?)?.map((e) => DiagnosisItem.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}

class DiagnosisItem {
  final String? diagnosis;

  DiagnosisItem({this.diagnosis});

  factory DiagnosisItem.fromJson(Map<String, dynamic> json) {
    return DiagnosisItem(
      diagnosis: json['diagnosis'],
    );
  }

  Map<String, dynamic> toJson() => {
        'diagnosis': diagnosis,
      };
}
