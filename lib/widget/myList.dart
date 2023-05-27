import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../constant/images.dart';
import '../controller/HomeController.dart';
import '../model/currentWeather.dart';



class MyList extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ConditionalBuilder(
        condition:controller.currentWeatherList.isNotEmpty ,
        fallback: (context)=>   Center(
            child: CircularProgressIndicator(
              color: Colors.orangeAccent,
            )),
        builder: (context)=>GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,mainAxisSpacing: 10
          ),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          // separatorBuilder: (context, index) =>
          //     const VerticalDivider(
          //       color: Colors.transparent,
          //       width: 5,
          //     ),
          itemCount: controller.currentWeatherList.length,
          itemBuilder: (context, index) {
            CurrentWeather? data;
            (controller.currentWeatherList.isNotEmpty)
                ? data = controller.currentWeatherList[index]
                : data = null;
            return SizedBox(
              width: 80,
              height: 80,
              child: Card(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              (data != null)
                                  ? '${data.name}'
                                  : '',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'flutterfonts',
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                  (data != null)
                                      ? '${(data.mainWeather!.temp !- 273.15).round().toString()}\u00B0'
                                      : '',
                                  style: const TextStyle(
                                      color: Colors.white,fontSize: 12
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            fit: FlexFit.loose,
                            child: Text(
                              (data != null)
                                  ? '${data.weather![0].description}'
                                  : 'yyy',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                  color: Colors.white,
                                  fontFamily: 'flutterfonts',
                                  fontSize: 12
                              ),maxLines: 2,
                            ),
                          ),
                          const SizedBox(width: 5,),
                          SizedBox(
                            width: 30,
                            height: 30,
                            child:controller.currentWeatherList[index].weather![0].description=='clear sky' ?
                            LottieBuilder.asset(Images.clearSky):
                            LottieBuilder.asset(Images.cloudy,),),
                        ],
                      ),
                      Flexible(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: IconButton(
                            icon: const Icon(Icons.cancel,color: Colors.white,size: 20),
                            onPressed: (){
                              controller.deleteCity( deletedCity: data!.name!);
                              controller.update();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
