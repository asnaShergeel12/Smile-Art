import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/view/widgets/common_image_widget.dart';
import 'package:smile_art/view/widgets/custom_appbar.dart';

import '../../../generated/assets.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:customAppbar("Calendar",isLeading: false),
      body: SingleChildScrollView(
        physics:BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMonth('January', generateJanuaryData()),
            const SizedBox(height: 0),
            _buildMonth('February', generateFebruaryData()),
            SizedBox(height: 48,)
          ],
        ),
      ),
    );
  }

  Widget _buildMonth(String monthName, List<List<DayData>> weeks) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            monthName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          _buildWeekdayLabels(),
          const SizedBox(height: 8),
          ...weeks.map((week) => _buildWeek(week)),
        ],
      ),
    );
  }

  Widget _buildWeekdayLabels() {
    final weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekdays
          .map((day) => SizedBox(
        width: 40,
        child: Text(
          day,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: kPrimaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ))
          .toList(),
    );
  }

  Widget _buildWeek(List<DayData> days) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: days.map((day) => _buildDay(day)).toList(),
      ),
    );
  }

  Widget _buildDay(DayData day) {
    return Column(
      children: [
        SizedBox(
          width: 40,
          child: Text(
            day.date.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: kDarkColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: day.status != DayStatus.empty
                ? Border.all(
              color: kPrimaryColor,
              width: 2.5,
            )
                : Border.all(
              color: kBorderColor!,
              width: 1,
            ),
          ),
          child: day.status != DayStatus.empty
              ? CircularPercentIndicator(
              backgroundColor: Colors.transparent,
              progressColor: kDarkBlueColor,
              radius: 13.0,
              lineWidth: 2.5,
              percent: 0.60,
              center: day.status == DayStatus.highlighted
                  ? CommonImageView(svgPath: Assets.iconsStars)
                  : null)
              : Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kBorderColor),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<List<DayData>> generateJanuaryData() {
    // January data with specific days marked
    List<List<DayData>> weeks = [];

    // Week 1: Dec 29 - Jan 4
    weeks.add([
      DayData(29, DayStatus.empty),
      DayData(30, DayStatus.empty),
      DayData(31, DayStatus.empty),
      DayData(1, DayStatus.empty),
      DayData(2, DayStatus.empty),
      DayData(3, DayStatus.active),
      DayData(4, DayStatus.active),
    ]);

    // Week 2: Jan 5 - 11
    weeks.add([
      DayData(5, DayStatus.active),
      DayData(6, DayStatus.active),
      DayData(7, DayStatus.active),
      DayData(8, DayStatus.active),
      DayData(9, DayStatus.highlighted),
      DayData(10, DayStatus.active),
      DayData(11, DayStatus.active),
    ]);

    // Week 3: Jan 12 - 18
    weeks.add([
      DayData(12, DayStatus.active),
      DayData(13, DayStatus.active),
      DayData(14, DayStatus.active),
      DayData(15, DayStatus.active),
      DayData(16, DayStatus.highlighted),
      DayData(17, DayStatus.active),
      DayData(18, DayStatus.active),
    ]);

    // Week 4: Jan 19 - 25
    weeks.add([
      DayData(19, DayStatus.active),
      DayData(20, DayStatus.active),
      DayData(21, DayStatus.active),
      DayData(22, DayStatus.active),
      DayData(23, DayStatus.highlighted),
      DayData(24, DayStatus.active),
      DayData(25, DayStatus.empty),
    ]);

    // Week 5: Jan 26 - Feb 1
    weeks.add([
      DayData(26, DayStatus.empty),
      DayData(27, DayStatus.empty),
      DayData(28, DayStatus.empty),
      DayData(29, DayStatus.empty),
      DayData(30, DayStatus.empty),
      DayData(31, DayStatus.empty),
      DayData(1, DayStatus.empty),
    ]);

    return weeks;
  }

  List<List<DayData>> generateFebruaryData() {
    // February data with all days empty
    List<List<DayData>> weeks = [];

    // Week 1: Jan 29 - Feb 4
    weeks.add([
      DayData(29, DayStatus.empty),
      DayData(30, DayStatus.empty),
      DayData(31, DayStatus.empty),
      DayData(1, DayStatus.empty),
      DayData(2, DayStatus.empty),
      DayData(3, DayStatus.empty),
      DayData(4, DayStatus.empty),
    ]);

    // Week 2: Feb 5 - 11
    weeks.add([
      DayData(5, DayStatus.empty),
      DayData(6, DayStatus.empty),
      DayData(7, DayStatus.empty),
      DayData(8, DayStatus.empty),
      DayData(9, DayStatus.empty),
      DayData(10, DayStatus.empty),
      DayData(11, DayStatus.empty),
    ]);

    // Week 3: Feb 12 - 18
    weeks.add([
      DayData(12, DayStatus.empty),
      DayData(13, DayStatus.empty),
      DayData(14, DayStatus.empty),
      DayData(15, DayStatus.empty),
      DayData(16, DayStatus.empty),
      DayData(17, DayStatus.empty),
      DayData(18, DayStatus.empty),
    ]);

    // Week 4: Feb 19 - 25
    weeks.add([
      DayData(19, DayStatus.empty),
      DayData(20, DayStatus.empty),
      DayData(21, DayStatus.empty),
      DayData(22, DayStatus.empty),
      DayData(23, DayStatus.empty),
      DayData(24, DayStatus.empty),
      DayData(25, DayStatus.empty),
    ]);

    // Week 5: Feb 26 - Mar 2
    weeks.add([
      DayData(26, DayStatus.empty),
      DayData(27, DayStatus.empty),
      DayData(28, DayStatus.empty),
      DayData(29, DayStatus.empty),
      DayData(30, DayStatus.empty),
      DayData(31, DayStatus.empty),
      DayData(1, DayStatus.empty),
    ]);

    return weeks;
  }
}

enum DayStatus {
  empty,    // Grey circle outline
  active,   // Blue circle outline
  highlighted,  // Blue circle outline with yellow dot
}

class DayData {
  final int date;
  final DayStatus status;

  DayData(this.date, this.status);
}