import '/api/api_repository.dart';
import '/model/current_weather_data.dart';
import '/model/five_days_data.dart';

class WeatherService {
  final String city;

  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String apiKey = 'appid=dfabd9c375999e248e2468f1289d0cca';

  WeatherService({required this.city});

  Future<CurrentWeatherData> getCurrentWeatherData() async {
    final url = '$baseUrl/weather?q=$city&lang=en&$apiKey';
    try {
      final data = await ApiRepository(url: url).get();
      return CurrentWeatherData.fromJson(data);
    } catch (error) {
      print('Error fetching current weather data: $error');
      rethrow; // Re-throw the error to be handled elsewhere
    }
  }

  Future<List<FiveDayData>> getFiveDaysThreeHoursForecastData() async {
    final url = '$baseUrl/forecast?q=$city&lang=en&$apiKey';
    try {
      final data = await ApiRepository(url: url).get();
      final list =
          data['list'] as List<dynamic>; // Ensure type is List<dynamic>
      return list.map((item) => FiveDayData.fromJson(item)).toList();
    } catch (error) {
      print('Error fetching five days forecast data: $error');
      rethrow; // Re-throw the error to be handled elsewhere
    }
  }
}
