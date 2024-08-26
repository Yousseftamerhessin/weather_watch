import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/weather_cubit.dart';
import 'package:weather_app/screens/widgets/custom_app_bar.dart';
import 'package:weather_app/screens/widgets/Other_City_Section.dart';
import 'package:weather_app/screens/widgets/MyCard.dart';
import 'package:weather_app/screens/Home_Drawer.dart/screens/drawer_home.dart';
import 'package:weather_app/screens/widgets/my_chart.dart';
import 'package:weather_app/screens/widgets/Global_Cities_Weather.dart';

import '../../cubit/weather_State.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      context.read<WeatherCubit>().loadWeatherData('cairo');
    });
    return Scaffold(
      drawer: HomeDrawer(),
      body: Column(
        children: [
          CustomAppBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<WeatherCubit, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is WeatherLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WeatherCard(data: state.currentWeatherData),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Other Cities'.toUpperCase(),
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 16,
                                      fontFamily: 'flutterfonts',
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                        OtherCitySection(dataList: state.localWeatherData),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Forecast Next 5 Days'.toUpperCase(),
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 16,
                                      fontFamily: 'flutterfonts',
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                        MyChart(data: state.fiveDaysData),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Global Cities'.toUpperCase(),
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 16,
                                      fontFamily: 'flutterfonts',
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                        GlobalCitySection(dataList: state.globalWeatherData),
                      ],
                    );
                  } else if (state is WeatherError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return Center(child: Text('No data available'));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
