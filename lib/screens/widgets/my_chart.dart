import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../cubit/fetchWeatherData.dart';
import '../../cubit/home_cubit.dart'; // تأكد من مسار الاستيراد الصحيح
import '../../model/five_days_data.dart';

class MyChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        // Display a loading indicator while the data is loading
        if (state is HomeLoading) {
          return Center(child: CircularProgressIndicator());
        }

        // Display an error message if there was an error
        if (state is HomeError) {
          return Center(child: Text('Error: ${state.message}'));
        }

        // Display the chart if the data is loaded
        if (state is HomeLoaded) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 240,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  labelRotation: 45,
                ),
                primaryYAxis: NumericAxis(
                  labelFormat: '{value}°C',
                ),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CartesianSeries>[
                  SplineSeries<FiveDayData, String>(
                    dataSource: state.fiveDaysData,
                    xValueMapper: (FiveDayData f, _) => f.dateTime,
                    yValueMapper: (FiveDayData f, _) => f.temp,
                    name: 'Temperature',
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          );
        }

        // Return an empty container as a fallback
        return Container();
      },
    );
  }
}
