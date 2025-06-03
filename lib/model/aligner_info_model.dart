class AlignerInfoModel {
  String? id;
  String userId;
  int totalAlignerNumber;
  int currentAlignerNumber;
  int alignerWearDays;
  DateTime reminder;

  AlignerInfoModel({
    this.id,
    required this.userId,
    required this.totalAlignerNumber,
    required this.currentAlignerNumber,
    required this.alignerWearDays,
    required this.reminder,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'total_aligner_number': totalAlignerNumber,
      'current_aligner_number': currentAlignerNumber,
      'aligner_wear_days': alignerWearDays,
      'reminder': reminder.toString(),
    };
  }

  static AlignerInfoModel fromJson(Map<String, dynamic> json) {
    return AlignerInfoModel(
      id: json['id'],
      userId: json['user_id'],
      totalAlignerNumber: json['total_aligner_number'] ?? 0,
      currentAlignerNumber: json['current_aligner_number'] ?? 0,
      alignerWearDays: json['aligner_wear_days'] ?? 0,
      reminder: DateTime.parse(json['reminder']),
    );
  }

}
