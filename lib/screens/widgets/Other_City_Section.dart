import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../constants/images.dart';
import '../../model/current_weather_data.dart';

class OtherCitySection extends StatelessWidget {
  final List<CurrentWeatherData> dataList;

  const OtherCitySection({Key? key, required this.dataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (dataList.isEmpty) {
      return Center(child: Text('No local cities data available'));
    }
    return Container(
      height: 150,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => VerticalDivider(
          color: Colors.transparent,
          width: 5,
        ),
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          final data = dataList[index];

          return Container(
            width: 140,
            height: 150,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${data.name}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'flutterfonts',
                        ),
                  ),
                  Text(
                    '${(data.main!.temp! - 273.15).round().toString()}\u2103',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'flutterfonts',
                        ),
                  ),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: LottieBuilder.asset(Images.cloudyAnim),
                  ),
                  Text(
                    '${data.weather![0].description}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontFamily: 'flutterfonts',
                          fontSize: 14,
                        ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
