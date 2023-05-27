import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FiveDaysData{
  final String ? dateTime;
  final String ? newDateTime;
  final String ? hourlyDateTime;
  final int ? temp;
  final int ?humidity;
  final int ?temp_min;
  final int ?temp_max;
  final List<String> ?dateList;

  FiveDaysData({ this.dateTime,  this.temp
    ,this.humidity,
    this.newDateTime,
    this.hourlyDateTime,
    this.temp_min,
    this.temp_max,
    this.dateList
  });

  factory FiveDaysData.fromJson( dynamic json) {
    if(json==null){
      return FiveDaysData();
    }
    var d = json['dt_txt'].split(' ')[0].split('-')[2];
    var m = json['dt_txt'].split(' ')[0].split('-')[1];
    var e = json['dt_txt'].split(' ')[0].split(' ')[0];
    var h = json['dt_txt'];

    //2022-08-29 15:00:00
    // debugPrint(e+'this is E');
    debugPrint(d+' this is d');
    debugPrint(m+' this is m');
    debugPrint(h+' this is h');
    var fandl = '$d-$m';
     // debugPrint('$fandl this is fandl');
    return FiveDaysData(
      dateTime: '$fandl',
      newDateTime: '$e',
      temp: (json['main']['temp']-273.15).round(),
      temp_min: (json['main']['temp_min']).round(),
      temp_max: (json['main']['temp_max']).round(),
      humidity: (json['main']['humidity']),

    );
  }





}