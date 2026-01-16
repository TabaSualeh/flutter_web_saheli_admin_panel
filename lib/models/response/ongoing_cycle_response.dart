import 'dart:convert';

import 'package:saheli_admin_panel/models/period_cycles.dart';

OnGoingCycleResponse onGoingCycleResponseFromJson(String str) => OnGoingCycleResponse.fromJson(json.decode(str));

String onGoingCycleResponseToJson(OnGoingCycleResponse data) => json.encode(data.toJson());

class OnGoingCycleResponse {
  final bool success;
  final List<PeriodCycle> cycles;

  OnGoingCycleResponse({
    required this.success,
    required this.cycles,
  });

  factory OnGoingCycleResponse.fromJson(Map<String, dynamic> json) {
    return OnGoingCycleResponse(
      success: json['success'] ?? false,
      cycles: (json['data'] as List<dynamic>? ?? []).map((e) => PeriodCycle.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': cycles.map((e) => e.toJson()).toList(),
      };
}
