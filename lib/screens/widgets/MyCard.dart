import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/constants/images.dart';
import 'package:weather_app/controller/HomeController.dart';

class MyCard extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        children: <Widget>[
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
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
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
                      padding: EdgeInsets.only(top: 15, left: 20, right: 20),
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
                          padding: EdgeInsets.only(left: 20),
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
                          padding: EdgeInsets.only(right: 20),
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
          ),
        ],
      ),
    );
  }
}
