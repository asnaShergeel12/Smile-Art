import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smile_art/model/aligner_progress_model.dart';
import 'package:smile_art/view/widgets/custom_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../app_enums.dart';

class MediaController extends GetxController {
  var selectedIndex = 0.obs;
  final supabaseClient = Supabase.instance.client;
  var mediaList = <AlignerProgressModel>[].obs;
  var isUploading = false.obs;

  final List<String> categoryList = [
    "Selfies",
    "Teeth Selfie",
    "Videos",
  ];

  // Map the tab index to ProgressType
  static const Map<int, ProgressType> indexToProgressType = {
  0: ProgressType.selfie,
  1: ProgressType.teethSelfie,
  2: ProgressType.video, };

  @override
  void onInit() {
    super.onInit();
    fetchMediaByProgressType(indexToProgressType[selectedIndex.value]!);
    selectedIndex.listen((i) {
      fetchMediaByProgressType(indexToProgressType[i]!);
    });
  }
  
  void setIndex(int i) {
    selectedIndex.value = i;
  }

  int get getIndex => selectedIndex.value;

  // Upload media to Supabase
  Future<void> uploadMedia({
    required File file,
    required MediaType mediaType,
    required ProgressType progressType,
    // required int alignerNumber,
  }) async {
    isUploading.value = true;
    try {
      final userId = supabaseClient.auth.currentUser?.id;

      if (userId == null) {
        CustomSnackbar.error(title: 'Error', message: 'User not authenticated.');
        return;
      }

      final fileExt = file.path.split('.').last;
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.$fileExt';

      // Determine subfolder
      final subfolder = progressType.name;
      final filePath = '$subfolder/$userId/$fileName';

      // Upload to Supabase Storage
      final uploadResponse = await supabaseClient.storage
          .from('media-bucket')
          .upload(filePath, file);

      if (uploadResponse.isEmpty) {
        CustomSnackbar.error(title: 'Error', message: 'Failed to upload media.');
        return;
      }

      // Get public URL
      final mediaUrl =
      supabaseClient.storage.from('media-bucket').getPublicUrl(filePath);

    String? thumbnailUrl;
    if (mediaType == MediaType.video) {
    // Generate thumbnail for video
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
    video: file.path,
    thumbnailPath: (await getTemporaryDirectory()).path,
    imageFormat: ImageFormat.JPEG,
    maxWidth: 400, // specify the width of the thumbnail
    quality: 215,
    );

    if (thumbnailPath != null) {
    // Upload thumbnail to Supabase Storage
    final thumbnailFile = File(thumbnailPath);
    final thumbnailFileName = 'thumbnails/${userId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
    await supabaseClient.storage.from('media-bucket').upload(thumbnailFileName, thumbnailFile);
    thumbnailUrl = supabaseClient.storage.from('media-bucket').getPublicUrl(thumbnailFileName);
    }
    }


    final currentAlignerNumber = await fetchCurrentImageCount(progressType);

      // Save metadata to Supabase DB
      final media = AlignerProgressModel(
        userId: userId,
        mediaUrl: mediaUrl,
        thumbnailUrl: thumbnailUrl,
        mediaType: mediaType,
        progressType: progressType,
        alignerNumber: currentAlignerNumber+1
      );

      final insertResponse = await supabaseClient
          .from('aligner_progress')
          .insert(media.toJson()).select();
      print("Aligner progress media uploaded successfully. $insertResponse");

      await fetchMediaByProgressType(progressType);
    } catch (e) {
      print('Upload Error: $e');
      CustomSnackbar.error(title: 'Upload Error', message: e.toString());
    } finally {
      isUploading.value = false;
    }
  }

  // Fetch the current count of images for the user and progress type
  Future<int> fetchCurrentImageCount(ProgressType progressType) async {
    try {
      final userId = supabaseClient.auth.currentUser ?.id;

      if (userId == null) {
        CustomSnackbar.error(title: 'Error', message: 'User  not authenticated.');
        return 0;
      }

      final response = await supabaseClient
          .from('aligner_progress')
          .select('aligner_number')
          .eq('user_id', userId)
          .eq('progress_type', progressType.name); // Filter by progress type

      if (response != null && response is List) {
        return response.length; // Return the count of images
      }
    } catch (e) {
      print('Fetch Count Error: $e');
      CustomSnackbar.error(title: 'Fetch Count Error', message: e.toString());
    }
    return 0; // Return 0 in case of an error
  }

  // Fetch media filtered by progress type
  Future<void> fetchMediaByProgressType(ProgressType type) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;

      if (userId == null) {
        CustomSnackbar.error(title: 'Error', message: 'User not authenticated.');
        return;
      }

      final response = await supabaseClient
          .from('aligner_progress')
          .select()
          .eq('user_id', userId)
          .eq('progress_type', type.name);

      if (response != null && response is List) {
        mediaList.value = response
            .map((item) => AlignerProgressModel.fromJson(item))
            .toList();
      }
    } catch (e) {
      print('Fetch Error: $e');
      CustomSnackbar.error(title: 'Fetch Error', message: e.toString());
    }
  }

  // Delete media entry
  Future<void> deleteMedia(AlignerProgressModel media) async {
    try {
      final filePath =
      Uri.parse(media.mediaUrl).pathSegments.skip(1).join('/');

      // Remove file from storage
      await supabaseClient.storage.from('media-bucket').remove([filePath]);

      // Delete metadata from database
      if (media.id != null) {
        await supabaseClient
            .from('aligner_progress')
            .delete()
            .eq('id', media.id!); // ensure id is not null
      }

      await fetchMediaByProgressType(media.progressType);
    } catch (e) {
      print('Delete Error: $e');
      CustomSnackbar.error(title: 'Delete Error', message: e.toString());
    }
  }

  Future<void> editMedia({
    required AlignerProgressModel media,
    int? alignerNumber,
    ProgressType? progressType,
  }) async {
    try {
      // Open camera to retake image or video based on media type
      final ImagePicker picker = ImagePicker();
      String? newMediaUrl;

      if (media.progressType == ProgressType.selfie || media.progressType == ProgressType.teethSelfie) {
        // Capture new image
        final XFile? newImage = await picker.pickImage(source: ImageSource.camera);
        if (newImage != null) {
          // Upload new image to storage
          final File file = File(newImage.path);
          final uploadResponse = await supabaseClient.storage
              .from('media-bucket')
              .upload('selfies/${media.userId}/${newImage.name}', file);

          if (uploadResponse.isNotEmpty) {
            newMediaUrl = supabaseClient.storage.from('media-bucket').getPublicUrl('selfies/${media.userId}/${newImage.name}');
          } else {
            CustomSnackbar.error(title: 'Error', message: 'Failed to upload new image.');
            return;
          }
        }
      } else if (media.progressType == ProgressType.video) {
        // Capture new video
        final XFile? newVideo = await picker.pickVideo(source: ImageSource.camera);
        if (newVideo != null) {
          // Upload new video to storage
          final File file = File(newVideo.path);
          final uploadResponse = await supabaseClient.storage
              .from('media-bucket')
              .upload('videos/${media.userId}/${newVideo.name}', file);

          if (uploadResponse.isNotEmpty) {
            newMediaUrl = supabaseClient.storage.from('media-bucket').getPublicUrl('videos/${media.userId}/${newVideo.name}');
          } else {
            CustomSnackbar.error(title: 'Error', message: 'Failed to upload new video.');
            return;
          }
        }
      }

      // Prepare updates
      final updates = <String, dynamic>{};
      if (newMediaUrl != null) {
        updates['media_url'] = newMediaUrl; // Update media URL with the new one
      }

      if (alignerNumber != null) {
        updates['aligner_number'] = alignerNumber;
      }

      if (progressType != null) {
        updates['progress_type'] = progressType.name;
      }

      if (updates.isEmpty || media.id == null) {
        CustomSnackbar.error(title: 'Error', message: 'Nothing to update or media ID missing.');
        return;
      }

      // Update the database with new media URL and other updates
      await supabaseClient
          .from('aligner_progress')
          .update(updates)
          .eq('id', media.id!);

      await fetchMediaByProgressType(progressType ?? media.progressType);
    } catch (e) {
      print('Edit Error: $e');
      CustomSnackbar.error(title: 'Edit Error', message: e.toString());
    }
  }

}
