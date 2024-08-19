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
    getCurrentLocation();
  }

  void updateWeather() {
    initState();
  }

  void initState() {
    getCurrentWeatherData();
    getFiveDaysData();
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

  void getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        print('Location permission is denied.');
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      ),
    );

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    city = place.locality;
    updateWeather();
  }
}
