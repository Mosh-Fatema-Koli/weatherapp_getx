import 'dart:convert';

import 'package:get/get.dart';
import 'package:weather/controller/HomeController.dart';
import 'package:weather/model/currentWeather.dart';
import 'package:weather/service/Weather_Service.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    // TODO: implement dependencies
  }

}