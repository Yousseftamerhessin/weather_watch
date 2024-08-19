import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/constants/images.dart';
import 'package:weather_app/controller/HomeController.dart';
import '../widgets/myList.dart';
import '../widgets/my_chart.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3, // Adjust the height as needed
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
                      image: AssetImage('assets/images/cloud-in-blue-sky.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: Stack(
                    children: <Widget>[
                      AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        leading: IconButton(
                          icon: Icon(Icons.menu, color: Colors.white),
                          onPressed: () {},
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 100, left: 20, right: 20),
                        child: TextField(
                          onChanged: (value) => controller.city = value,
                          style: TextStyle(color: Colors.white),
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) => controller.updateWeather(),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.search, color: Colors.white),
                            hintStyle: TextStyle(color: Colors.white),
                            hintText: 'Search'.toUpperCase(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  '${controller.currentWeatherData.name?.toUpperCase() ?? 'No data'}',
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.black45,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'flutterfonts',
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  DateFormat().add_MMMMEEEEd().format(DateTime.now()),
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.black45,
                                    fontSize: 16,
                                    fontFamily: 'flutterfonts',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${controller.currentWeatherData.weather?.first.description ?? 'No description'}',
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.black45,
                                      fontSize: 22,
                                      fontFamily: 'flutterfonts',
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '${(controller.currentWeatherData.main?.temp ?? 0 - 273.15).round().toString()}\u2103',
                                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                      color: Colors.black45,
                                      fontFamily: 'flutterfonts',
                                    ),
                                  ),
                                  Text(
                                    'min: ${(controller.currentWeatherData.main?.tempMin ?? 0 - 273.15).round().toString()}\u2103 / max: ${(controller.currentWeatherData.main?.tempMax ?? 0 - 273.15).round().toString()}\u2103',
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.black45,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'flutterfonts',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 120,
                                    height: 120,
                                    child: LottieBuilder.asset(Images.cloudyAnim),
                                  ),
                                  Text(
                                    'wind ${controller.currentWeatherData.wind?.speed ?? 0} m/s',
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.black45,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'flutterfonts',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'other city'.toUpperCase(),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 16,
                          fontFamily: 'flutterfonts',
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      MyList(),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'forecast next 5 days'.toUpperCase(),
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                            ),
                          ),
                          Icon(
                            Icons.next_plan_outlined,
                            color: Colors.black45,
                          ),
                        ],
                      ),
                      MyChart(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
