
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather/model/currentWeather.dart';
import 'package:weather/pages/home/home_screen.dart';
import 'package:weather/service/Weather_Service.dart';

import '../model/FiveDaysData.dart';

class HomeController extends GetxController{
   String ? city;
   String? searchText;

 HomeController({this.city});
  CurrentWeather currentWeather=CurrentWeather();
 List<FiveDaysData> fiveDaysData=[];
  List<CurrentWeather> currentWeatherList=[];
   List<String> cities=['Tokyo','Cairo','London','Paris','Soul'];
   List<String> newFiveDaysData=[];
   bool switchCase=false;

   @override
  void onInit()async{
   await getCurrentLocation();
   // getCurrentWeather();
  getWeatherDataByLonAndLat();
  getFiveDaysData();
   getTopFiveCites();
   const Duration checkingTime = Duration(seconds:5);
  var _timer = Timer.periodic(checkingTime, (Timer t) => checkIfGpsIsOpened());//Using Geo

   initState();
    super.onInit();
  }

  void onUpdate(){
    initState();
  }

  void initState() {
    getWeatherDataByLonAndLat();

    // getCurrentWeather();
    // getFiveDaysData();
  }



 void getFiveDaysData() {
     fiveDaysData.clear();
   WeatherService(city:city).getFiveDaysForecastService(
       lon: position!.longitude, lat: position!.latitude,
       onSuccess:(value){
         fiveDaysData=value;
         newFiveDaysData.clear();
             fiveDaysData.forEach((element) {
                if(!newFiveDaysData.contains(element.newDateTime)){
                  newFiveDaysData.add(element.newDateTime!);
                }else{

                }

             });

         debugPrint('${newFiveDaysData.length.toString()}  newFiveDaysData');
     update();
   } ,onError:(error){

     debugPrint('${error}getFiveDaysDataError');

     update();
   } );

 }

 void getFiveDaysDataInSearch() {
   fiveDaysData.clear();
   WeatherService(city:searchText).getFiveDaysForecastSearchService(
       onSuccess:(value){
     fiveDaysData=value;
     getFiveDaysData();
     update();
   } ,onError:(error){
     // debugPrint(error.toString());
     debugPrint('${error}getFiveDaysDataError');

     update();
   } );

 }

  void getTopFiveCites() {
    currentWeatherList.clear();
    cities.forEach((element) {
      WeatherService(city:element).getTopFiveWeatherService(
          onSuccess:(value){
            currentWeatherList.add(value);
          } ,onError:(error){
        // debugPrint(error.toString());
        debugPrint('${error}getTopFiveCitesError');
        update();
      } );
    });
    print('${cities.length}cites lenght');
    print('${currentWeatherList.length}currentWeatherList');
    update();

  }

   bool ?serviceEnabled;
   bool ?isGpsOpened;
   Future<Position> _determinePosition() async {
     LocationPermission permission;
     // Test if location services are enabled.
     serviceEnabled = await Geolocator.isLocationServiceEnabled();
     // isGpsOpened=serviceEnabled;
     print(serviceEnabled.toString());
     if (!serviceEnabled!) {

     }
     permission = await Geolocator.checkPermission();
     if (permission == LocationPermission.denied) {
       permission = await Geolocator.requestPermission();
       if (permission == LocationPermission.denied) {
         return Future.error('Location permissions are denied');
       }
       if (permission == LocationPermission.whileInUse) {
         serviceEnabled=true;
         return Future.error('Location permissions are denied');
       }
     }

     if (permission == LocationPermission.deniedForever) {
       return Future.error(
           'Location permissions are permanently denied, we cannot request permissions.');
     }
     return await Geolocator.getCurrentPosition();
   }

   void openGpsSettings({context}){
     Geolocator.openLocationSettings().then((value) {
       Get.lazyPut(() => HomeController());
       getWeatherDataByLonAndLat();
       getFiveDaysData();
     });


   }


   // void getCurrentWeather() {
   //   debugPrint('getCurrentWeatherDate1');
   //   WeatherService(city:WeatherService().city).get16DatWeatherData(
   //       onSuccess:(value){
   //         debugPrint('getCurrentWeatherDate 2'.toString());
   //         currentWeather=value;
   //         print(currentWeather.name);
   //       } ,onError:(error){
   //     print(error);
   //
   //     // debugPrint(error.toString());
   //     debugPrint('${error.toString()}getCurrentWeather  Error');
   //     update();
   //   } );
   //
   // }



   void getCurrentWeatherInSearch() {
     debugPrint('getCurrentWeatherInSearch');
     WeatherService(city:searchText).getSearchCityWeatherService(
         onSuccess:(value){
           newFiveDaysData.clear();
           debugPrint('getCurrentWeatherDate 2'.toString());
           currentWeather=value;
           print('${currentWeather.name!}this is search City');
           getFiveDaysDataInSearch();
           update();
         } ,onError:(error){
       debugPrint('${error.toString()}getCurrentWeather  Error');
       update();
     } );

   }

Position? position;

 Future<void>  getCurrentLocation()async{
  await  _determinePosition();
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
   print(position.toString());

     WeatherService().getCityNameService(lon: position!.longitude, lat: position!.latitude);

  }


void getWeatherDataByLonAndLat()async{
 await WeatherService().getWeatherFromLonAndLat(lon: position!.longitude, lat: position!.latitude,
      onSuccess: (value){
     currentWeather=value;
    // print('${currentWeather.id}this is id');
    update();

      },onError: (error){
   print(error.toString());
     });

}



Future<bool?> checkIfGpsIsOpened() async {
   isGpsOpened=await Geolocator.isLocationServiceEnabled();
   update();
    // debugPrint('$isGpsOpened   checkIfGpsIsOpened()');
   return isGpsOpened;
}

void deleteCity({required String deletedCity}){
   cities.remove(deletedCity);
   getTopFiveCites();
   print(cities.length);
   update();
}

 void addCity({required String newCity}){
   cities.add(newCity);
   getTopFiveCites();
   print(cities.length);
   update();
 }


   Future<void> showMyDialog(context) async {
     return showDialog<void>(
       context: context,
       barrierDismissible: false, // user must tap button!
       builder: (BuildContext context) {
         return AlertDialog(
           title: const Text('Add City To Top Cites'),
           content: SingleChildScrollView(
             child: ListBody(
               children:  <Widget>[
                 Text('Do you Want Add $searchText To Top Cites?'),
               ],
             ),
           ),
           actions: <Widget>[
             TextButton(
               child: const Text('Yes'),
               onPressed: () {
                addCity(newCity: searchText!);
                Navigator.of(context).pop();

               },
             ),
             TextButton(
               child: const Text('No'),
               onPressed: () {
                 Navigator.of(context).pop();
               },
             ),
           ],
         );
       },
     );
   }
}