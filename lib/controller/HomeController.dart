import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import '/model/current_weather_data.dart';
import '/model/five_days_data.dart';
import '/service/weather_service.dart';

class HomeController extends GetxController {
  String? city;
  String? searchText;

  CurrentWeatherData currentWeatherData = CurrentWeatherData();
  List<CurrentWeatherData> dataList = [];
  List<FiveDayData> fiveDaysData = [];

  List<String> localCities = [
    'cairo',
    'giza',
    'alexandria',
    'ismailia',
    'fayoum'
  ];

  List<String> globalCities = [
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

  HomeController({this.city});

  @override
  void onInit() {
    super.onInit();
    initState();
    getLocalCitiesWeather();
    getGlobalCitiesWeather();
  }

  void updateWeather() {
    initState();
  }

  void initState() {
    getCurrentWeatherData();
    getFiveDaysData(); // التأكد من استدعاء دالة getFiveDaysData
  }

  void getCurrentWeatherData() {
    if (city != null && city!.isNotEmpty) {
      WeatherService(city: '$city').getCurrentWeatherData(onSuccess: (data) {
        currentWeatherData = data;
        update();
      }, onError: (error) {
        print(error);
        update();
      });
    }
  }

  void getLocalCitiesWeather() {
    dataList.clear();
    localCities.forEach((c) {
      WeatherService(city: '$c').getCurrentWeatherData(onSuccess: (data) {
        dataList.add(data);
        update();
      }, onError: (error) {
        print(error);
        update();
      });
    });
  }

  void getGlobalCitiesWeather() {
    globalCities.forEach((c) {
      WeatherService(city: '$c').getCurrentWeatherData(onSuccess: (data) {
        dataList.add(data);
        update();
      }, onError: (error) {
        print(error);
        update();
      });
    });
  }

  void getFiveDaysData() {
    if (city != null && city!.isNotEmpty) {
      WeatherService(city: '$city').getFiveDaysThreeHoursForcastData(
          onSuccess: (data) {
        fiveDaysData = data;
        update();
      }, onError: (error) {
        print(error);
        update();
      });
    }
  }
}
