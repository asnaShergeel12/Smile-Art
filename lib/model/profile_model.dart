class ProfileModel {
  String id;
  String firstName;
  String lastName;
  String email;
  String profilePicture;
  String deviceToken;
  bool isActive;
  bool isOnline;
  bool isVerified;
  DateTime createdAt;

  ProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.profilePicture = 'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
    this.deviceToken = '',
    this.isActive = true,
    this.isOnline = true,
    this.isVerified = true,
    DateTime? createdAt,
  }):createdAt = DateTime.now().toUtc();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'profile_picture': profilePicture,
      'device_token': deviceToken,
      'is_active': isActive,
      'is_online': isOnline,
      'is_verified': isVerified,
      'created_at': createdAt.toString(),
    };
  }

  static ProfileModel fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        id: json['id'] ?? '',
        firstName: json['first_name'] ?? '',
        lastName: json['last_name'] ?? '',
        email: json['email'] ?? '',
        profilePicture: json['profile_picture'] ?? '',
        deviceToken: json['device_token'] ?? '',
        isActive: json['is_active'] ?? true,
        isOnline: json['is_online'] ?? true,
        isVerified: json['is_verified'] ?? true,
        createdAt: DateTime.parse(json['created_at']),
    );
  }
}
