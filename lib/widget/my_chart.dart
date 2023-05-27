import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather/constant/Style.dart';

import '../controller/HomeController.dart';
import '../model/FiveDaysData.dart';



class MyChart extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: controller.switchCase==true?Colors.orangeAccent:Colors.transparent
          ,borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/4,
      child: Card(
        color: controller.switchCase==true?Colors.black:Colors.white.withOpacity(0.8),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          // color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: SfCartesianChart(
              backgroundColor: controller.switchCase==true?Colors.black:Colors.blueAccent.withOpacity(0.2),
              // plotAreaBorderColor: Colors.white,
              enableAxisAnimation: true,
              enableSideBySideSeriesPlacement: true,
              primaryXAxis: CategoryAxis(
                // maximum: 1.0,
                // minimum: 5,
                arrangeByIndex: true,
              ),
              series: <ChartSeries<FiveDaysData, String>>[
                LineSeries<FiveDaysData, String>(
                  // markerSettings: MarkerSettings(color: Colors.white,width: 20),
                  width: 2,
                  dataSource: controller.fiveDaysData,
                  yValueMapper: (FiveDaysData f, _) =>
                  f.temp,
                  xValueMapper: (FiveDaysData f, _) =>
                  f.dateTime!,color: controller.switchCase==true?Colors.orangeAccent:Colors.red.withOpacity(0.8),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
