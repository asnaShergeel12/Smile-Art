class OtpModel {
  String? id;
  int otp;
  String email;
  bool isUsed;
  DateTime createdAt;
  DateTime expiringAt;

  OtpModel(
      {this.id,
      required this.otp,
      required this.email,
      required this.isUsed,
      required this.createdAt,
      required this.expiringAt});

  Map<String, dynamic> toJson() {
    return {
      'otp': otp,
      'email': email,
      'is_used': isUsed,
      'created_at': createdAt.toString(),
      'expiring_at': expiringAt.toString(),
    };
  }

  static OtpModel fromJson(Map<String, dynamic> json) {
    return OtpModel(
      id: json['id'],
      email: json['email'] ?? '',
      otp: json['otp'] ?? 0,
      isUsed: json['is_used'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      expiringAt: DateTime.parse(json['expiring_at']),
    );
  }
}
