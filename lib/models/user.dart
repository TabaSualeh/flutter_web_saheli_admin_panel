class User {
  final int? id;
  final String? name;
  final String? email;

  /// User info
  final DateTime? dateOfBirth;
  final bool? isPregnant;
  final int? activePregnancyId;
  final String? bloodGroup;
  final String? medicalHistory;

  /// Timestamps
  final DateTime? createdAt;
  final DateTime? updatedAt;

  /// 🔹 Cycle related (flattened from API)
  final DateTime? startDate;
  final DateTime? endDate;
  final int? cycleLength;
  final int? periodDuration;

  User({
    this.id,
    this.name,
    this.email,
    this.dateOfBirth,
    this.isPregnant,
    this.activePregnancyId,
    this.bloodGroup,
    this.medicalHistory,
    this.createdAt,
    this.updatedAt,
    this.startDate,
    this.endDate,
    this.cycleLength,
    this.periodDuration,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],

      dateOfBirth: DateTime.tryParse(json['dateOfBirth'] ?? ''),
      isPregnant: json['isPregnant'],
      activePregnancyId: json['activePregnancyId'],
      bloodGroup: json['bloodGroup'],
      medicalHistory: json['medicalHistory'],

      createdAt: DateTime.tryParse(json['createdAt'] ?? ''),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? ''),

      /// Cycle fields
      startDate: DateTime.tryParse(json['startDate'] ?? ''),
      endDate: DateTime.tryParse(json['endDate'] ?? ''),
      cycleLength: json['cycleLength'],
      periodDuration: json['periodDuration'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'dateOfBirth': dateOfBirth?.toIso8601String(),
        'isPregnant': isPregnant,
        'activePregnancyId': activePregnancyId,
        'bloodGroup': bloodGroup,
        'medicalHistory': medicalHistory,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'cycleLength': cycleLength,
        'periodDuration': periodDuration,
      };
}
