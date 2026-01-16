import 'package:saheli_admin_panel/models/user.dart';

class PeriodCycle {
  final int? id;
  final int? userId;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? cycleLength;
  final int? periodDuration;
  final bool? isPredicted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;

  PeriodCycle({
    this.id,
    this.userId,
    this.startDate,
    this.endDate,
    this.cycleLength,
    this.periodDuration,
    this.isPredicted,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory PeriodCycle.fromJson(Map<String, dynamic> json) {
    return PeriodCycle(
      id: json['id'],
      userId: json['userId'],
      startDate: DateTime.tryParse(json['startDate'] ?? ''),
      endDate: DateTime.tryParse(json['endDate'] ?? ''),
      cycleLength: json['cycleLength'],
      periodDuration: json['periodDuration'],
      isPredicted: json['isPredicted'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? ''),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? ''),
      user: json['User'] != null ? User.fromJson(json['User']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'cycleLength': cycleLength,
        'periodDuration': periodDuration,
        'isPredicted': isPredicted,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'User': user?.toJson(),
      };
}
