import '../api/api_repository.dart';
import '../model/current_weather_data.dart';
import '../model/five_days_data.dart';

class WeatherService {
  final String city;

  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String apiKey = 'appid=dfabd9c375999e248e2468f1289d0cca';

  WeatherService({required this.city});

  Future<CurrentWeatherData> getCurrentWeatherData() async {
    final url = '$baseUrl/weather?q=$city&lang=en&$apiKey';

    try {
      final response = await ApiRepository(url: url).get();
      if (response.containsKey('main')) {
        return CurrentWeatherData.fromJson(response);
      } else {
        throw Exception('Invalid response data: ${response.toString()}');
      }
    } catch (error) {
      print('Error fetching current weather data: $error');
      throw Exception('Failed to load current weather data: $error');
    }
  }

  Future<List<FiveDayData>> getFiveDaysThreeHoursForcastData() async {
    final url = '$baseUrl/forecast?q=$city&lang=en&$apiKey';

    try {
      final response = await ApiRepository(url: url).get();
      if (response.containsKey('list')) {
        return (response['list'] as List)
            .map((t) => FiveDayData.fromJson(t))
            .toList();
      } else {
        throw Exception('Invalid response data: ${response.toString()}');
      }
    } catch (error) {
      print('Error fetching five days forecast data: $error');
      throw Exception('Failed to load five days forecast data: $error');
    }
  }
}
