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
      color: Color(0xFF86879E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Center(
          child: Column(
            children: [
              Center(
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.white),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '${controller.currentWeatherData.name?.toUpperCase() ?? 'No data'}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'flutterfonts',
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                DateFormat().add_MMMMEEEEd().format(DateTime.now()),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'flutterfonts',
                    ),
              ),
              Divider(color: Colors.white.withOpacity(0.5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        '${controller.currentWeatherData.weather?.first.description ?? 'No description'}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                              fontSize: 22,
                              fontFamily: 'flutterfonts',
                            ),
                      ),
                      Text(
                        '${(controller.currentWeatherData.main?.temp ?? 0 - 273.15).round().toString()}\u2103',
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: Colors.white,
                                  fontFamily: 'flutterfonts',
                                ),
                      ),
                      Text(
                        'min: ${(controller.currentWeatherData.main?.tempMin ?? 0 - 273.15).round().toString()}\u2103 / max: ${(controller.currentWeatherData.main?.tempMax ?? 0 - 273.15).round().toString()}\u2103',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'flutterfonts',
                            ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: Lottie.asset(Images.cloudyAnim),
                      ),
                      Text(
                        'wind ${controller.currentWeatherData.wind?.speed ?? 0} m/s',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
            ],
          ),
        ),
      ),
    );
  }
}
