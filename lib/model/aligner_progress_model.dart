import '../app_enums.dart';

class AlignerProgressModel {
  String? id;
  String userId;
  String mediaUrl;
  String? thumbnailUrl;
  MediaType mediaType;
  ProgressType progressType;
  int? alignerNumber;
  DateTime createdAt;

  AlignerProgressModel({
    this.id,
    required this.userId,
    required this.mediaUrl,
    this.thumbnailUrl,
    required this.mediaType,
    required this.progressType,
    this.alignerNumber,
    DateTime? createdAt,
  }) : createdAt = DateTime.now().toUtc();

  String get formattedDate {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final day = createdAt.day.toString().padLeft(2, '0');
    final month = months[createdAt.month - 1];
    final year = createdAt.year;
    return '$day/$month/$year';
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'user_id': userId,
      'media_url': mediaUrl,
      'thumbnail_url': thumbnailUrl,
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
      thumbnailUrl: json['thumbnail_url'] ?? '',
      mediaType: MediaType.values.byName(json['media_type']),
      progressType: ProgressType.values.byName(json['progress_type']),
      alignerNumber: json['aligner_number'] ?? 0,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ??
          DateTime.now().toUtc(),
    );
  }
}
