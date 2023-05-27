import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/pages/home/home_screen.dart';
import 'package:weather/utils/Binding/HomeBiniding.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.cyan,
      initialRoute: '/',
      getPages: [
      GetPage(
          name: '/',
          page: ()=>HomeScreen(),
        binding:HomeBinding()

      )
      ],
    );
  }
}


