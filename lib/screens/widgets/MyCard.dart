import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../constants/images.dart';
import '../../model/current_weather_data.dart';

class WeatherCard extends StatelessWidget {
  final CurrentWeatherData data;

  const WeatherCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                ),
                Text(
                  '${data.name?.toUpperCase() ?? 'No data'}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'flutterfonts',
                      ),
                ),
              ],
            ),
            Text(
              DateFormat('EEEE, MMMM d').format(DateTime.now()),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 16,
                    fontFamily: 'flutterfonts',
                  ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.weather?.isNotEmpty == true ? data.weather![0].description : 'No description'}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 22,
                            fontFamily: 'flutterfonts',
                          ),
                    ),
                    Text(
                      '${(data.main!.temp! - 273.15).round().toString()}\u2103',
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontFamily: 'flutterfonts',
                              ),
                    ),
                    Text(
                      'min: ${(data.main!.temp! - 273.15).round().toString()}°C / max: ${(data.main!.temp! - 273.15).round().toString()}°C',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                      'wind ${data.wind?.speed ?? 0} m/s',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
    );
  }
}
