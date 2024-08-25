import 'package:equatable/equatable.dart';
import '/model/current_weather_data.dart';
import '/model/five_days_data.dart';

abstract class WeatherState extends Equatable {
  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final CurrentWeatherData currentWeatherData;
  final List<CurrentWeatherData> localWeatherData;
  final List<CurrentWeatherData> globalWeatherData;
  final List<FiveDayData> fiveDaysData;

  WeatherLoaded({
    required this.currentWeatherData,
    required this.localWeatherData,
    required this.globalWeatherData,
    required this.fiveDaysData,
  });

  @override
  List<Object> get props => [
        currentWeatherData,
        localWeatherData,
        globalWeatherData,
        fiveDaysData,
      ];
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);

  @override
  List<Object> get props => [message];
}
