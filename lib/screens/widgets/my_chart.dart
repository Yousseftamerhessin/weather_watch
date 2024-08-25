import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../model/five_days_data.dart';

class MyChart extends StatelessWidget {
  final List<FiveDayData> data;

  const MyChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Center(child: Text('No forecast data available'));
    }

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
              dataSource: data,
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
}
