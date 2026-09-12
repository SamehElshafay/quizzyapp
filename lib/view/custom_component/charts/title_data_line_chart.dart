import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizzy_app/view/custom_component/custom_text.dart';

class CustomTitleDataLineChart {
  const CustomTitleDataLineChart();

  static FlTitlesData getTitles() {
    return FlTitlesData(
      show: true,
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
        ),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
        ),
      ),
      leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40.r,
              getTitlesWidget: (value, meta) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: CustomText(
                    text: meta.formattedValue, // to show  100K , 100M
                    color: const Color(0xff666666),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                );
              })),
      bottomTitles: AxisTitles(
          sideTitles: SideTitles(
        reservedSize: 40.r,
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toDouble()) {
            case 0.0:
              text = 'السبت';
              break;
            case 1.0:
              text = 'الأحد';
              break;

            case 2.0:
              text = 'الأثنين';
              break;

            case 3.0:
              text = 'الثلاثاء';
              break;

            case 4.0:
              text = 'الأربعاء';
              break;

            case 5.0:
              text = 'الخميس';
              break;

            case 6.0:
              text = 'الجمعة';
              break;
          }
          return SideTitleWidget(
            axisSide: meta.axisSide,
            space: 4,
            child: CustomText(
              text: text,
              color: const Color(0xff666666),
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          );
        },
      )),
    );
  }
}
