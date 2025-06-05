import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/controller/media_controller.dart';
import 'package:smile_art/view/screens/home/video_playing.dart';
import 'package:smile_art/view/widgets/custom_appbar.dart';
import 'package:smile_art/view/widgets/my_text_widget.dart';
import '../../../app_enums.dart';
import '../../../generated/assets.dart';
import '../../../model/aligner_progress_model.dart';

class Media extends StatelessWidget {
  final mediaController = Get.find<MediaController>();

  Media({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("Media", isLeading: false),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                height: 32,
                child: ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding:
                            EdgeInsets.only(left: i == 0 ? 18.0 : 0, right: 6),
                        child: Obx(
                          () => GestureDetector(
                            onTap: () {
                              mediaController.setIndex(i);
                            },
                            child: Container(
                              height: 32,
                              width: 112,
                              decoration: BoxDecoration(
                                  color: mediaController.getIndex == i
                                      ? kPrimaryColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: kPrimaryColor)),
                              child: Center(
                                  child: MyText(
                                text: mediaController.categoryList[i],
                                color: mediaController.getIndex == i
                                    ? kSecondaryColor
                                    : kPrimaryColor,
                                size: 12,
                                weight: FontWeight.w600,
                              )),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 22,
                      color: kPrimaryColor,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    MyText(
                      text: "Your Smile Transformation Journey",
                      size: 16,
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              _buildMediaList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMediaList() {
    return Obx(
          () {
        final index = mediaController.getIndex;
        final mediaList = mediaController.mediaList;

        return SizedBox(
          height: 400,
          child: ListView.builder(
            itemCount: mediaList.isNotEmpty ? mediaList.length : 2,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, i) {
              if (mediaList.isNotEmpty) {
                final item = mediaList[i];
                if (item.progressType == ProgressType.video) {
                  return _buildVideoItem(item);
                } else {
                  return _buildMediaItem(item);
                }
              } else {
                return index == 2 ? _buildDummyVideoItem() : _buildDummyMediaItem(index);
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildVideoItem(AlignerProgressModel item) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 10),
      child: GestureDetector(
        onTap: () {
          Get.to(const VideoPlaying());
        },
        child: Stack(
          children: [
            Container(
            height: 400,
            width: 215,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
            ),
            child: _buildMediaItemDetails(item, item.thumbnailUrl ?? ''),
          ),
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 77),
                child: CircleAvatar(
                  backgroundColor: kPrimaryColor,
                  radius: 30,
                  child: Icon(Icons.play_arrow, color: kSecondaryColor, size: 30),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMediaItem(AlignerProgressModel item) {
    final imageUrl = item.progressType == ProgressType.video
        ? (item.thumbnailUrl ?? '')
        : (item.mediaUrl ?? '');
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 10),
      child: Container(
        height: 400,
        width: 215,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
        ),
        child: _buildMediaItemDetails(item, imageUrl ?? ''),
      ),
    );
  }

  Widget _buildDummyVideoItem() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 10),
      child: Stack(
        children: [
          Container(
            height: 400,
            width: 215,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              image: const DecorationImage(image: AssetImage(Assets.imagesVideoSelfie)),
            ),
            child: _buildDummyMediaItemDetails(),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 77),
              child: CircleAvatar(
                backgroundColor: kPrimaryColor,
                radius: 30,
                child: Icon(Icons.play_arrow, color: kSecondaryColor, size: 30),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDummyMediaItem(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 10),
      child: Container(
        height: 400,
        width: 215,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          image: const DecorationImage(image: AssetImage(Assets.imagesSelf)),
        ),
        child: _buildDummyMediaItemDetails(),
      ),
    );
  }

  Widget _buildMediaItemDetails(AlignerProgressModel item, String imageUrl) {
    return Stack(
      children: [
        // Image with bottom corners rounded
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(14),
            bottomRight: Radius.circular(14),
          ),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: kPrimaryColor,)),
            errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined, color: kPrimaryColor, size: 30),
            fit: BoxFit.fill,
            height: 400,
            width: 215,
          ),
        ),
        _buildPopupMenu(item),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText(
                text: item.formattedDate,
                size: 24,
                weight: FontWeight.w700,
                color: kSecondaryColor,
              ),
              MyText(
                text: "Aligner # ${item.alignerNumber}",
                size: 18,
                weight: FontWeight.w700,
                color: kSecondaryColor,
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDummyMediaItemDetails() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildPopupMenu(null),
        Column(
          children: [
            MyText(text: "12/Jan/2025", size: 24, weight: FontWeight.w700, color: kSecondaryColor),
            MyText(text: "Aligner # 1", size: 18, weight: FontWeight.w700, color: kSecondaryColor),
            const SizedBox(height: 18),
          ],
        ),
      ],
    );
  }

  Widget _buildPopupMenu(AlignerProgressModel? media) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        PopupMenuButton(
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
          color: kSecondaryColor,
          menuPadding: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.more_vert, color: kSecondaryColor, size: 20),
          onSelected: (value) {
            if (media != null) {
              switch (value) {
                case 'edit':
                  mediaController.editMedia(media: media);
                  break;
                case 'delete':
                  mediaController.deleteMedia(media);
                  break;
              }
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(height: 30, padding: const EdgeInsets.only(left: 8), value: 'edit', child: MyText(text: "Edit", size: 8,)),
            PopupMenuItem(height: 30, padding: const EdgeInsets.only(left: 8), value: 'delete', child: MyText(text: "Delete", size: 8,)),
          ],
        ),
      ],
    );
  }

}
