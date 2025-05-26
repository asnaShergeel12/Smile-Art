class OtpModel {
  String id;
  String userId;
  int otp;
  bool isUsed;
  DateTime createdAt;
  DateTime expiringAt;

  OtpModel(
      {required this.id,
      required this.userId,
      required this.otp,
      required this.isUsed,
      required this.createdAt,
      required this.expiringAt});

  // static
}
