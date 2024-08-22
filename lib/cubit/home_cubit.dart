import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/model/current_weather_data.dart';
import '/model/five_days_data.dart';
import '/service/weather_service.dart';

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

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherLoading());

  Future<void> loadWeatherData(
      List<String> localCities, List<String> globalCities, String city) async {
    emit(WeatherLoading());

    try {
      final weatherService = WeatherService(city: city);

      final currentWeatherData = await weatherService.getCurrentWeatherData();

      final localWeatherData = await Future.wait(
        localCities.map((localCity) async {
          final service = WeatherService(city: localCity);
          return await service.getCurrentWeatherData();
        }),
      );

      final globalWeatherData = await Future.wait(
        globalCities.map((globalCity) async {
          final service = WeatherService(city: globalCity);
          return await service.getCurrentWeatherData();
        }),
      );

      final fiveDaysData =
          await weatherService.getFiveDaysThreeHoursForecastData();

      emit(WeatherLoaded(
        currentWeatherData: currentWeatherData,
        localWeatherData: localWeatherData,
        globalWeatherData: globalWeatherData,
        fiveDaysData: fiveDaysData,
      ));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
