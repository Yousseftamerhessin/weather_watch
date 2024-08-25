import 'package:bloc/bloc.dart';
import 'package:weather_app/cubit/weather_State.dart';
import '/model/current_weather_data.dart';
import '/service/weather_service.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherLoading());

  final List<String> localCities = [
    'cairo',
    'giza',
    'alexandria',
    'ismailia',
    'fayoum'
  ];

  final List<String> globalCities = [
    'New York',
    'London',
    'Tokyo',
    'Paris',
    'Sydney',
    'Berlin',
    'Moscow',
    'Istanbul',
    'Rome',
    'Dubai'
  ];

  Future<CurrentWeatherData> _fetchCurrentWeatherData(String city) async {
    final weatherService = WeatherService(city: city);
    final currentWeatherData = await weatherService.getCurrentWeatherData();
    return currentWeatherData;
  }

  Future<List<CurrentWeatherData>> _fetchWeatherDataForCities(
      List<String> cities) async {
    try {
      final futures = cities.map((city) async {
        try {
          final service = WeatherService(city: city);
          return await service.getCurrentWeatherData();
        } catch (e) {
          print('Error fetching data for city: $city, error: $e');
          return null;
        }
      }).toList();

      final results = await Future.wait(futures);

      return results.whereType<CurrentWeatherData>().toList();
    } catch (e) {
      print('Error in _fetchWeatherDataForCities: $e');
      throw Exception('Failed to load weather data for cities');
    }
  }

  Future<void> loadWeatherData(String city) async {
    emit(WeatherLoading());

    try {
      final currentWeatherData = await _fetchCurrentWeatherData(city);
      final localWeatherData = await _fetchWeatherDataForCities(localCities);
      final globalWeatherData = await _fetchWeatherDataForCities(globalCities);
      final fiveDaysData =
          await WeatherService(city: city).getFiveDaysThreeHoursForcastData();

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
