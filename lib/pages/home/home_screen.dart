import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../constant/Style.dart';
import '../../constant/images.dart';
import '../../controller/HomeController.dart';
import '../../widget/myList.dart';
import '../../widget/my_chart.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return GetBuilder<HomeController>(
      builder: (controller) {
        return ConditionalBuilder(
          fallback: (context) =>
          const Center(
              child: CircularProgressIndicator(
                color: Colors.orangeAccent,
              )),
          condition: controller.currentWeather.name != null,
          builder: (context) =>
              Scaffold(
                drawer: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(40),
                    bottomRight: Radius.circular(20),
                  ),
                  child: SafeArea(
                    top: true,
                    // height: mediaQuery.height-50,
                    child: Drawer(
                      backgroundColor: controller.switchCase==true?Colors.brown:Colors.cyan,
                      width: mediaQuery.width / 1.5,
                      elevation: 0.1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 10),
                        child: Column(
                          children: [
                             Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      controller.switchCase==true?'Dark':'Light',
                                      style:
                                      Theme
                                          .of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'flutterfonts',
                                      ),
                                    ),
                                    Switch(
                                      inactiveTrackColor: Colors.black,
                                      activeTrackColor: Colors.white,
                                      activeColor: Colors.black,
                                      onChanged: (bool value) {
                                      controller.switchCase=value;
                                      if(value==true){
                                        mainColor=Colors.black;
                                      }else{
                                        mainColor=Colors.blue;

                                      }
                                      controller.update();
                                      print(controller.switchCase);
                                      },
                                      value: controller.switchCase,
                                    ),
                                  ],
                                )
                              ),
                            ),
                            SizedBox(
                              height: mediaQuery.height / 30,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height /10,
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10, bottom: 20),
                              child: TextField(
                                onTap: () {},
                                onChanged: (value) => controller.searchText = value,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                textInputAction: TextInputAction.search,
                                onSubmitted: (value) async {
                                await controller.showMyDialog(context);
                                  controller.getCurrentWeatherInSearch();
                                },
                                decoration: InputDecoration(
                                  suffix: IconButton(
                                    onPressed: () {
                                      controller.getCurrentWeatherInSearch();
                                    },
                                    icon: const Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                  ),
                                  hintStyle: const TextStyle(
                                      color: Colors.white),
                                  hintText: 'Search',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                    const BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                    const BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                    const BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Favourite Location ',
                                  style:
                                  Theme
                                      .of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'flutterfonts',
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                const Icon(
                                  Icons.report_gmailerrorred_sharp,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20, top: 25),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    '${controller.currentWeather.name}',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'flutterfonts',
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.circle,
                                    color: Colors.yellowAccent,
                                    size: 14,
                                  ),
                                  Text(
                                    '${(controller.currentWeather.mainWeather!
                                        .temp! - 273.15)
                                        .truncate()
                                        .toString()}\u00B0',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                        color: Colors.white,
                                        // fontSize: 60,
                                        fontFamily: 'flutterfonts'),
                                  ),
                                ],
                              ),
                            ),
                            //............
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                ' ............................................................. ',
                                maxLines: 1,
                                style:
                                Theme
                                    .of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'flutterfonts',
                                ),
                              ),
                            ),
                            SizedBox(
                              height: mediaQuery.height / 100,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Top Cities :',
                                  style:
                                  Theme
                                      .of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'flutterfonts',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: double.infinity / 2,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 2.5,
                              child: Card(
                                  color: Colors.blueAccent.withOpacity(0.1),
                                  elevation: 0.2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: MyList()),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                body: Builder(
                  builder: (context) => myHomeScreen(context),
                ),
              ),
        );
      },
    );
  }

  Widget myHomeScreen(context) {
    var mediaQuery = MediaQuery
        .of(context)
        .size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            decoration:  BoxDecoration(
              color: controller.switchCase==true?Colors.black:Colors.cyan,

            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: <Widget>[
                  AppBar(
                    centerTitle: true,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarIconBrightness: controller.switchCase==true?Brightness.light:Brightness.light,
                      statusBarColor:  controller.switchCase==true?Colors.black:Colors.blueAccent
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${controller.currentWeather.name}'.toUpperCase(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .caption!
                              .copyWith(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'flutterfonts',
                          ),
                        ),
                        const Icon(Icons.location_on_sharp)
                      ],
                    ),
                    leading: IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                  if (controller.isGpsOpened == false)
                    InkWell(
                      child: Container(
                        width: mediaQuery.width / 2,
                        height: mediaQuery.height / 28,
                        decoration: BoxDecoration(
                            color: Colors.transparent.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            'Turn on Location Services',
                            style:
                            Theme
                                .of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'flutterfonts',
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        controller.openGpsSettings();
                      },
                    ),
                  Text(
                    DateFormat().add_MMMMEEEEd().format(DateTime.now()),
                    style: Theme
                        .of(context)
                        .textTheme
                        .caption!
                        .copyWith(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'flutterfonts',
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${(controller.currentWeather.mainWeather!.temp! -
                            273.15).truncate().toString()}\u00B0',
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline1!
                            .copyWith(
                            color: Colors.white,
                            // fontSize: 60,
                            fontFamily: 'flutterfonts'),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: mediaQuery.width / 4,
                            height: mediaQuery.height / 8,
                            child: controller.currentWeather.weather![0]
                                .description ==
                                'clear sky'
                                ? LottieBuilder.asset(
                                fit: BoxFit.fill, Images.clearSky)
                                : LottieBuilder.asset(
                                fit: BoxFit.fill, Images.cloudy),
                          ),
                          Text(
                            '${controller.currentWeather.weather![0]
                                .description}',
                            style:
                            Theme
                                .of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                              color: Colors.white,
                              fontSize: mediaQuery.width / 25,
                              fontFamily: 'flutterfonts',
                            ),
                          ),
                          Text(
                            ' ${(controller.currentWeather.mainWeather!
                                .temp_max! - 273.15)
                                .floor()}\u00B0 / ${(controller.currentWeather
                                .mainWeather!.temp_min! - 273.15)
                                .round()
                                .toString()}\u00B0',
                            style:
                            Theme
                                .of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'flutterfonts',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              //FiveDays
                  Container(
                    width: double.infinity,
                    height: mediaQuery.height/12,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.center,
                        colors: [
                          Colors.white.withOpacity(0.5),
                          Colors.white.withOpacity(0.1)
                        ],
                      ),
                    ),
                    child: Card(
                      shadowColor: Colors.black.withOpacity(0.1),
                      color: Colors.black.withOpacity(0.2),
                      elevation: 0.2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'forcast For 5 days'.toUpperCase(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .caption!
                              .copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.white.withOpacity(0.5),
                          Colors.white.withOpacity(0.1)
                        ],
                      ),
                    ),
                    child: Card(
                      shadowColor: Colors.black.withOpacity(0.2),
                      color: Colors.black.withOpacity(0.2),
                      elevation: 0.2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ConditionalBuilder(
                        condition: controller.newFiveDaysData.isNotEmpty,
                        fallback: (context)=>const Center(child: CircularProgressIndicator(color: Colors.yellowAccent),),
                        builder: (context)=> ListView.separated(
                            itemBuilder: (context, index) =>
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0,right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 90,
                                        child: Text(
                                          DateFormat().add_EEEE().format(
                                              DateFormat('yyyy-MM-dd')
                                                  .parse(controller
                                                  .newFiveDaysData[
                                              index])) ==
                                              DateFormat()
                                                  .add_EEEE()
                                                  .format(DateTime.now())
                                              ? "Today"
                                              : DateFormat().add_EEEE().format(
                                              DateFormat('yyyy-MM-dd')
                                                  .parse(controller
                                                  .newFiveDaysData[
                                              index])),
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                            color: Colors.white,
                                            fontSize: 16,overflow: TextOverflow.ellipsis,
                                            fontFamily: 'flutterfonts',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                       Icon(Icons.water_drop,
                                          color: controller.switchCase==true?Colors.blue:Colors.black, size: 18),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${(controller.fiveDaysData[index]
                                            .humidity! * 0.05).round()}%',
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      const Icon(
                                        Icons.sunny,
                                        color: Colors.orangeAccent,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                       Icon(
                                        Icons.nightlight_round,
                                        color:  controller.switchCase==true?Colors.white:Colors.black,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        ' ${(controller.fiveDaysData[index]
                                            .temp_max! - 273.15)
                                            .floor()}\u00B0 / ${(controller
                                            .fiveDaysData[index].temp_min! - 273.15)
                                            .round()
                                            .toString()}\u00B0',
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'flutterfonts',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            separatorBuilder: (context, index) =>
                            const SizedBox(
                              height: 10,
                            ),
                            itemCount: 5),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //sunrise
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.2),
                          Colors.white.withOpacity(0.2),
                        ],
                      ),
                      // gradient: Gradient(colors: []),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.white.withOpacity(0.2),
                      //     blurRadius: 0.1,
                      //     spreadRadius: 0.1,
                      //     offset: Offset.zero,
                      //       blurStyle:BlurStyle.solid
                      //
                      //   )
                      // ]
                      //   border: Border(
                      //   top: BorderSide(color: Colors.white,width: 2),
                      //   bottom: BorderSide(color: Colors.white,width: 2),
                      //   left: BorderSide(color: Colors.white,width: 2),
                      //   right: BorderSide(color: Colors.white,width: 1),
                      // )
                    ),
                    width: double.infinity,
                    height: mediaQuery.height/2.5,
                    child: Card(
                        shadowColor: Colors.black.withOpacity(0.2),
                        color: Colors.black.withOpacity(0.2),
                        elevation: 0.7,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(
                                    Icons.air,
                                    color: Colors.orangeAccent,
                                    size: mediaQuery.width / 8,
                                  ),
                                  Icon(
                                    Icons.water_drop,
                                    color: controller.switchCase==true?Colors.blue:Colors.black,
                                    size: mediaQuery.width / 8,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3.0, horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Wind: ${controller.currentWeather.wind!
                                        .speed} Km/h',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Humidity: ${(controller.currentWeather
                                        .mainWeather!.humidity! * 0.05)
                                        .round()}%',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Container(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 20),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(100)),
                                ),
                                child: LottieBuilder.asset(
                                  Images.sunriseAndSunset,
                                  fit: BoxFit.cover,
                                  height: mediaQuery.height / 4.5,
                                  width: mediaQuery.width,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Sunrise ${DateTime
                                        .fromMillisecondsSinceEpoch(
                                        controller.currentWeather.sys!
                                            .sunrise! * 1000).toString().split(
                                        ' ')[1].split('000')[0].split('.')[0]
                                        .replaceRange(5, 8, ' ')}',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'sunset ${DateTime
                                        .fromMillisecondsSinceEpoch(
                                        controller.currentWeather.sys!.sunset! *
                                            1000).toString().split(' ')[1]
                                        .split('000')[0].split('.')[0]
                                        .replaceRange(5, 8, ' ')}',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Chart For 5 Days Temp',
                        style: Theme
                            .of(context)
                            .textTheme
                            .caption!
                            .copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.newFiveDaysData.clear();
                          controller.getFiveDaysData();
                          controller.update();
                          // MyChart();
                        },
                        icon: (const Icon(
                          Icons.next_plan_outlined,
                          color: Colors.white,
                        )),
                      ),
                    ],
                  ),
                  MyChart(),
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: Text(
                  //     'other cities:'.toUpperCase(),
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .caption!
                  //         .copyWith(
                  //       fontSize: 16,
                  //       fontFamily: 'flutterfonts',
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                  // MyList(),
                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   height: MediaQuery.of(context).size.height / 8,
                  //   padding: const EdgeInsets.only(
                  //       top: 10, left: 20, right: 20, bottom: 20),
                  //   child: TextField(
                  //     onChanged: (value) =>
                  //     controller.searchText = value,
                  //     style: const TextStyle(
                  //       color: Colors.white,
                  //     ),
                  //     textInputAction: TextInputAction.search,
                  //     onSubmitted: (value) =>
                  //         controller.getCurrentWeatherInSearch(),
                  //     decoration: InputDecoration(
                  //       suffix: IconButton(
                  //         onPressed: () {
                  //           controller.getCurrentWeatherInSearch();
                  //         },
                  //         icon: const Icon(
                  //           Icons.search,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //       hintStyle:
                  //       const TextStyle(color: Colors.white),
                  //       hintText: 'Search'.toUpperCase(),
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //         borderSide:
                  //         const BorderSide(color: Colors.white),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //         borderSide:
                  //         const BorderSide(color: Colors.white),
                  //       ),
                  //       enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //         borderSide:
                  //         const BorderSide(color: Colors.white),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
