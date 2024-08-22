import 'package:equatable/equatable.dart';
import 'package:weather_app/model/current_weather_data.dart';
import 'package:weather_app/model/five_days_data.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final CurrentWeatherData currentWeatherData;
  final List<CurrentWeatherData> dataListLocal;
  final List<CurrentWeatherData> dataListGlobal;
  final List<FiveDayData> fiveDaysData;

  HomeLoaded({
    required this.currentWeatherData,
    required this.dataListLocal,
    required this.dataListGlobal,
    required this.fiveDaysData,
  });

  @override
  List<Object> get props => [
        currentWeatherData,
        dataListLocal,
        dataListGlobal,
        fiveDaysData,
      ];
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);

  @override
  List<Object> get props => [message];
}
