import 'package:flutter/material.dart';
import 'package:weather/api/apiRepo.dart';
import 'package:weather/model/FiveDaysData.dart';
import 'package:weather/model/currentWeather.dart';

// class WeatherService{
//   final String ?city;
//   String baseUrl="https://api.openweathermap.org/data/2.5";
//   String apiKey="appid=4958f12ead4a3e53fa2ee5e4f5dcdc8e";
//   WeatherService({this.city});
//     //https://api.openweathermap.org/data/2.5/weather?q=cairo&mode=json&appid=4958f12ead4a3e53fa2ee5e4f5dcdc8e
//   void getCurrentWeather({
//     Function()? beforeSending,
//     Function(CurrentWeather currentWeather)? onSuccess,
//     Function(dynamic error)? onError,
// }){
//     final url="$baseUrl/weather?q=$city&lang=en&$apiKey";
//     debugPrint(url);
//     ApiRepo(url: '$url').getData(
//       beforeSending: ()=> {if (beforeSending!=null){
//         debugPrint('beforeSending'.toString()),
//        beforeSending(),
//       }
//       },
//       onSuccess: (value)=> {
//         onSuccess!(CurrentWeather.fromJson(value)),
//         debugPrint('onSuccess'.toString()),
//
//       },
//       onError: (error)=> {if (onError!(error)!=null){
//         debugPrint('onError'.toString()),
//         debugPrint('${error}getCurrentWeather'),
//
//         onError(error),
//       }
//       });
//
//   }
//
//
//
//   // void getFiveDaysThreeHoursForecastData({
//   //   Function()? beforeSending,
//   //   Function(List<FiveDaysData>fiveDaysData)? onSuccess,
//   //   Function(dynamic error)? onError,
//   // }){
//   //   //https://api.openweathermap.org/data/2.5/forecast?q=cairo&appid=4958f12ead4a3e53fa2ee5e4f5dcdc8e
//   //   final url="$baseUrl/forecast?q=$city&lang=en&$apiKey";
//   //   debugPrint(url);
//   //   ApiRepo(url: '$url').getData(
//   //       beforeSending: ()=> {},
//   //       onSuccess: (value)=>{
//   //         onSuccess!((value['list']as List)
//   //             .map((e)=>FiveDaysData.fromJson(e))
//   //             .toList()),
//   //       },
//   //       onError: (error)=> {
//   //         // debugPrint(error.toString()),
//   //         debugPrint('${error}getFiveDaysThreeHoursForecastData'),
//   //         onError!(error)});
//   //
//   //
//   // }
//
//
//
// }
class WeatherService {
  late  String? city;
  late  String? searchCity;
//  http://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=1c2ce427b7370a4cc082fc898db0bdb0
  String baseUrl = 'https://api.openweathermap.org/data/2.5';
  String apiKey = 'appid=1c2ce427b7370a4cc082fc898db0bdb0';

  WeatherService({ this.city});

  void getTopFiveWeatherService({
    Function()? beforSend,
    Function(CurrentWeather currentWeatherData)? onSuccess,
    Function(dynamic error)? onError,
  }) {

   final url = '$baseUrl/weather?q=$city&lang=en&$apiKey';

   // final url = 'http://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=1c2ce427b7370a4cc082fc898db0bdb0';
    print(url);
    ApiRepo(
      url: url,
    ).getData(
        beforeSending: () => {
          if (beforSend != null)
            {
              beforSend(),
            },
        },
        onSuccess: (data) => {
          onSuccess!(CurrentWeather.fromJson(data)),
        },
        onError: (error) => {
          if (onError != null)
            {
              print(error),
              debugPrint('${error.toString()}getCurrentWeatherService service'),
              onError(error),
            }
        });
  }


