import 'dart:convert';

import 'package:weather/model/clouds.dart';
import 'package:weather/model/coord.dart';
import 'package:weather/model/main_weather.dart';
import 'package:weather/model/sys.dart';
import 'package:weather/model/weather.dart';
import 'package:weather/model/wind.dart';


/*
Coord? coord;
  List<Weather>? weather;
  String? base;
  Main? main;
  int? visibility;
  Wind? wind;
  Clouds? clouds;
  int? dt;
  Sys? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;
 */
class CurrentWeather {
  /*
    "coord": {
   "lon": 31.2497,
    "lat": 30.0626
  },
  "weather": [
    {
      "id": 800,
      "main": "Clear",
      "description": "clear sky",
      "icon": "01n"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 303.57,
    "feels_like": 307.25,
    "temp_min": 303.38,
    "temp_max": 303.57,
    "pressure": 1009,
    "humidity": 62
  },
  "visibility": 10000,
  "wind": {
    "speed": 5.14,
    "deg": 60
  },
  "clouds": {
    "all": 0
  },
  "dt": 1661287030,
  "sys": {
    "type": 1,
    "id": 2514,
    "country": "EG",
    "sunrise": 1661225216,
    "sunset": 1661272133
  },
  "timezone": 7200,
  "id": 360630,
  "name": "Cairo",
  "cod": 200
   */
  final  Coord ? coord;
  final List<Weather>? weather;
  final String? base;
  final MainWeather? mainWeather;
  final int ?visibility;
  final Wind ?wind;
  final Clouds? clouds;
  final int? dt;
  final Sys? sys;
  final int ?timezone;
  final int ?id;
  final String ? name;
  final int ? cod;



  CurrentWeather(
      {
        this.coord,
       this.weather,
       this.clouds,
       this.mainWeather,
       this.sys,
       this.wind,
       this.base,
       this.visibility,
       this.dt,
       this.timezone,
       this.id,
       this.cod,
       this.name
      });


  factory CurrentWeather.fromJson( dynamic json) {
    if(json==null){
      CurrentWeather();
    }
    return CurrentWeather(
      coord: Coord.fromJson(json["coord"]??'null in coord'),
      weather: (json["weather"]as List).map((i) => Weather.fromJson(i) ).toList(),
      clouds: Clouds.fromJson(json["clouds"]??'null in clouds'),
      mainWeather: MainWeather.fromJson(json["main"]??'null in mainWeather'),
      sys: Sys.fromJson(json["sys"]??'null in sys'),
      wind: Wind.fromJson(json["wind"]??'null in wind'),
      base: json["base"]??'null in base',
      visibility:json["visibility"]?? 'null in visibility',
      dt: json["dt"]?? 'null in dt',
      timezone: json["timezone"]?? 'null in timezone',
      id: json["id"]?? 'null in id',
      cod: json["cod"]?? 'null in cod',
      name: json["name"]?? 'null in name',
    );
  }
//

//

}
