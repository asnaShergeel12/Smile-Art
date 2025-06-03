import '../app_enums.dart';

class AlignerProgressModel {
  String id;
  String userId;
  String mediaUrl;
  MediaType mediaType;
  ProgressType progressType;
  int alignerNumber;
  DateTime createdAt;

  AlignerProgressModel({
    required this.id,
    required this.userId,
    required this.mediaUrl,
    required this.mediaType,
    required this.progressType,
    required this.alignerNumber,
    DateTime? createdAt,
  }) : createdAt = DateTime.now().toUtc();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'media_url': mediaUrl,
      'media_type': mediaType.name,
      'progress_type': progressType.name,
      'aligner_number': alignerNumber,
      'created_at': createdAt.toIso8601String(),
    };
  }

  static AlignerProgressModel fromJson(Map<String, dynamic> json) {
    return AlignerProgressModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      mediaUrl: json['media_url'] ?? '',
      mediaType: MediaType.values.byName(json['media_type']),
      progressType: ProgressType.values.byName(json['progress_type']),
      alignerNumber: json['aligner_number'] ?? 0,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ??
          DateTime.now().toUtc(),
    );
  }
}
