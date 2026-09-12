import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/utils/general_utils.dart';
import 'package:quizzy_app/view/custom_component/charts/title_data_line_chart.dart';

import '../../../view_model/utils/theme/theme_view_model.dart';

class CustomLineChart extends StatelessWidget {
  final double? maxY;
  final List<double> listData;
  const CustomLineChart({
    this.maxY = 100,
    required this.listData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RPadding(
      padding: REdgeInsets.only(top: 20, right: 20),
      child: LineChart(
        LineChartData(
            minX: 0,
            minY: 0,
            maxY: maxY == 0
                ? 100
                : maxY, // if the max equal 0 make the Defualt Value 10
            titlesData: CustomTitleDataLineChart.getTitles(),
            lineBarsData: [
              LineChartBarData(
                  //     color: const Color.fromRGBO(164, 236, 244, 0.49),
                  color: Get.find<ThemeViewMode>().isDarkMode()
                      ? GeneralUtils.instance.convertColorToDark(
                          Color.fromRGBO(164, 236, 244, 0.49))
                      : Color.fromRGBO(164, 236, 244, 0.49),
                  barWidth: 1,
                  dotData: const FlDotData(
                      show:
                          false), // to disable the digit of the point show in the Figure
                  isCurved: true, //to make the graph
                  belowBarData: BarAreaData(
                    show: true,
                    color: Get.find<ThemeViewMode>().isDarkMode()
                        ? GeneralUtils.instance.convertColorToDark(
                            const Color.fromRGBO(164, 236, 244, 0.49))
                        : Color.fromRGBO(164, 236, 244, 0.49),
                  ),
                  spots: List.generate(listData.length,
                      (index) => FlSpot(index.toDouble(), listData[index])))
            ],
            borderData: FlBorderData(
                show: true,
                border: Border.all(width: 1, color: const Color(0xffF0F0F0))),
            gridData: FlGridData(
                show: true,
                getDrawingHorizontalLine: (value) {
                  return const FlLine(
                    color: Color(0xffF0F0F0),
                    strokeWidth: 1,
                  );
                },
                getDrawingVerticalLine: (value) {
                  return const FlLine(
                    color: Color(0xffF0F0F0),
                    strokeWidth: 1,
                  );
                },
                drawHorizontalLine: true,
                drawVerticalLine: true)),
      ),
    );
  }
}
