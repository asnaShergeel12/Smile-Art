import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/controller/bottom_nav_controller.dart';
import 'package:smile_art/controller/media_controller.dart';
import 'package:smile_art/view/screens/home/educational_hub.dart';
import 'package:smile_art/view/screens/home/home.dart';
import 'package:smile_art/view/screens/media/media.dart';
import 'package:smile_art/view/widgets/common_image_widget.dart';
import '../../../generated/assets.dart';
import '../home/calender.dart';

class CustomBottomNavBar extends StatelessWidget {
  final bottomNavBarController = Get.find<BottomNavController>();
  final mediaController = Get.find<MediaController>;

  final List<Widget> screens = [
    Home(),
    Calendar(),
    Media(),
    EducationalHub(),
  ];


  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
          body: screens[bottomNavBarController.currentIndex.value],
          floatingActionButton: FloatingActionButton(
            elevation: 0,
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide.none,
            ),
            onPressed: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? photo =
              await picker.pickImage(source: ImageSource.camera);

              if (photo != null) {
                // Do something with the captured photo, e.g., display or upload
                print('Captured image path: ${photo.path}');
              }
                bottomNavBarController.currentIndex.value = 0;
            },
            backgroundColor: kPrimaryColor,
            child: CommonImageView(
              svgPath: Assets.bottomTablerCamera,
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: CustomBottomAppBar(
            currentIndex: bottomNavBarController.currentIndex.value,
            onTabSelected: (index) => bottomNavBarController.changeTab(index),
          ),

      ),
    );
  }
}

class CustomBottomAppBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const CustomBottomAppBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CustomNotchedShape(),
      notchMargin: 6.0,
      color: Color(0xffF3F3F3),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTabItem(
              selectedIcon: Assets.bottomHomFill,
              unselectedIcon: Assets.bottomHom,
              label: "Home",
              index: 0,
              selected: currentIndex == 0,
              onTap: onTabSelected,
            ),
            _buildTabItem(
              selectedIcon: Assets.bottomCalFill,
              unselectedIcon: Assets.bottomUitCalender,
              label: "Calendar",
              index: 1,
              selected: currentIndex == 1,
              onTap: onTabSelected,
            ),
            SizedBox(width: Get.width / 5),
            _buildTabItem(
              selectedIcon: Assets.bottomMediaFill,
              unselectedIcon: Assets.bottomMediaIc,
              label: "Media",
              index: 2,
              selected: currentIndex == 2,
              onTap: onTabSelected,
            ),
            _buildTabItem(
              selectedIcon: Assets.bottomHubFill,
              unselectedIcon: Assets.bottomHub,
              label: "EdHub",
              index: 3,
              selected: currentIndex == 3,
              onTap: onTabSelected,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required String selectedIcon,
    required String unselectedIcon,
    required String label,
    required int index,
    required bool selected,
    required Function(int) onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              selected ? selectedIcon : unselectedIcon,
              height: 24,
              width: 24,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontFamily: "Manrope",
                color: selected ? kPrimaryColor : kGreyColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomNotchedShape extends NotchedShape {
  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null) return Path()..addRect(host);

    final double notchRadius = guest.width / 1.6;
    final double notchCenterX = guest.center.dx;
    final double notchCenterY = host.top;
    const double cornerRadius = 17.0;

    final Path path = Path()
      ..moveTo(host.left, host.top)
      ..lineTo(notchCenterX - notchRadius - cornerRadius, host.top)
      ..arcToPoint(
        Offset(notchCenterX - notchRadius, notchCenterY - 10),
        radius: const Radius.circular(cornerRadius),
        clockwise: false,
      )
      ..quadraticBezierTo(
        notchCenterX,
        notchCenterY - 70,
        notchCenterX + notchRadius,
        notchCenterY - 10,
      )
      ..arcToPoint(
        Offset(notchCenterX + notchRadius + cornerRadius, host.top),
        radius: const Radius.circular(cornerRadius),
        clockwise: false,
      )
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();

    return path;
  }
}