  void getSearchCityWeatherService({
    Function()? beforSend,
    Function(CurrentWeather currentWeatherData)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    final url = '$baseUrl/weather?q=$city&lang=en&$apiKey';
    print(url);
    ApiRepo(
      url: url,
    ).getData(
        beforeSending: () => {
          if (beforSend != null)
            {
              beforSend(),
            },
        },
        onSuccess: (data) => {
          onSuccess!(CurrentWeather.fromJson(data)),
        },
        onError: (error) => {
          if (onError != null)
            {
              print(error),
              debugPrint('${error.toString()}getCurrentWeatherBySearchService service'),
              onError(error),
            }
        });
  }


  void getFiveDaysForecastService({
    required double lon,
    required double lat,
    Function()? beforSending,
    Function(List<FiveDaysData> fiveDayData)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    // final url = '$baseUrl/forecast?q=$city&lang=en&$apiKey';
    final url = '$baseUrl/forecast?lat=$lat&lon=$lon&$apiKey';
    print(url);
    ApiRepo(
      url: '$url',
    ).getData(
        beforeSending: () => {},
        onSuccess: (data) => {
          onSuccess!((data['list'] as List)
              .map((t) => FiveDaysData.fromJson(t))
              .toList())
        },
        onError: (error) => {
        debugPrint('${error.toString()}getFiveDaysThreeHoursForcastData service'),
          onError!(error),
        });
  }


  void getFiveDaysForecastSearchService({
    Function()? beforSending,
    Function(List<FiveDaysData> fiveDayData)? onSuccess,
    Function(dynamic error)? onError,
  }) {
     final url = '$baseUrl/forecast?q=$city&lang=en&$apiKey';
    print(url);
    ApiRepo(
      url: '$url',
    ).getData(
        beforeSending: () => {},
        onSuccess: (data) => {
          onSuccess!((data['list'] as List)
              .map((t) => FiveDaysData.fromJson(t))
              .toList())
        },
        onError: (error) => {
          debugPrint('${error.toString()}getFiveDaysThreeHoursForcastData service'),
          onError!(error),
        });
  }


  Future<void> getWeatherFromLonAndLat({
  required double lon,
  required double lat,
    Function(CurrentWeather currentWeatherData)? onSuccess,
    Function(dynamic error)? onError,
})async{
    final url = '$baseUrl/weather?lat=$lat&lon=$lon&$apiKey';
    print(url);
  await  ApiRepo(
      url: '$url',
    ).getData(
        beforeSending: () => {},
        onSuccess: (data) => {
          // print(data.toString()),
          onSuccess!(CurrentWeather.fromJson(data)),
          // onSuccess!(CurrentWeather.fromJson(data)),
          print('Success getWeatherFromLonAndLat service')
        },
        onError: (error) => {
          if (onError != null)
            {
              print(error),
              debugPrint('${error.toString()}etWeatherFromLonAndLat service'),
              onError(error),
            }
        });
  }


 Future<void>  getCityNameService({
    required double lon,
    required double lat,
    Function()? onSuccess,
    Function(dynamic error)? onError,
  })async{
    final url = '$baseUrl/weather?lat=$lat&lon=$lon&$apiKey';
    print(url);
    await  ApiRepo(
      url: url,
    ).getData(
        beforeSending: () => {},
        onSuccess: (data) => {
          // print('${data}data in Service'),
          city=data['name'],
          CurrentWeather(name:data['name'] ),

          print('getCityName $city')
        },
        onError: (error) => {
          if (onError != null)
            {
              print(error),
              debugPrint('${error.toString()}getCityName service'),
              onError(error),
            }
        });

  }

  // Future<void> get16DatWeatherData({
  //   required double lon,
  //   required double lat,
  //    int numberOfDyas=16,
  //   Function()? onSuccess,
  //   Function(dynamic error)? onError,
  // }) async {
  //   final url = '$baseUrl/forecast/daily?lat=$lat&lon=$lon&cnt=$numberOfDyas&$apiKey';
  //   print(url);
  //   await  ApiRepo(
  //       url: '$url',
  //   ).getData(
  //       beforeSending: () => {},
  //       onSuccess: (data) => {
  //         // print(data.toString()),
  //         onSuccess!(CurrentWeather.fromJson(data)),
  //         // onSuccess!(CurrentWeather.fromJson(data)),
  //         print('Success getWeatherFromLonAndLat service')
  //       },
  //       onError: (error) => {
  //         if (onError != null)
  //           {
  //             print(error),
  //             debugPrint('${error.toString()}etWeatherFromLonAndLat service'),
  //             onError(error),
  //           }
  //       });
  //
  // }

  }
