import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/constants/images.dart';
import 'package:weather_app/controller/HomeController.dart';

class WeatherCard extends StatelessWidget {
  final HomeController controller;

  const WeatherCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                Row(
                  children: <Widget>[
                    Icon(Icons.location_city, color: Colors.black45),
                    SizedBox(width: 10),
                    Expanded(
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
                  ],
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
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
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
    );
  }
}
