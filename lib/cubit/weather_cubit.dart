import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import '/model/current_weather_data.dart';
import '/service/weather_service.dart';
import 'weather_state.dart';
import '../utils/location_handler.dart';
import 'dart:math';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherLoading());

  final List<Map<String, dynamic>> localCities = [
    {'name': 'Cairo', 'lat': 30.0444, 'lon': 31.2357},
    {'name': 'Giza', 'lat': 29.9765, 'lon': 31.1313},
    {'name': 'Alexandria', 'lat': 31.2156, 'lon': 29.9553},
    {'name': 'Ismailia', 'lat': 30.5965, 'lon': 32.2715},
    {'name': 'Fayoum', 'lat': 29.3084, 'lon': 30.8428},
  ];

  Future<List<Map<String, dynamic>>> _getNearestCities(Position position, int limit) async {
    List<Map<String, dynamic>> sortedCities = List.from(localCities);

    sortedCities.sort((a, b) {
      double distanceA = _calculateDistance(position.latitude, position.longitude, a['lat'], a['lon']);
      double distanceB = _calculateDistance(position.latitude, position.longitude, b['lat'], b['lon']);
      return distanceA.compareTo(distanceB);
    });

    return sortedCities.take(limit).toList();
  }

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // بالكيلومترات
    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) => degrees * (pi / 180);

  Future<void> loadWeatherDataFromLocation() async {
    emit(WeatherLoading());

    try {
      // 1. الحصول على الموقع الحالي
      final position = await LocationHandler.getCurrentPosition();
      if (position == null) {
        emit(WeatherError('Unable to retrieve location.'));
        return;
      }

      // 2. أقرب مدينة
      final nearestCities = await _getNearestCities(position, 3);
      final currentCity = nearestCities.first['name'];

      // 3. جلب بيانات الطقس
      final currentWeatherData = await WeatherService(city: currentCity).getCurrentWeatherData();
      final localWeatherData = await Future.wait(
        nearestCities.map(
          (city) => WeatherService(city: city['name']).getCurrentWeatherData(),
        ),
      );

      emit(WeatherLoaded(
        currentWeatherData: currentWeatherData,
        localWeatherData: localWeatherData,
        globalWeatherData: [], // يمكن إضافتها حسب الحاجة
        fiveDaysData: [], // يمكن إضافتها حسب الحاجة
      ));
    } catch (e) {
      emit(WeatherError('Error loading weather data: $e'));
    }
  }

}
