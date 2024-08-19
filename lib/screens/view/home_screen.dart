import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/screens/widgets/Global_Cities_Weather.dart';
import 'package:weather_app/screens/widgets/custom_app_bar.dart';

import '../../controller/HomeController.dart';
import '../widgets/MyCard.dart';
import '../widgets/myList.dart';
import '../widgets/my_chart.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF191A48),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    WeatherCard(controller: controller),
                    Text(
                      'OTHER CITIES',
                      style: TextStyle(color: Colors.white),
                    ),
                    OtherCitySection(),
                    MyChart(),
                    GlobalCitySection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
