import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/model/current_weather_data.dart';
import '/model/five_days_data.dart';
import '/service/weather_service.dart';

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

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeLoading());

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

  Future<void> fetchWeatherData(String? city) async {
    emit(HomeLoading());

    try {
      final weatherService =
          city != null && city.isNotEmpty ? WeatherService(city: city) : null;

      final currentWeatherData = city != null && city.isNotEmpty
          ? await weatherService!.getCurrentWeatherData()
          : CurrentWeatherData();

      final dataListLocal = await Future.wait(localCities.map((c) async {
        final service = WeatherService(city: c);
        return await service.getCurrentWeatherData();
      }).toList());

      final dataListGlobal = await Future.wait(globalCities.map((c) async {
        final service = WeatherService(city: c);
        return await service.getCurrentWeatherData();
      }).toList());

      final fiveDaysData = city != null && city.isNotEmpty
          ? await weatherService!.getFiveDaysThreeHoursForecastData()
          : [];

      emit(HomeLoaded(
        currentWeatherData: currentWeatherData,
        dataListLocal: dataListLocal,
        dataListGlobal: dataListGlobal,
        fiveDaysData: [],
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
