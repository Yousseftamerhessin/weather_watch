import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/weather_cubit.dart';
import '../../cubit/weather_state.dart';
import '../Home_Drawer.dart/screens/drawer_home.dart';
import '../widgets/MyCard.dart';
import '../widgets/Other_City_Section.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      drawer: HomeDrawer(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              context.read<WeatherCubit>().loadWeatherDataFromLocation();
            },
            child: const Text('Get Weather by Location'),
          ),
          Expanded(
            child: BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is WeatherLoaded) {
                  return ListView(
                    children: [
                      WeatherCard(data: state.currentWeatherData),
                      SectionHeader(title: 'Nearest Cities'),
                      OtherCitySection(dataList: state.localWeatherData),
                    ],
                  );
                } else if (state is WeatherError) {
                  return Center(
                    child: Text(
                      'Error: ${state.message}',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }
                return Center(child: Text('No data available.'));
              },
            ),
          ),
        ],
      ),
    );
  }
}



class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 16,
              fontFamily: 'flutterfonts',
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
